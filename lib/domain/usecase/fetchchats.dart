import 'package:authentication/domain/entity/chatentity.dart';
import 'package:authentication/domain/repository/firebase_repository.dart';

class FetchChats {
  final FirebaseRepository repo;
  FetchChats({
    required this.repo,
  });

  Stream<List<ChatEntity>> call(String uid) {
    return repo.fetchChats(uid);
  }
}
