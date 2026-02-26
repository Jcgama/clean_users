import 'package:clean_users/features/users/domain/entities/user.dart';
import 'package:clean_users/features/users/domain/repositories/users_repository.dart';

class GetUsers {
  final UsersRepository repository;
  GetUsers(this.repository);
  Future<List<User>> call() async {
    return await repository.getUsers();
  }
}
