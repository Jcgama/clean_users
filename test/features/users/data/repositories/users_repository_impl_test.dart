import 'package:clean_users/features/users/data/datasource/users_remote_datasource.dart';
import 'package:clean_users/features/users/data/models/user_model.dart';
import 'package:clean_users/features/users/data/repositories/users_repository_impl.dart';
import 'package:clean_users/features/users/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UsersRepositoryImpl', () {
    test('maps remote user models to domain users', () async {
      final datasource = FakeUsersRemoteDatasource([
        UserModel(id: 7, firstName: 'Ada', email: 'ada@example.com'),
        UserModel(id: 8, firstName: 'Grace', email: 'grace@example.com'),
      ]);
      final repository = UsersRepositoryImpl(datasource);

      final users = await repository.getUsers();

      expect(
        users.map((user) => (user.id, user.firstName, user.email)).toList(),
        [(7, 'Ada', 'ada@example.com'), (8, 'Grace', 'grace@example.com')],
      );
      expect(users, everyElement(isA<User>()));
    });
  });
}

class FakeUsersRemoteDatasource extends UsersRemoteDatasource {
  FakeUsersRemoteDatasource(this.users) : super(Dio());

  final List<UserModel> users;

  @override
  Future<List<UserModel>> getUsers() async => users;
}
