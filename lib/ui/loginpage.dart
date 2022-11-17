import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/ui/registerpage.dart';
import 'package:untitled/ui/todolistpage.dart';

class LoginPage extends StatefulWidget {
  static const routeName='/login_page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      await _auth.signInWithEmailAndPassword(email: email, password: password);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return ToDoListPage();
                      }));
                    } catch (e) {
                      final snackbar = SnackBar(content: Text(e.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } finally {
                      _isLoading = false;
                    }
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return RegisterPage();
                    }));
                  },
                  child: const Text("Don't have an account? Register here"),
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