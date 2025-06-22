import 'package:food_app/domain/value_objects/email.dart';
import 'package:food_app/domain/value_objects/user_id.dart';
import 'package:meta/meta.dart';

@immutable
class UserEntity {
  final UserId id;
  final Email email;
  final String? fullName;
  final String? name;
  final String? surname;
  final String? phone;
  final DateTime? dateOfBirth;
  final bool? hasCompleteProfile;
  final bool? isAdult;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  const UserEntity({
    required this.id,
    required this.email,
    this.fullName,
    this.name,
    this.surname,
    this.phone,
    this.dateOfBirth,
    this.hasCompleteProfile,
    this.isAdult,
    this.createdAt, 
    this.updatedAt,
  });

  
  UserEntity copyWith({
    UserId? id,
    Email? email,
    String? name,
    String? surname,
    String? fullName,
    String? phone,
    DateTime? dateOfBirth,
    bool? hasCompleteProfile,
    bool? isAdult,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      hasCompleteProfile: hasCompleteProfile ?? this.hasCompleteProfile,
      isAdult: isAdult ?? this.isAdult,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'UserEntity(id: $id, email: $email, name: $name)';
}
