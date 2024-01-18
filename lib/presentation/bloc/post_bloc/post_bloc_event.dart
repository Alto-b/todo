part of 'post_bloc_bloc.dart';

sealed class PostBlocEvent extends Equatable {
  const PostBlocEvent();

  @override
  List<Object> get props => [];
}

class TodoPostEvent extends PostBlocEvent{
  String title;
  String description;
  TodoPostEvent({required this.title,required this.description});

  
}