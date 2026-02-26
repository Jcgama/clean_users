import 'package:clean_users/features/users/data/datasource/users_remote_datasource.dart';
import 'package:clean_users/features/users/domain/entities/user.dart';
import 'package:clean_users/features/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl  extends UsersRepository {
  final UsersRemoteDatasource remoteDatasource;
  UsersRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<User>> getUsers() async {
    final users = await remoteDatasource.getUsers();
    return users.map((userModel) => User(
          id: userModel.id,
          firstName: userModel.firstName,
          email: userModel.email,
        )).toList();
  }
}