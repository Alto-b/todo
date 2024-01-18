import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/domain/repository/home_repository.dart';

part 'post_bloc_event.dart';
part 'post_bloc_state.dart';

class PostBlocBloc extends Bloc<PostBlocEvent, PostBlocState> {
  HomeRepository rep;
  PostBlocBloc(this.rep) : super(PostBlocInitial()) {
    on<TodoPostEvent>((event, emit) async {
        rep.postApi(event.title, event.description);
    });
  }
}
