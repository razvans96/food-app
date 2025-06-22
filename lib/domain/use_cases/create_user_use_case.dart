import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/domain/entities/user_entity.dart';
import 'package:food_app/domain/failures/domain_failures.dart';
import 'package:food_app/domain/repositories/user_repository.dart';
import 'package:food_app/domain/value_objects/email.dart';
import 'package:food_app/domain/value_objects/user_id.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CreateUserUseCase {
  final UserRepository _userRepository;

  const CreateUserUseCase(this._userRepository);

  Future<Result<UserEntity>> execute({
    required String userName,
    required String userSurname,
    required DateTime dateOfBirth,
    String? userPhone,
    
  }) async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      
      if (firebaseUser == null) {
        return const Failure('Usuario no autenticado en Firebase');
      }

      final userId = UserId(firebaseUser.uid);
      final email = Email(firebaseUser.email!);
      
      final newUser = UserEntity(
        id: userId,
        email: email,
        name: userName,
        surname: userSurname,
        phone: userPhone,
        dateOfBirth: dateOfBirth,
      );
      
      return await _userRepository.createUser(newUser);
      
    } on DomainFailure catch (e) {
      return Failure('Datos inválidos: ${e.message}');
    } on Exception catch (e) {
      return Failure('Error inesperado: $e');
    }
  }
}
