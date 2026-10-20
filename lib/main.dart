import 'package:clean_users/core/dependency_injection.dart';
import 'package:clean_users/features/users/presentation/pages/users_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const CleanUsersApp());
}

class CleanUsersApp extends StatelessWidget {
  const CleanUsersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: UsersPage());
  }
}
