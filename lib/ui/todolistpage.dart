import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/dbprovider.dart';
import 'package:untitled/ui/todoadd_updatepage.dart';

class ToDoListPage extends StatelessWidget {
  const ToDoListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("To Do App"),
      ),
      body: Consumer<DbProvider>(
        builder:(context,provider,child) {
          final arrToDo = provider.todos;
          return ListView.builder(
            itemCount: arrToDo.length,
            itemBuilder: (context,index){
              final todo = arrToDo[index];
              return Dismissible(
                  key: Key(todo.id.toString()),
                  background: Container(color: Colors.red),
                  onDismissed: (direction){

                  },
                  child: Card(
                    child: ListTile(
                      title: Text(todo.title),
                      subtitle: Text(todo.detail),
                      onTap: () async{

                      },
                    )
                  )
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ToAddUpdatePage()));
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}