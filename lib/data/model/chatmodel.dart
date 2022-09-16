// ignore_for_file: overridden_fields

import 'package:authentication/domain/entity/chatentity.dart';

class ChatModel extends ChatEntity {
  @override
  final String uid;
  @override
  final String createdOn;
  @override
  final String friendNumber;
  @override
  final String msg;
  ChatModel({
    required this.uid,
    required this.createdOn,
    required this.friendNumber,
    required this.msg,
  }) : super(
          uid: uid,
          createdOn: createdOn,
          friendNumber: friendNumber,
          msg: msg,
        );

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      uid: json['uid'],
      createdOn: json['createdOn'],
      friendNumber: json['friendNumber'],
      msg: json['msg'],
    );
  }
}
