part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {

}

class TodoLoadingState extends TodoState {

  @override
  List<Object?> get props =>[];
}


class TodoLoadedState extends TodoState{
   List<TodoModel> todoList = [];
  TodoLoadedState(this.todoList);

  @override
  List<Object?> get props => [todoList];
}

class TodoErrorState extends TodoState{
  String? error;
  TodoErrorState({this.error});

  @override
  List<Object?> get props => [error];
}
