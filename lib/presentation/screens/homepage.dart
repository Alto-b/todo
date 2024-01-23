
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/model/todo_model.dart';
import 'package:todo/presentation/bloc/delete_bloc/delete_bloc.dart';
import 'package:todo/presentation/bloc/fetch_bloc/todo_bloc.dart';
import 'package:todo/presentation/screens/add.dart';
import 'package:http/http.dart' as http;
import 'package:todo/domain/repository/home_repository.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

bool isLoading = false;
//  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    // HomeRepository rep;

    return BlocProvider(
      create: (context) => TodoBloc(HomeRepository())..add(TodoLoadedEvent()),
      child: Scaffold(
          appBar: AppBar(      
            title: Text("toDo"),
          ),
      
          body: RefreshIndicator(
            onRefresh: ()async{
              context.read<TodoBloc>().add(TodoLoadedEvent());
            },
            child: Visibility(
              visible: isLoading,
              child: Center(child: Text("Nothing to show")),
              replacement: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) { 
                  if(state is TodoLoadingState){
                    return Center(child: CircularProgressIndicator());
                  }
                  else if(state is TodoLoadedState){
                    List<TodoModel> list =state.todoList;
                    
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
                                        navigateToEdit(context,list[index].sId.toString(),list[index]);
                                      }
                                      else if(value=='delete'){
                                        // deleteById(id);
                                        context.read<DeleteBloc>().add(TodoDeleteEvent(id:list[index].sId.toString()));
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),),(route) => false,);
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
                      return const CircularProgressIndicator();  
                  }
              
                },
              ),
            ),
          ),
    
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              navigateToAdd(context);
            },
            child: const Icon(Icons.add,size: 40,),),
        ),
    );
  }

  Future<void> navigateToAdd(context)async{
    final route = MaterialPageRoute(builder: (context) => AddPage(isEdit: false),);
    await Navigator.push(context, route);
  }

    Future<void> navigateToEdit(context,String id, TodoModel mode)async{
    final route = MaterialPageRoute(builder: (context) => AddPage(id: id,model: mode,isEdit: true),);
    await Navigator.push(context, route);
  }




}