import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  String uid;
  final String username;
  final String phoneNumber;
  final String createdAt;
  final String lastSignin;
  UserEntity({
    this.uid = "",
    required this.username,
    required this.phoneNumber,
    required this.createdAt,
    required this.lastSignin,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        uid,
      ];
}
