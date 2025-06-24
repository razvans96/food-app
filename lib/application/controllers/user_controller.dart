import 'package:food_app/domain/entities/user_entity.dart';
import 'package:food_app/domain/entities/user_profile_status.dart';
import 'package:food_app/domain/use_cases/check_user_profile_status_use_case.dart';
import 'package:food_app/domain/use_cases/create_user_use_case.dart';
import 'package:food_app/domain/use_cases/get_user_use_case.dart';
import 'package:food_app/domain/value_objects/user_id.dart';
import 'package:food_app/shared/results/operation_result.dart';

class UserController {
  final CreateUserUseCase _createUserUseCase;
  final GetUserUseCase _getUserUseCase;
  final CheckUserProfileStatusUseCase _checkUserProfileStatusUseCase;

  const UserController({
    required CreateUserUseCase createUserUseCase,
    required GetUserUseCase getUserUseCase,
    required CheckUserProfileStatusUseCase checkUserProfileStatusUseCase,
  })  : _createUserUseCase = createUserUseCase,
        _getUserUseCase = getUserUseCase,
        _checkUserProfileStatusUseCase = checkUserProfileStatusUseCase;

  Future<Result<UserEntity>> createUser({
    required String userName,
    required String userSurname,
    required DateTime dateOfBirth,
    String? userPhone,
  }) async {
    return _createUserUseCase.execute(
      userName: userName,
      userSurname: userSurname,
      dateOfBirth: dateOfBirth,
      userPhone: userPhone,
    );
  }

  Future<Result<UserEntity>> getCurrentUser() async {
    return _getUserUseCase.execute();
  }

  Future<Result<UserEntity>> getUserById(String uid) async {
    return _getUserUseCase.executeWithId(uid);
  }

  Future<UserProfileStatus> checkProfileStatus({
    required UserId userId,
    required String firebaseToken,
  }) async {
    return _checkUserProfileStatusUseCase.execute(
      userId: userId,
      firebaseToken: firebaseToken,
    );
  }

  Future<Result<UserEntity>> completeUserProfile({
    required String userName,
    required String userSurname,
    required DateTime dateOfBirth,
    String? userPhone,
  }) async {
    final result = await createUser(
      userName: userName,
      userSurname: userSurname,
      dateOfBirth: dateOfBirth,
      userPhone: userPhone,
    );

    if (result.isSuccess) {
      return Success(
        'Perfil completado exitosamente. ¡Ya puedes acceder a nuevas funcionalidades!',
        result.data!,
      );
    } else {
      return Failure(
        'No se pudo completar el perfil: ${result.error}',
      );
    }
  }
}
