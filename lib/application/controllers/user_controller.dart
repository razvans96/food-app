import 'package:food_app/domain/entities/user_auth_status.dart';
import 'package:food_app/domain/entities/user_entity.dart';
import 'package:food_app/domain/use_cases/check_user_auth_status_use_case.dart';
import 'package:food_app/domain/use_cases/create_user_use_case.dart';
import 'package:food_app/domain/use_cases/get_user_use_case.dart';
import 'package:food_app/shared/results/operation_result.dart';

class UserController {
  final CreateUserUseCase _createUserUseCase;
  final GetUserUseCase _getUserUseCase;
  final CheckUserAuthStatusUseCase _checkUserAuthStatusUseCase;

  const UserController({
    required CreateUserUseCase createUserUseCase,
    required GetUserUseCase getUserUseCase,
    required CheckUserAuthStatusUseCase checkUserAuthStatusUseCase,
  })  : _createUserUseCase = createUserUseCase,
        _getUserUseCase = getUserUseCase,
        _checkUserAuthStatusUseCase = checkUserAuthStatusUseCase;

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
    return await _getUserUseCase.execute();
  }

  Future<Result<UserEntity>> getUserById(String uid) async {
    return await _getUserUseCase.executeWithId(uid);
  }

  Future<UserAuthStatus> checkAuthStatus() async {
    return await _checkUserAuthStatusUseCase.execute();
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

  Future<bool> isUserAuthenticated() async {
    final status = await checkAuthStatus();
    return status != UserAuthStatus.notAuthenticated;
  }

  Future<bool> needsProfileCompletion() async {
    final status = await checkAuthStatus();
    return status == UserAuthStatus.profileIncomplete;
  }

  Future<bool> isUserReady() async {
    final status = await checkAuthStatus();
    return status == UserAuthStatus.ready;
  }
}
