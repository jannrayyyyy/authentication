import 'package:authentication/firebase_options.dart';
import 'package:authentication/presentation/cubits/auth/auth_cubit.dart';
import 'package:authentication/presentation/cubits/chat/chat_cubit.dart';
import 'package:authentication/presentation/cubits/users/users_cubit.dart';
import 'package:authentication/presentation/cubits/verify_phone/verify_phone_cubit.dart';
import 'package:authentication/presentation/screens/authentication/auth_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF66CDAA),
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Color(0xFF66CDAA),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: const Color(0xFF66CDAA),
          linearTrackColor: Colors.grey.shade200,
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => sl<AuthCubit>()..userCheck(),
          ),
          BlocProvider<VerifyPhoneCubit>(
            create: (context) => sl<VerifyPhoneCubit>(),
          ),
          BlocProvider<UsersCubit>(
            create: (context) => sl<UsersCubit>()
              ..fetchUsers(FirebaseAuth.instance.currentUser!.uid),
          ),
          BlocProvider<ChatCubit>(
            create: (context) => sl<ChatCubit>(),
          ),
        ],
        child: const AuthManager(),
      ),
    );
  }
}
