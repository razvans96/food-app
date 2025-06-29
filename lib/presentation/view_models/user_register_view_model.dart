import 'package:flutter/material.dart';
import 'package:food_app/domain/use_cases/create_user_use_case.dart';
import 'package:food_app/presentation/view_models/states/user_register_state.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UserRegisterViewModel extends ChangeNotifier {
  final CreateUserUseCase _createUserUseCase;

  UserRegisterViewModel(this._createUserUseCase);

  UserRegisterState _state = const UserRegisterState.initial();
  UserRegisterState get state => _state;

  Future<bool> registerProfile({
    required String userName,
    required String userSurname,
    required DateTime userDob,
    String? userPhone,
    List<String>? userDietaryRestrictions,
  }) async {
    _updateState(const UserRegisterState.loading());

    try {
      final result = await _createUserUseCase.execute(
        userName: userName,
        userSurname: userSurname,
        dateOfBirth: userDob,
        userPhone: userPhone,
        userDietaryRestrictions: userDietaryRestrictions
      );

      if (result.isFailure) {
        _updateState(UserRegisterState.error('No se pudo registrar el usuario. ${result.error}'));
        return false;
      }

      _updateState(const UserRegisterState.success());
      return true;

    } on Exception catch (e) {
      _updateState(UserRegisterState.error('No se pudo registrar el usuario. Intenta de nuevo. $e'));
      return false;
    }
  }

  void _updateState(UserRegisterState newState) {
    _state = newState;
    notifyListeners();
  }
}
