import 'package:clean_users/core/dependency_injection.dart';
import 'package:clean_users/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_users/features/users/presentation/bloc/users_event.dart';
import 'package:clean_users/features/users/presentation/bloc/users_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (context) => getIt<UsersBloc>()..add(GetUsersEvent()),
    child: Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state.status == UsersStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.status == UsersStatus.error) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          if (state.status == UsersStatus.loaded) {
            return ListView.builder(
              itemCount: state.users?.length ?? 0,
              itemBuilder: (context, index) {
                final user = state.users![index];
                return ListTile(
                  title: Text(user.firstName),
                  subtitle: Text(user.email),
                );
              },
            );
          }
          return Container();
        },
      ),
    ));
  }
}
