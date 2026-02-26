import 'package:clean_users/features/users/domain/usecases/get_users.dart';
import 'package:clean_users/features/users/presentation/bloc/users_event.dart';
import 'package:clean_users/features/users/presentation/bloc/users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsers getUsers;

  UsersBloc({required this.getUsers}) : super(UsersState.initial()){
    on<GetUsersEvent>(_onGetUsersEvent);
  }

  Future<void> _onGetUsersEvent(GetUsersEvent event, Emitter<UsersState> emit) async {
    emit(state.copyWith(status: UsersStatus.loading));
    try {
      final users = await getUsers();
      emit(state.copyWith(status: UsersStatus.loaded, users: users));
    } catch (e) {
      emit(state.copyWith(status: UsersStatus.error, errorMessage: e.toString()));
    }
  }
}
