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
  final String fullName;

  @JsonKey(name: 'user_name')
  final String userName;

  @JsonKey(name: 'user_surname')
  final String userSurname;

  @JsonKey(name: 'user_dob')
  final DateTime userDob;

  @JsonKey(name: 'user_profile_completeness_percentage')
  final int profileCompletenessPercentage;

  @JsonKey(name: 'user_is_adult')
  final bool isAdult;

  @JsonKey(name: 'user_phone')
  final String? userPhone;

  @JsonKey(name: 'user_dietary_restrictions')
  final List<String>? userDietaryRestrictions;

  @JsonKey(name: 'user_created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'user_updated_at')
  final DateTime? updatedAt;


  const UserResponseDto({
    required this.userUid,
    required this.userEmail,
    required this.profileCompletenessPercentage,
    required this.isAdult,
    required this.fullName,
    required this.userName,
    required this.userSurname,
    required this.userDob,
    this.userPhone,
    this.userDietaryRestrictions,
    this.createdAt,
    this.updatedAt,
  });

  UserEntity toDomain() {
    return UserEntity(
      id: UserId(userUid),
      email: Email(userEmail),
      name: userName,
      surname: userSurname,
      dateOfBirth: userDob,
      fullName: fullName,
      phone: userPhone,
      dietaryRestrictions: userDietaryRestrictions,
      profileCompletenessPercentage: profileCompletenessPercentage,
      isAdult: isAdult,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseDtoToJson(this);

  @override
  String toString() => 'UserResponseDto(uid: $userUid, email: $userEmail)';
}
