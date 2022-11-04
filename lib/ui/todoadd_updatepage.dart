import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/dbprovider.dart';

import '../data/model/todo.dart';

class ToAddUpdatePage extends StatefulWidget {
  static const routeName='/toadd_update';
  final Todo? todo;
  const ToAddUpdatePage({super.key, this.todo});
  @override
  State<ToAddUpdatePage> createState() => _ToAddUpdatePageState();
}

class _ToAddUpdatePageState extends State<ToAddUpdatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  bool _isUpdate=false;

  @override
  void initState() {
    super.initState();
    if (widget.todo!=null) {
      _titleController.text = widget.todo!.title;
      _detailController.text = widget.todo!.detail;
      _isUpdate = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children:[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText:'Title'),
            ),
            TextField(
              controller: _detailController,
              decoration: const InputDecoration(labelText:'Detail'),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Save"),
                onPressed: () async{
                  if (!_isUpdate) {
                    final todo = Todo(
                      title: _titleController.text,
                      detail: _detailController.text
                    );
                    Provider.of<DbProvider>(context,listen:false).addTodo(todo);
                  }
                  else {
                    final todo = Todo(
                      id: widget.todo!.id,
                      title: _titleController.text,
                      detail: _detailController.text,
                    );
                    Provider.of<DbProvider>(context,listen:false).updateTodo(todo);
                  }
                  Navigator.pop(context);
                },
              )
            )
          ]
        )
      )
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    super.dispose();
  }
}