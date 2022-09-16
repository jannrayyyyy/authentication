// ignore_for_file: avoid_print

import 'dart:async';

import 'package:authentication/presentation/cubits/auth/auth_cubit.dart';
import 'package:authentication/presentation/cubits/verify_phone/verify_phone_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  const OtpScreen({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  //*variables
  final codeController = TextEditingController();
  String verificationId = '';
  String errormsg = '';
  late Timer timer;
  int start = 60;
  bool isWaiting = false;
  bool isResend = false;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            start = 60;
            verificationId = 'ERROR';
            isWaiting = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            start--;
            isWaiting = true;
          });
        }
      }
    });
  }

  void login() async {
    context.read<AuthCubit>().login(
        smsCode: codeController.text,
        id: verificationId,
        pop: () {
          Future.delayed(
            const Duration(milliseconds: 400),
            () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<VerifyPhoneCubit, VerifyPhoneState>(
              listener: (context, state) {
                if (state is VerifyingNow) {
                  print('Verifying now');
                  errormsg = '';
                  verificationId = state.id;
                  codeController.text = '';
                  startTimer();
                  isResend = false;
                  setState(() {});
                } else if (state is VerifyFailed) {
                  print('Verify failed');
                  errormsg = state.message;
                  setState(() {});
                } else if (state is VerifySuccess) {
                  print('Verify success');
                  codeController.text = state.smsCode;
                  setState(() {});
                } else if (state is CodeAutoRetrievalTimeout) {
                  print('CodeAutoRetrievalTimeout');
                  errormsg = 'Otp was expired';
                  setState(() {});
                }
              },
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                onChanged: (value) {
                  print(value);
                },
                animationType: AnimationType.slide,
                controller: codeController,
                keyboardType: TextInputType.number,
                onCompleted: (smsCodeComplete) {
                  setState(() {
                    codeController.text = smsCodeComplete;
                  });
                  login();
                },
                pinTheme: PinTheme(
                  inactiveColor: Colors.grey,
                  selectedFillColor: Colors.grey,
                  inactiveFillColor: Colors.grey,
                  selectedColor: Colors.grey,
                  activeColor: Colors.grey,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 60,
                  fieldWidth: 50,
                ),
              ),
            ),
            isWaiting
                ? TextButton(
                    onPressed: () {},
                    child: Text('Send otp again in $start'),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
