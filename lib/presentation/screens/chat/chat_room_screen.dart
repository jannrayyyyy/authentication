// ignore_for_file: avoid_print

import 'package:authentication/presentation/cubits/chat/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ChatRoomScreen extends StatefulWidget {
  final String friendUid;
  final String friendNumber;
  const ChatRoomScreen({
    Key? key,
    required this.friendUid,
    required this.friendNumber,
  }) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final messageController = TextEditingController();
  final chats = FirebaseFirestore.instance.collection('chats');
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  String chatDocId = '';

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();

    super.dispose();
  }

  void clear() {
    messageController.clear();
  }

  void checkUser() async {
    await chats
        .where('users', isEqualTo: {
          currentUserId: null,
          widget.friendUid: null,
        })
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;
                print(chatDocId);
              });
            } else {
              await chats.add({
                'users': {
                  currentUserId: null,
                  widget.friendUid: null,
                },
                'names': {
                  currentUserId: FirebaseAuth.instance.currentUser!.phoneNumber,
                  widget.friendUid: widget.friendNumber,
                }
              }).then((value) {
                chatDocId = value.id;
                print(chatDocId);
              });
            }
          },
        )
        .then((value) {
          print('chat id::: $chatDocId');
          print('value::: $value');
          context.read<ChatCubit>().fetchchats(chatDocId);
        })
        .catchError((error) {
          print('error::::::: $error');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.friendNumber,
          style: TextStyle(
            color: Colors.grey.shade800,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FlutterPhoneDirectCaller.callNumber(widget.friendNumber);
            },
            icon: const Icon(Icons.phone),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is Loaded) {
                  print('Loaded on BlocBuilder');
                  final chats = state.chats;
                  return ListView(
                      reverse: true,
                      children: chats.map((e) {
                        return Align(
                          alignment:
                              e.uid == FirebaseAuth.instance.currentUser!.uid
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: e.uid ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    )
                                  : const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                            ),
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.all(8),
                            child: Text(e.msg),
                          ),
                        );
                      }).toList());
                } else {
                  return const Center(
                    child: Text('say hi'),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'send a message',
                    ),
                    controller: messageController,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<ChatCubit>().message(
                          messageController.text,
                          chatDocId,
                          currentUserId!,
                          widget.friendNumber,
                        );
                    messageController.clear();
                  },
                  icon: const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
