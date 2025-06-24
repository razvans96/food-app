import 'package:food_app/domain/entities/user_profile_status.dart';
import 'package:food_app/domain/repositories/user_repository.dart';
import 'package:food_app/domain/value_objects/user_id.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CheckUserProfileStatusUseCase {
  final UserRepository _userRepository;

  const CheckUserProfileStatusUseCase(this._userRepository);

  Future<UserProfileStatus> execute({
    required UserId userId,
    required String firebaseToken,
  }) async {
    final existsResult = await _userRepository.userExists(userId, firebaseToken);

    if (existsResult.isFailure) {
      return UserProfileStatus.notFound;
    }

    final userExists = existsResult.data ?? false;
    
    if (!userExists) {
      return UserProfileStatus.notFound;
    }

    // Por ahora consideramos que si existe, está completo
    // En el futuro aquí validaríamos campos específicos del perfil
    return UserProfileStatus.complete;
  }
}
