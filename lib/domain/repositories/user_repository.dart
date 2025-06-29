import 'package:food_app/domain/entities/user_entity.dart';
import 'package:food_app/domain/value_objects/user_id.dart';
import 'package:food_app/shared/results/operation_result.dart';

abstract class UserRepository {
  Future<Result<UserEntity>> createUser(UserEntity user, String firebaseToken);
  Future<Result<UserEntity>> getUserById(UserId id, String firebaseToken);
  Future<Result<bool>> userExists(UserId id, String firebaseToken);
  Future<Result<UserEntity>> updateUser(UserEntity user, String firebaseToken);
}
