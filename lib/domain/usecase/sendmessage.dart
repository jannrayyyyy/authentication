import 'package:authentication/domain/repository/firebase_repository.dart';

class SendChat {
  final FirebaseRepository repo;
  SendChat({
    required this.repo,
  });

  Future<void> call(
    String msg,
    String chatUid,
    String userId,
    String friendNumber,
  ) async {
    await repo.sendMessage(
      msg,
      chatUid,
      userId,
      friendNumber,
    );
  }
}
