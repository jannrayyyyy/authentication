part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  const Authenticated({
    required this.user,
  });
}

class UnAuthenticated extends AuthState {}

class Authenticating extends AuthState {}

class Error extends AuthState {}
