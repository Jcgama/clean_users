import 'package:clean_users/features/users/domain/entities/user.dart';

abstract class UsersRepository {
  Future<List<User>> getUsers();
}
