import 'package:clean_users/features/users/domain/entities/user.dart';

enum UsersStatus {
  initial,
  loading,
  loaded,
  error,
}


class UsersState {
  final UsersStatus status;
  final List<User>? users;
  final String? errorMessage;

  UsersState._({
    required this.status,
    this.users,
    this.errorMessage,
  });

  factory UsersState.initial() {
    return UsersState._(status: UsersStatus.initial);
  }

  UsersState copyWith({
    UsersStatus? status,
    List<User>? users,
    String? errorMessage,
  }) {
    return UsersState._(
      status: status ?? this.status,
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
