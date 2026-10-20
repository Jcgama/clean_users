import 'package:clean_users/core/dependency_injection.dart';
import 'package:clean_users/features/users/domain/entities/user.dart';
import 'package:clean_users/features/users/domain/repositories/users_repository.dart';
import 'package:clean_users/features/users/domain/usecases/get_users.dart';
import 'package:clean_users/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_users/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    await getIt.reset();
    getIt.registerFactory<UsersBloc>(
      () => UsersBloc(
        getUsers: GetUsers(
          FakeUsersRepository([
            User(id: 1, firstName: 'Ada', email: 'ada@example.com'),
          ]),
        ),
      ),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('boots the app and displays loaded users', (tester) async {
    await tester.pumpWidget(const CleanUsersApp());
    await tester.pumpAndSettle();

    expect(find.text('Users'), findsOneWidget);
    expect(find.text('Ada'), findsOneWidget);
    expect(find.text('ada@example.com'), findsOneWidget);
  });
}

class FakeUsersRepository implements UsersRepository {
  FakeUsersRepository(this.users);

  final List<User> users;

  @override
  Future<List<User>> getUsers() async => users;
}
