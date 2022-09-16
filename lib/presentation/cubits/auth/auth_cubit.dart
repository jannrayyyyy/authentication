import 'package:authentication/domain/usecase/login.dart';
import 'package:authentication/domain/usecase/usercheck.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._login, this._userCheck) : super(AuthInitial());

  final Login _login;
  final UserCheck _userCheck;

  void login({
    required String smsCode,
    required String id,
    required Function pop,
  }) async {
    emit(Authenticating());
    await _login(
      smsCode: smsCode,
      id: id,
      pop: pop,
    );
  }

  void userCheck() async {
    emit(Authenticating());
    final userCheck = _userCheck();
    userCheck.listen((user) {
      user != null ? emit(Authenticated(user: user)) : emit(UnAuthenticated());
    });
  }
}
