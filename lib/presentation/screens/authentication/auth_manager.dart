import 'package:authentication/presentation/cubits/auth/auth_cubit.dart';
import 'package:authentication/presentation/screens/authentication/enter_phone_screen.dart';
import 'package:authentication/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const HomeScreen();
        } else if (state is Authenticating) {
          return const Scaffold(
            body: Center(
              child: Text('Loading...'),
            ),
          );
        } else {
          return const EnterPhoneScreen();
        }
      },
    );
  }
}
