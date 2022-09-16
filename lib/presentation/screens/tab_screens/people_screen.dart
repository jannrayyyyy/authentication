import 'package:authentication/presentation/cubits/chat/chat_cubit.dart';
import 'package:authentication/presentation/screens/chat/chat_room_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependency.dart';
import '../../cubits/users/users_cubit.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  final searchController = TextEditingController();
  @override
  void initState() {
    context
        .read<UsersCubit>()
        .fetchUsers(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'search people',
              fillColor: Color(0xFF66CDAA),
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Color(0xFF66CDAA),
              iconColor: Color(0xFF66CDAA),
              focusColor: Color(0xFF66CDAA),
              enabledBorder: InputBorder.none,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
          const Divider(
            color: Colors.black,
            indent: 2,
          ),
          const Text(
            'suggestions',
          ),
          Expanded(
            child: BlocBuilder<UsersCubit, UsersState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return Column(
                    children: state.users
                        .map(
                          (e) => ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider<ChatCubit>(
                                    create: (context) => sl<ChatCubit>(),
                                    child: ChatRoomScreen(
                                      friendUid: e.uid,
                                      friendNumber: e.phoneNumber,
                                    ),
                                  ),
                                ),
                              );
                            },
                            title: Text(e.username),
                            subtitle: Text(e.phoneNumber),
                            trailing: const Icon(Icons.arrow_forward_ios_sharp),
                          ),
                        )
                        .toList(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
