import 'package:authentication/domain/entity/userentity.dart';
import 'package:authentication/domain/repository/firebase_repository.dart';

class FetchCurrentUser {
  final FirebaseRepository repo;
  FetchCurrentUser({
    required this.repo,
  });
  Future<UserEntity> call(String uid) async {
    return await repo.fetchCurrentUser(uid);
  }
}
