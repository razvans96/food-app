import 'package:food_app/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_request_dto.g.dart';

@JsonSerializable()
class CreateUserRequestDto {
  @JsonKey(name: 'user_uid')
  final String userUid;
  
  @JsonKey(name: 'user_email')
  final String userEmail;
  
  @JsonKey(name: 'user_name')
  final String userName;
  
  @JsonKey(name: 'user_surname')
  final String userSurname;
  
  @JsonKey(name: 'user_dob')
  final DateTime userDob;
  
  @JsonKey(name: 'user_phone')
  final String? userPhone;

  @JsonKey(name: 'user_dietary_restrictions')
  final List<String>? userDietaryRestrictions;
  

  const CreateUserRequestDto({
    required this.userUid,
    required this.userEmail,
    required this.userName,
    required this.userSurname,
    required this.userDob,
    this.userPhone,
    this.userDietaryRestrictions,
  });

  factory CreateUserRequestDto.fromDomain(UserEntity entity) {
    return CreateUserRequestDto(
      userUid: entity.id.value,
      userEmail: entity.email.value,
      userName: entity.name,
      userSurname: entity.surname,
      userDob: entity.dateOfBirth,
      userPhone: entity.phone,
      userDietaryRestrictions: entity.dietaryRestrictions,
    );
  }

  factory CreateUserRequestDto.fromJson(Map<String, dynamic> json) => 
      _$CreateUserRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestDtoToJson(this);

  @override
  String toString() => 'CreateUserRequestDto(uid: $userUid, email: $userEmail)';
}

@JsonSerializable()
class UpdateUserRequestDto {
  @JsonKey(name: 'user_name')
  final String? userName;
  
  @JsonKey(name: 'user_surname')
  final String? userSurname;
  
  @JsonKey(name: 'user_dob')
  final DateTime? userDob;

  @JsonKey(name: 'user_phone')
  final String? userPhone;

  @JsonKey(name: 'user_dietary_restrictions')
  final List<String>? userDietaryRestrictions;

  const UpdateUserRequestDto({
    this.userName,
    this.userSurname,
    this.userDob,
    this.userPhone,
    this.userDietaryRestrictions,
  });


  factory UpdateUserRequestDto.fromJson(Map<String, dynamic> json) => 
      _$UpdateUserRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestDtoToJson(this);

  @override
  String toString() => 'UpdateUserRequestDto(name: $userName, surname: $userSurname)';
}
