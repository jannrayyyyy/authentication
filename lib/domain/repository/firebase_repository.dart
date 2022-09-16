import 'package:authentication/domain/entity/chatentity.dart';
import 'package:authentication/domain/entity/userentity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRepository {
  Future<void> login({
    required String smsCode,
    required String id,
    required Function pop,
  });
  Stream<User?> userCheck();
  Stream<List<UserEntity>> fetchUsers(String uid);
  Future<UserEntity> fetchCurrentUser(String uid);
  Future<void> sendMessage(
    String msg,
    String chatUid,
    String userId,
    String friendNumber,
  );
  Stream<List<ChatEntity>> fetchChats(String uid);
}
