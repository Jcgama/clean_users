import 'package:clean_users/features/users/domain/entities/user.dart';
import 'package:clean_users/features/users/domain/repositories/users_repository.dart';
import 'package:clean_users/features/users/domain/usecases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GetUsers', () {
    test('returns users from the repository', () async {
      final expectedUsers = [
        User(id: 7, firstName: 'Ada', email: 'ada@example.com'),
        User(id: 8, firstName: 'Grace', email: 'grace@example.com'),
      ];
      final useCase = GetUsers(FakeUsersRepository(() async => expectedUsers));

      final users = await useCase();

      expect(users, same(expectedUsers));
    });

    test('returns an empty list when the repository has no users', () async {
      final useCase = GetUsers(FakeUsersRepository(() async => []));

      expect(await useCase(), isEmpty);
    });

    test('propagates repository errors', () async {
      final useCase = GetUsers(
        FakeUsersRepository(() async => throw Exception('request failed')),
      );

      await expectLater(
        useCase(),
        throwsA(
          isA<Exception>().having(
            (error) => error.toString(),
            'message',
            'Exception: request failed',
          ),
        ),
      );
    });
  });
}

class FakeUsersRepository implements UsersRepository {
  FakeUsersRepository(this.getUsersHandler);

  final Future<List<User>> Function() getUsersHandler;

  @override
  Future<List<User>> getUsers() => getUsersHandler();
}
