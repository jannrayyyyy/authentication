// ignore_for_file: avoid_print

import 'package:authentication/data/model/chatmodel.dart';
import 'package:authentication/data/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteDataSource {
  // Future<void> verifyNumber(String number);
  Stream<User?> userCheck();
  Future<void> login({
    required String smsCode,
    required String id,
    required Function pop,
  });
  Stream<List<UserModel>> fetchUsers(String uid);
  Future<UserModel> fetchCurrentUser(String uid);
  Future<void> sendMessage(
    String msg,
    String chatUid,
    String userId,
    String friendNumber,
  );
  Stream<List<ChatModel>> fetchChats(String uid);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  @override
  Future<void> login({
    required String smsCode,
    required String id,
    required Function pop,
  }) async {
    await _auth
        .signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: id,
        smsCode: smsCode,
      ),
    )
        .then(
      (value) async {
        if (value.additionalUserInfo!.isNewUser) {
          await _db.collection('users').doc(value.user!.uid).set({
            'uid': value.user!.uid,
            'phoneNumber': value.user!.phoneNumber,
            'lastSignin': DateTime.now().toString(),
            'createdAt': DateTime.now().toString(),
            'username': '',
          });
        } else {
          print('account already registered');
        }
        print('Success Login');
      },
    ).then((value) => pop());
  }

  @override
  Stream<User?> userCheck() {
    return FirebaseAuth.instance.userChanges();
  }

  @override
  Stream<List<UserModel>> fetchUsers(String uid) {
    return _db
        .collection('users')
        .where('uid', isNotEqualTo: uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => UserModel.fromJson(e.data())).toList());
  }

  @override
  Future<UserModel> fetchCurrentUser(String uid) async {
    final currentUser = await _db.collection('users').doc(uid).get();
    return UserModel.fromJson(currentUser.data()!);
  }

  @override
  Future<void> sendMessage(
    String msg,
    String chatUid,
    String userId,
    String friendNumber,
  ) async {
    if (msg == '') return;
    await _db.collection('chats').doc(chatUid).collection('messages').add({
      'createdOn': DateTime.now().toString(),
      'uid': userId,
      'friendNumber': friendNumber,
      'msg': msg,
    });
  }

  @override
  Stream<List<ChatModel>> fetchChats(String uid) {
    final stream = _db
        .collection('chats')
        .doc(uid)
        .collection('messages')
        .orderBy('createdOn', descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) {
              print(e.data());
              return ChatModel.fromJson(e.data());
            }).toList());

    return stream;
  }
}
