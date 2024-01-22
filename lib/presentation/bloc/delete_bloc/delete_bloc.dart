import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/domain/repository/home_repository.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  HomeRepository rep;
  DeleteBloc(this.rep) : super(DeleteInitial()) {
    on<TodoDeleteEvent>((event, emit) {
      emit(DeleteInitial());
      rep.deleteApi(event.id);
    });
  }
}
