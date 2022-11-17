
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'loginpage.dart';

class DoneTodoPage extends StatelessWidget {
  static const routeName='/done_page';
  final _firestore = FirebaseFirestore.instance;

  DoneTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Done Todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Logout',
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return LoginPage();
              }));
            },
          )
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child:StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                  stream: _firestore.collection('todo').orderBy('dateCreated',descending:true).snapshots(),
                builder: (context,snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 16.0
                      ),
                      children: snapshot.data!.docs.map((document){
                        final data = document.data();
                        /*return ListTile(
                          leading: Text(data['id'].toString()),
                          title: Text(data['title']),
                          subtitle: Text(data['detail']),
                        );*/
                        return Text(data['title']);
                      }).toList(),
                    );
                }
              ),
            ),
          ],
        ),
      )
    );
  }
}
