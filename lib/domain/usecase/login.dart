import 'package:authentication/domain/repository/firebase_repository.dart';

class Login {
  final FirebaseRepository repo;
  Login({
    required this.repo,
  });

  Future<void> call({
    required String smsCode,
    required String id,
    required Function pop,
  }) async {
    await repo.login(
      smsCode: smsCode,
      id: id,
      pop: pop,
    );
  }
}
