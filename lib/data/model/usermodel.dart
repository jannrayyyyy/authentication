import 'package:authentication/domain/entity/userentity.dart';

class UserModel extends UserEntity {
  @override
  String uid;
  @override
  final String username;
  @override
  final String phoneNumber;
  @override
  final String createdAt;
  @override
  final String lastSignin;
  UserModel({
    this.uid = "",
    required this.username,
    required this.phoneNumber,
    required this.createdAt,
    required this.lastSignin,
  }) : super(
          uid: uid,
          username: username,
          phoneNumber: phoneNumber,
          createdAt: createdAt,
          lastSignin: lastSignin,
        );
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      createdAt: json['createdAt'],
      lastSignin: json['lastSignin'],
    );
  }
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      uid: user.uid,
      username: user.username,
      phoneNumber: user.phoneNumber,
      createdAt: user.createdAt,
      lastSignin: user.lastSignin,
    );
  }
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'phoneNumber': phoneNumber,
        'createdAt': createdAt,
        'lastSignin': lastSignin,
      };
}
