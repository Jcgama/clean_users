import 'dart:async';

import 'package:clean_users/core/dependency_injection.dart';
import 'package:clean_users/features/users/domain/entities/user.dart';
import 'package:clean_users/features/users/domain/repositories/users_repository.dart';
import 'package:clean_users/features/users/domain/usecases/get_users.dart';
import 'package:clean_users/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_users/features/users/presentation/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeUsersRepository repository;

  setUp(() async {
    await getIt.reset();
    repository = FakeUsersRepository();
    getIt.registerFactory<UsersBloc>(
      () => UsersBloc(getUsers: GetUsers(repository)),
    );
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('shows a progress indicator while users are loading', (
    tester,
  ) async {
    final completer = Completer<List<User>>();
    repository.getUsersHandler = () => completer.future;

    await tester.pumpWidget(const MaterialApp(home: UsersPage()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completer.complete([]);
    await tester.pumpAndSettle();
  });

  testWidgets('displays user names and emails after loading', (tester) async {
    repository.getUsersHandler = () async => [
      User(id: 1, firstName: 'Ada', email: 'ada@example.com'),
      User(id: 2, firstName: 'Grace', email: 'grace@example.com'),
    ];

    await tester.pumpWidget(const MaterialApp(home: UsersPage()));
    await tester.pumpAndSettle();

    expect(find.text('Ada'), findsOneWidget);
    expect(find.text('ada@example.com'), findsOneWidget);
    expect(find.text('Grace'), findsOneWidget);
    expect(find.text('grace@example.com'), findsOneWidget);
  });

  testWidgets('displays an error when loading users fails', (tester) async {
    repository.getUsersHandler = () async {
      throw Exception('network unavailable');
    };

    await tester.pumpWidget(const MaterialApp(home: UsersPage()));
    await tester.pumpAndSettle();

    expect(find.text('Error: Exception: network unavailable'), findsOneWidget);
  });
}

class FakeUsersRepository implements UsersRepository {
  Future<List<User>> Function() getUsersHandler = () async => [];

  @override
  Future<List<User>> getUsers() => getUsersHandler();
}
