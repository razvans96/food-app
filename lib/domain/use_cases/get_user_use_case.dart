import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/domain/entities/user_entity.dart';
import 'package:food_app/domain/failures/domain_failures.dart';
import 'package:food_app/domain/repositories/user_repository.dart';
import 'package:food_app/domain/value_objects/user_id.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetUserUseCase {
  final UserRepository _userRepository;

  const GetUserUseCase(this._userRepository);

  Future<Result<UserEntity>> execute() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        return const Failure('Usuario no autenticado');
      }

      final firebaseToken = await firebaseUser.getIdToken();
      if (firebaseToken == null) {
        return const Failure('Error de conexión');
      }

      final userId = UserId(firebaseUser.uid);

      return await _userRepository.getUserById(userId, firebaseToken);
      
    } on DomainFailure catch (e) {
      return Failure('Error de validación: $e');
    } on Exception catch (e) {
      return Failure('Error inesperado: $e');
    }
  }

  Future<Result<UserEntity>> executeWithId(String uid) async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        return const Failure('Usuario no autenticado');
      }

      if (firebaseUser.uid != uid) {
        return const Failure('No autorizado para acceder a este usuario');
      }

      final firebaseToken = await firebaseUser.getIdToken();
      if (firebaseToken == null) {
        return const Failure('Error de conexión');
      }

      final userId = UserId(uid);

      return await _userRepository.getUserById(userId, firebaseToken);
      
    } on DomainFailure catch (e) {
      return Failure('Error de validación: $e');
    } on Exception catch (e) {
      return Failure('Error inesperado: $e');
    }
  }
}
