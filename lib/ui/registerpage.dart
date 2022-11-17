import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  static const routeName='/register_page';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _isLoading ? const Center(child: CircularProgressIndicator()):Container(),
            Hero(tag:'Register',
              child: Text('Register Page')),
            const SizedBox(height: 24.0),
            Text('Create your account'),
            const SizedBox(height: 24.0),
            TextField(
              controller:_emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller:_passwordController,
              obscureText: _obscureText,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    icon: Icon( (_obscureText==true) ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    }),
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 8.0),
            MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(16)),
              onPressed: () async{
                setState(() {
                  _isLoading=true;
                });
                try {
                  final navigator = Navigator.of(context);
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  navigator.pop();
                } catch (e) {
                  final snackbar = SnackBar(content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                } finally {
                  _isLoading = false;
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
              child: const Text('Already have an account? Login'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        )
      )
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}