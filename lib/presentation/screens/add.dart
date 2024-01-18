import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todo/presentation/bloc/post_bloc/post_bloc_bloc.dart';

class AddPage extends StatelessWidget {
    final Map? todo;
   AddPage({super.key, this.todo});

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:  Text(isEdit?'edit toDo' : 'add toDo'),
      ),
       body: ListView(
        padding: const EdgeInsets.all(20),
      children:  [
         TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: 'Title'
          ),
        ),
         TextField(
          controller: descriptionController,
          decoration: const InputDecoration(
            hintText: 'Description',
          ),
          keyboardType:TextInputType.multiline,
          maxLines: 8,
          minLines: 5,
        ),const SizedBox(height: 20,),
        // ElevatedButton(onPressed:isEdit?submit(context):submit(context), 
        //   child:  Text(isEdit?'Update':'Submit'))
        ElevatedButton(onPressed: ()=>submit(context), child: Text("add"))
      ],
    ),
    );
  }
void submit(BuildContext context){
  BlocProvider.of<PostBlocBloc>(context).add(
    TodoPostEvent(title: titleController.text, description: descriptionController.text)
  );
}
  // Future<void> update()async{ 
  //   final todo = todo;
  //   if(todo == null){
  //     return;
  //   }
  //   final id = todo['_id'];
  //   final title = titleController.text;
  //   final description = descriptionController.text;
  //   final body = {
  //     "title" : title,
  //     "description" : description,
  //     "is_completed" : false,
  //   };

  //   final url = "https://api.nstack.in/v1/todos/$id";
  //   final uri = Uri.parse(url);
  //   final response = await http.put(
  //     uri,
  //     body: jsonEncode(body),
  //     headers: {'Content-Type':'application/json'});
  //     if(response.statusCode==200){
  //             titleController.text = '';
  //             descriptionController.text='';
  //       showSuccess("Update successfull");
  //     }
  //     else{
  //       showFailed("Update failed");
  //     }
  // }

  // Future<void> submit()async{
  // void showSuccess(String message){
  //   final snackBar = SnackBar(content: Text(message),backgroundColor: Colors.green,);
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  //   void showFailed(String message){
  //   final snackBar = SnackBar(content: Text(message),backgroundColor: Colors.red,);
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}