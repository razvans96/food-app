import 'dart:convert';

import 'package:food_app/application/dto/api_response_dto.dart';
import 'package:food_app/application/dto/user_request_dto.dart';
import 'package:food_app/application/dto/user_response_dto.dart';
import 'package:food_app/domain/entities/user_entity.dart';
import 'package:food_app/domain/repositories/user_repository.dart';
import 'package:food_app/domain/value_objects/user_id.dart';
import 'package:food_app/shared/config/config.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final String baseUrl = AppConfig.apiBaseUrl;

  @override
  Future<Result<UserEntity>> createUser(
      UserEntity user, String firebaseToken) async {
    try {
      final url = Uri.parse('$baseUrl/user');
      final createUserRequestDto = CreateUserRequestDto.fromDomain(user);
      final requestBody = createUserRequestDto.toJson();

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $firebaseToken',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 201) {
        final apiResponse = ApiResponse<UserResponseDto>.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
          (json) => UserResponseDto.fromJson(json! as Map<String, dynamic>),
        );

        if (apiResponse.success && apiResponse.data != null) {
          return Success(
            apiResponse.message,
            apiResponse.data!.toDomain(),
          );
        } else {
          return Failure(apiResponse.error ?? 'Error al crear usuario');
        }
      } else {
        return Failure(
            'Error HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } on Exception catch (e) {
      return Failure('Error de conexión: $e');
    }
  }

  @override
  Future<Result<UserEntity>> getUserById(
      UserId id, String firebaseToken) async {
    try {
      final url = Uri.parse('$baseUrl/user/${id.value}');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $firebaseToken',
        },
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse<UserResponseDto>.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
          (json) => UserResponseDto.fromJson(json! as Map<String, dynamic>),
        );

        if (apiResponse.success && apiResponse.data != null) {
          return Success(
            apiResponse.message,
            apiResponse.data!.toDomain(),
          );
        } else {
          return Failure(apiResponse.error ?? 'Error al obtener usuario');
        }
      } else if (response.statusCode == 404) {
        return const Failure('Usuario no encontrado');
      } else {
        return Failure(
            'Error HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } on Exception catch (e) {
      return Failure('Error de conexión: $e');
    }
  }

  @override
  Future<Result<bool>> userExists(UserId id, String firebaseToken) async {
    try {
      final url = Uri.parse('$baseUrl/user/${id.value}');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $firebaseToken',
        },
      );

      if (response.statusCode == 200) {
        return const Success('Usuario encontrado', true);
      } else if (response.statusCode == 404) {
        return const Success('Usuario no encontrado', false);
      } else {
        return Failure(
            'Error HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } on Exception catch (e) {
      return Failure('Error de conexión: $e');
    }
  }

  @override
  Future<Result<UserEntity>> updateUser(UserEntity user, String firebaseToken) async {
    return const Failure('updateUser pendiente de implementar');
  }
}
