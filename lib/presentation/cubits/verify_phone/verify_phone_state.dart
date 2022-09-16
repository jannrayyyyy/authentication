part of 'verify_phone_cubit.dart';

@immutable
abstract class VerifyPhoneState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyPhoneInitial extends VerifyPhoneState {}

class VerifyingNow extends VerifyPhoneState {
  final String id;
  final int? resentToken;
  VerifyingNow({
    required this.id,
    this.resentToken,
  });
}

class VerifyFailed extends VerifyPhoneState {
  final String message;

  VerifyFailed(this.message);
}

class CodeAutoRetrievalTimeout extends VerifyPhoneState {}

class VerifySuccess extends VerifyPhoneState {
  final String smsCode;

  VerifySuccess(this.smsCode);
}
