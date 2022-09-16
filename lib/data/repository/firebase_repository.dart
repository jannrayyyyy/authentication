import 'package:authentication/data/datasource/remote_data_source.dart';
import 'package:authentication/domain/entity/chatentity.dart';
import 'package:authentication/domain/entity/userentity.dart';
import 'package:authentication/domain/repository/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final RemoteDataSource remote;
  FirebaseRepositoryImpl({
    required this.remote,
  });
  @override
  Future<void> login({
    required String smsCode,
    required String id,
    required Function pop,
  }) async {
    try {
      await remote.login(
        smsCode: smsCode,
        id: id,
        pop: pop,
      );
    } catch (e) {
      print('login error::: $e');
    }
  }

  @override
  Stream<User?> userCheck() {
    try {
      return remote.userCheck();
    } catch (e) {
      print('user check error::: $e');
      rethrow;
    }
  }

  @override
  Stream<List<UserEntity>> fetchUsers(String uid) {
    try {
      return remote.fetchUsers(uid);
    } catch (e) {
      print('fetching user error::: $e');
      rethrow;
    }
  }

  @override
  Future<UserEntity> fetchCurrentUser(String uid) async {
    try {
      return remote.fetchCurrentUser(uid);
    } catch (e) {
      print('fetching current user error::: $e');
      rethrow;
    }
  }

  @override
  Future<void> sendMessage(
      String msg, String chatUid, String userId, String friendNumber) async {
    try {
      await remote.sendMessage(
        msg,
        chatUid,
        userId,
        friendNumber,
      );
    } catch (e) {
      print('send chat error::: $e');
    }
  }

  @override
  Stream<List<ChatEntity>> fetchChats(String uid) {
    try {
      final result = remote.fetchChats(uid);
      return result;
    } catch (e) {
      print('chat error::: $e');
      rethrow;
    }
  }
}
