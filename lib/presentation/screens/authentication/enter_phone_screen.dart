import 'package:authentication/presentation/cubits/auth/auth_cubit.dart';
import 'package:authentication/presentation/cubits/verify_phone/verify_phone_cubit.dart';
import 'package:authentication/presentation/screens/authentication/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependency.dart';

class EnterPhoneScreen extends StatefulWidget {
  const EnterPhoneScreen({Key? key}) : super(key: key);

  @override
  State<EnterPhoneScreen> createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends State<EnterPhoneScreen> {
  final numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello',
            ),
            TextFormField(
              controller: numberController,
              decoration: const InputDecoration(
                prefix: Text(
                  '+63',
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider<VerifyPhoneCubit>(
                          create: (context) => sl<VerifyPhoneCubit>()
                            ..verifyPhone(
                              numberController.text.replaceAll(' ', ''),
                            ),
                        ),
                        BlocProvider<AuthCubit>(
                          create: (context) => sl<AuthCubit>(),
                        ),
                      ],
                      child: OtpScreen(
                        number: numberController.text.replaceAll(' ', ''),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('send otp'),
            ),
          ],
        ),
      ),
    );
  }
}
