import 'package:authentication/data/datasource/remote_data_source.dart';
import 'package:authentication/data/repository/firebase_repository.dart';
import 'package:authentication/domain/repository/firebase_repository.dart';
import 'package:authentication/domain/usecase/fetchchats.dart';
import 'package:authentication/domain/usecase/fetchcurrentuser.dart';
import 'package:authentication/domain/usecase/fetchusers.dart';
import 'package:authentication/domain/usecase/login.dart';
import 'package:authentication/domain/usecase/sendmessage.dart';
import 'package:authentication/domain/usecase/usercheck.dart';
import 'package:authentication/presentation/cubits/auth/auth_cubit.dart';
import 'package:authentication/presentation/cubits/chat/chat_cubit.dart';
import 'package:authentication/presentation/cubits/users/users_cubit.dart';
import 'package:authentication/presentation/cubits/verify_phone/verify_phone_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future init() async {
  sl.registerFactory(() => AuthCubit(sl(), sl()));
  sl.registerFactory(() => VerifyPhoneCubit());
  sl.registerFactory(() => UsersCubit(sl(), sl()));
  sl.registerFactory(() => ChatCubit(sl(), sl()));

  sl.registerLazySingleton(() => UserCheck(repo: sl()));
  sl.registerLazySingleton(() => Login(repo: sl()));
  sl.registerLazySingleton(() => FetchUsers(repo: sl()));
  sl.registerLazySingleton(() => FetchCurrentUser(repo: sl()));
  sl.registerFactory(() => SendChat(repo: sl()));
  sl.registerLazySingleton(() => FetchChats(repo: sl()));

  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remote: sl()));

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
}
