import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/domain/model/todo_model.dart';
import 'package:todo/domain/repository/home_repository.dart';


part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  HomeRepository rep ;
  TodoBloc(this.rep) : super(TodoLoadingState()) {

    on<TodoLoadedEvent>((event, emit) async{
      emit(TodoLoadingState());

      try{
        final todo = await rep.fetchApi();
        emit(TodoLoadedState(todo));
      }
      catch(e){
        emit(TodoErrorState());
      }
    }
    );

  }
}
