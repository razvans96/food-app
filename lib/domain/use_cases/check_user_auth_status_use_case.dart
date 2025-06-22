import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/domain/entities/user_auth_status.dart';
import 'package:food_app/domain/repositories/user_repository.dart';
import 'package:food_app/domain/value_objects/user_id.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CheckUserAuthStatusUseCase {
  final UserRepository _userRepository;

  const CheckUserAuthStatusUseCase(this._userRepository);

  Future<UserAuthStatus> execute() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      return UserAuthStatus.notAuthenticated;
    }

    try {
      await firebaseUser.reload();
      if (FirebaseAuth.instance.currentUser == null) {
        await FirebaseAuth.instance.signOut();
        return UserAuthStatus.notAuthenticated;
      }
    } on FirebaseException {
      await FirebaseAuth.instance.signOut();
      return UserAuthStatus.notAuthenticated;
    }

    final firebaseToken = await firebaseUser.getIdToken();
    if (firebaseToken == null) {
      throw Exception('No se pudo obtener token de autenticación');
    }

    final userId = UserId(firebaseUser.uid);

    return _checkAuthenticatedUser(userId, firebaseToken);
  }

  Future<UserAuthStatus> _checkAuthenticatedUser(UserId uid, String token) 
    async {
      final existsResult = await _userRepository.userExists(uid, token);

      if (existsResult.isFailure) {
        return UserAuthStatus.notAuthenticated;
      }

      if (existsResult.data ?? false) {
        return UserAuthStatus.ready;
      } else {
        return UserAuthStatus.profileIncomplete;
      }
    }
}
