part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UserLoaded extends UsersState {
  final List<UserEntity> users;
  const UserLoaded({
    required this.users,
  });
}

class CurrentUserLoaded extends UsersState {
  final UserEntity user;
  const CurrentUserLoaded({
    required this.user,
  });
}

class UserLoading extends UsersState {}

class UserEmpty extends UsersState {}
