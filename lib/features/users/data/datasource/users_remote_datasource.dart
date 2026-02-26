import 'package:clean_users/features/users/data/models/user_model.dart';
import 'package:dio/dio.dart';

class UsersRemoteDatasource {
  final Dio dio;

  UsersRemoteDatasource(this.dio);

  Future<List<UserModel>> getUsers() async {
    final response = await dio.get('users');
    if (response.statusCode == 200) {
      return (response.data['users'] as List)
          .map((userJson) => UserModel.fromJson(userJson))
          .toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
