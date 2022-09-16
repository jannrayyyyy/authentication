import 'package:authentication/presentation/cubits/users/users_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    context
        .read<UsersCubit>()
        .fetchCurrentUser(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        if (state is CurrentUserLoaded) {
          final user = state.user;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user.username),
                Text(user.createdAt),
                Text(user.phoneNumber),
                Text(user.uid),
                Text(user.lastSignin),
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                  ),
                ),
              ],
            ),
          );
        } else if (state is UserLoading) {
          return const LinearProgressIndicator();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
