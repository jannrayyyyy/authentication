// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_phone_state.dart';

class VerifyPhoneCubit extends Cubit<VerifyPhoneState> {
  VerifyPhoneCubit() : super(VerifyPhoneInitial());

  void verifyPhone(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+63$number',
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('complete');
        emit(VerifySuccess(credential.smsCode!));
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        emit(VerifyFailed(e.code));

        // Handle other errors
      },
      codeSent: (String verificationId, int? resendToken) async {
        print('code sent');
        print('verificationId');
        emit(VerifyingNow(id: verificationId, resentToken: resendToken));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
        print('timeout');
        emit(CodeAutoRetrievalTimeout());
      },
      timeout: const Duration(seconds: 60),
    );
  }
}
