import 'package:clean_users/core/dependency_injection.dart';
import 'package:clean_users/features/users/presentation/pages/users_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(MaterialApp(
    home: UsersPage(),
  ));
}
