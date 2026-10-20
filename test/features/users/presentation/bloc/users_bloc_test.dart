import 'package:clean_users/features/users/domain/entities/user.dart';
import 'package:clean_users/features/users/domain/repositories/users_repository.dart';
import 'package:clean_users/features/users/domain/usecases/get_users.dart';
import 'package:clean_users/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_users/features/users/presentation/bloc/users_event.dart';
import 'package:clean_users/features/users/presentation/bloc/users_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UsersBloc', () {
    test('emits loading and loaded states when users are fetched', () async {
      final users = [User(id: 1, firstName: 'Ada', email: 'ada@example.com')];
      final bloc = UsersBloc(
        getUsers: GetUsers(FakeUsersRepository(() async => users)),
      );
      final states = expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<UsersState>((state) => state.status == UsersStatus.loading),
          predicate<UsersState>(
            (state) =>
                state.status == UsersStatus.loaded &&
                state.users?.length == 1 &&
                state.users?.single.firstName == 'Ada',
          ),
        ]),
      );

      expect(bloc.state.status, UsersStatus.initial);
      bloc.add(GetUsersEvent());
      await states;
      await bloc.close();
    });

    test('emits loading and error states when fetching users fails', () async {
      final bloc = UsersBloc(
        getUsers: GetUsers(
          FakeUsersRepository(() async => throw Exception('request failed')),
        ),
      );
      final states = expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<UsersState>((state) => state.status == UsersStatus.loading),
          predicate<UsersState>(
            (state) =>
                state.status == UsersStatus.error &&
                state.errorMessage == 'Exception: request failed',
          ),
        ]),
      );

      bloc.add(GetUsersEvent());
      await states;
      await bloc.close();
    });
  });
}

class FakeUsersRepository implements UsersRepository {
  FakeUsersRepository(this.getUsersHandler);

  final Future<List<User>> Function() getUsersHandler;

  @override
  Future<List<User>> getUsers() => getUsersHandler();
}
