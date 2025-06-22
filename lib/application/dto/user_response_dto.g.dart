// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseDto _$UserResponseDtoFromJson(Map<String, dynamic> json) =>
    UserResponseDto(
      userUid: json['user_uid'] as String,
      userEmail: json['user_email'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      hasCompleteProfile: json['has_complete_profile'] as bool?,
      isAdult: json['is_adult'] as bool?,
      fullName: json['full_name'] as String?,
      userName: json['user_name'] as String?,
      userSurname: json['user_surname'] as String?,
      userPhone: json['user_phone'] as String?,
      userDob: json['user_dob'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserResponseDtoToJson(UserResponseDto instance) =>
    <String, dynamic>{
      'user_uid': instance.userUid,
      'user_email': instance.userEmail,
      'full_name': instance.fullName,
      'user_name': instance.userName,
      'user_surname': instance.userSurname,
      'user_phone': instance.userPhone,
      'user_dob': instance.userDob,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'has_complete_profile': instance.hasCompleteProfile,
      'is_adult': instance.isAdult,
    };
