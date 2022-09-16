import 'package:authentication/domain/entity/userentity.dart';
import 'package:authentication/domain/repository/firebase_repository.dart';

class FetchUsers {
  final FirebaseRepository repo;
  FetchUsers({
    required this.repo,
  });

  Stream<List<UserEntity>> call(String uid) {
    return repo.fetchUsers(uid);
  }
}
