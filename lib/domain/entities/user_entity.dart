import 'package:food_app/domain/value_objects/email.dart';
import 'package:food_app/domain/value_objects/user_id.dart';
import 'package:meta/meta.dart';

@immutable
class UserEntity {
  final UserId id;
  final Email email;
  final String? fullName;
  final String name;
  final String surname;
  final DateTime dateOfBirth;
  final String? phone;
  final List<String>? dietaryRestrictions;
  final int? profileCompletenessPercentage;
  final bool? isAdult;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.dateOfBirth,
    this.fullName,
    this.phone,
    this.dietaryRestrictions,
    this.profileCompletenessPercentage,
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
    List<String>? dietaryRestrictions,
    int? profileCompletenessPercentage,
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
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileCompletenessPercentage:
          profileCompletenessPercentage ?? this.profileCompletenessPercentage,
      isAdult: isAdult ?? this.isAdult,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'UserEntity(id: $id, email: $email, name: $name)';
}
