import 'package:food_app/domain/entities/user_entity.dart';
import 'package:food_app/domain/value_objects/email.dart';
import 'package:food_app/domain/value_objects/user_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response_dto.g.dart';

@JsonSerializable()
class UserResponseDto {
  @JsonKey(name: 'user_uid')
  final String userUid;

  @JsonKey(name: 'user_email')
  final String userEmail;

  @JsonKey(name: 'full_name')
  final String? fullName;

  @JsonKey(name: 'user_name')
  final String? userName;

  @JsonKey(name: 'user_surname')
  final String? userSurname;

  @JsonKey(name: 'user_phone')
  final String? userPhone;

  @JsonKey(name: 'user_dob')
  final String? userDob;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'has_complete_profile')
  final bool? hasCompleteProfile;

  @JsonKey(name: 'is_adult')
  final bool? isAdult;

  const UserResponseDto({
    required this.userUid,
    required this.userEmail,
    this.createdAt,
    this.hasCompleteProfile,
    this.isAdult,
    this.fullName,
    this.userName,
    this.userSurname,
    this.userPhone,
    this.userDob,
    this.updatedAt,
  });

  // Conversión desde Domain Entity
  factory UserResponseDto.fromDomain(UserEntity entity) {
    return UserResponseDto(
      userUid: entity.id.value,
      userEmail: entity.email.value,
      fullName: entity.fullName,
      userName: entity.name,
      userSurname: entity.surname,
      userPhone: entity.phone,
      userDob: entity.dateOfBirth?.toIso8601String(),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      hasCompleteProfile: entity.hasCompleteProfile,
      isAdult: entity.isAdult,
    );
  }

  UserEntity toDomain() {
    return UserEntity(
      id: UserId(userUid),
      email: Email(userEmail),
      name: userName,
      surname: userSurname,
      phone: userPhone,
      dateOfBirth: userDob != null ? DateTime.parse(userDob!) : null,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt,
      fullName: fullName ?? '',
      hasCompleteProfile: hasCompleteProfile ?? false,
      isAdult: isAdult ?? false,
    );
  }

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseDtoToJson(this);

  @override
  String toString() => 'UserResponseDto(uid: $userUid, email: $userEmail)';
}
