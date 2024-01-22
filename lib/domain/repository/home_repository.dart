import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/domain/model/todo_model.dart';

class HomeRepository{

   Future<List<TodoModel>> fetchApi() async{
    try{
      final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if(response.statusCode == 200){
        print("fetch success ${response.statusCode}");
        print(response.body);
        List json = jsonDecode(response.body)['items'] ;
        List <TodoModel> list =json.map((e) => TodoModel.fromJson(e)).toList();
        return list;
        
      }
    }
    catch(e){
      print("exceptions occured in fetching data");
    }
    throw Exception("failed to fetch data");
  }


  Future<void> postApi(String title, String description)async{
    // print(description);
    final body = {
                "title": title,
                "description": description,
                "is_completed": true
              };
              // print(body);
    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json'
      });

    if(response.statusCode==201){
      print("post success");
      print(response.body);
    }
    else{
      print("post failed");
    }
  }

  Future<void> deleteApi(String id)async{
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri,headers: {'Content-Type': 'application/json'});
    if(response.statusCode==200){
      print("data deleted successfully");
    }
    else{
      print("data deletion failed");
    }
  }

  Future<void> updateApi(String id,String title,String description)async{
    final body = {
      "title" : title,
      "description" : description,
      "is_completed" : false,
    };

    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type':'application/json'});
      if(response.statusCode==200){
             print("data updated successfully");
      }
      else{
        print("data updation failed");
      }
  }

}