import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class AppUser {

  AppUser({
    required this.userUid,
    required this.userEmail,
    this.userName,
    this.userSurname,
    this.userPhone,
    this.userDob,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  final String userUid;
  final String userEmail;
  final String? userName;
  final String? userSurname;
  final String? userPhone;
  final String? userDob;

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
