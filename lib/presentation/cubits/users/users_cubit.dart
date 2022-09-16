import 'package:authentication/domain/entity/userentity.dart';
import 'package:authentication/domain/usecase/fetchcurrentuser.dart';
import 'package:authentication/domain/usecase/fetchusers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._fetchUsers, this._fetchCurrentUser) : super(UsersInitial());

  final FetchUsers _fetchUsers;
  final FetchCurrentUser _fetchCurrentUser;

  void fetchUsers(String uid) async {
    emit(UserLoading());
    final userStream = _fetchUsers(uid);
    userStream.listen((event) {
      if (event.isEmpty) {
        emit(UserEmpty());
      } else {
        emit(UserLoaded(users: event));
      }
    });
  }

  void fetchCurrentUser(String uid) async {
    emit(UserLoading());
    final user = await _fetchCurrentUser(uid);
    Future.delayed(const Duration(seconds: 1), () {
      emit(CurrentUserLoaded(user: user));
    });
  }
}
