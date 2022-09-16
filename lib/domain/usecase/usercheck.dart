import 'package:authentication/domain/repository/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCheck {
  final FirebaseRepository repo;
  UserCheck({
    required this.repo,
  });
  Stream<User?> call() {
    return repo.userCheck();
  }
}
