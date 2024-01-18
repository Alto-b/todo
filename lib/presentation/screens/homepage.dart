

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/model/todo_model.dart';
import 'package:todo/presentation/bloc/fetch_bloc/todo_bloc.dart';
import 'package:todo/presentation/screens/add.dart';
import 'package:http/http.dart' as http;
import 'package:todo/domain/repository/home_repository.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    HomeRepository rep;
    return BlocProvider(
      create: (context) => TodoBloc(HomeRepository())..add(TodoLoadedEvent()),
      child: Scaffold(
          appBar: AppBar(      
            title: Text("toDo"),
          ),
      
          body: Visibility(
            visible: isLoading,
            child: Center(child: Text("Nothing to show")),
            replacement: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) { 
                if(state is TodoLoadingState){
                  return Center(child: CircularProgressIndicator());
                }
                else if(state is TodoLoadedState){
                  List<TodoModel> list =state.todoList;
                  print(list[6].description);
                return ListView.builder(
                            itemCount:list.length ,
                            itemBuilder: (context,index){
                         //     final item =  list[index];
                         //     final id = list[index].sId;
                              return ListTile(
                                leading: Text('${index+1}'),
                                title: Text("${list[index].title}",style: TextStyle(color: Colors.white),),
                                subtitle: Text("${list[index].description}"),
                                trailing: PopupMenuButton(
                                  onSelected: (value){
                                    if(value=='edit'){
                                      // navigateToEdit(item);
                                    }
                                    else if(value=='delete'){
                                      // deleteById(id);
                                    }

                                  },
                                  itemBuilder: (context){
                                  return [
                                    PopupMenuItem(child: Text("edit"),value: 'edit',),
                                    PopupMenuItem(child: Text("delete"),value: 'delete',),
                                  ];
                                }),
                              );
                            });
                }
                else{
                    return CircularProgressIndicator();  
                }
            
              },
            ),
          ),
    
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              navigateToAdd(context);
            }),
        ),
    );
  }

  // Future<void> navigateToEdit(Map item)async{
  //   final route = MaterialPageRoute(builder:(context) => AddPage(todo: item) ,);
  //   await Navigator.push(context, route);
  //   setState(() {
  //     isLoading = true;
  //   });
  //   fetch();
  // }

  Future<void> navigateToAdd(context)async{
    final route = MaterialPageRoute(builder: (context) => AddPage(),);
    await Navigator.push(context, route);
  }

  //   Future<void> fetch()async{
  //   final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
  //   final uri = Uri.parse(url);

  //   final response = await http.get(uri);

  //   if(response.statusCode == 200){
  //     final json = jsonDecode(response.body) ;
  //     final result = json['items'] ;
  //     setState(() {
  //       items = result;
  //     });
  //   }
  //  setState(() {
  //    isLoading = false;
  //  });
    
  // }

  // Future<void> deleteById(String id) async{

  //   final url = "https://api.nstack.in/v1/todos/$id";
  //   final uri = Uri.parse(url);
  //   final response = await http.delete(uri);
  //   if(response.statusCode == 200){
  //     final filtered = items.where((element) => element['_id'] != id).toList();
  //     setState(() {
  //       items = filtered;
  //     });
  //   }
  // }


}