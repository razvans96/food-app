import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/domain/entities/user_auth_status.dart';
import 'package:food_app/domain/entities/user_profile_status.dart';
import 'package:food_app/domain/use_cases/check_user_authentication_status_use_case.dart';
import 'package:food_app/domain/use_cases/check_user_profile_status_use_case.dart';
import 'package:food_app/domain/value_objects/user_id.dart';
import 'package:food_app/presentation/view_models/states/authentication_state.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthenticationViewModel extends ChangeNotifier {
  final CheckUserAuthenticationStatusUseCase _checkUserAuthenticationStatusUseCase;
  final CheckUserProfileStatusUseCase _checkUserProfileStatusUseCase;

  AuthenticationViewModel(
    this._checkUserAuthenticationStatusUseCase,
    this._checkUserProfileStatusUseCase,
  ) {
    FirebaseAuth.instance.authStateChanges().listen(_onAuthStateChanged);
  }

  AuthenticationState _state = const AuthenticationState.checking();
  AuthenticationState get state => _state;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> checkAuthenticationStatus() async {
    _updateState(const AuthenticationState.checking());

    try {

      final authStatus = await _checkUserAuthenticationStatusUseCase.execute();
      
      if (authStatus == UserAuthStatus.notAuthenticated) {
        _updateState(const AuthenticationState.guest());
        return;
      }

      final user = FirebaseAuth.instance.currentUser!;
      final token = await user.getIdToken();
      if (token == null) {
        throw Exception('Failed to retrieve Firebase token.');
      }
      
      final profileStatus = await _checkUserProfileStatusUseCase.execute(
        userId: UserId(user.uid),
        firebaseToken: token,
      );

      switch (profileStatus) {
        case UserProfileStatus.complete:
          _updateState(AuthenticationState.authenticated(user));
        case UserProfileStatus.incomplete:
        case UserProfileStatus.notFound:
          _updateState(AuthenticationState.profileIncomplete(user));
      }

    } on Exception {
      await FirebaseAuth.instance.signOut();
      _updateState(const AuthenticationState.guest());
    }
  }

  Future<void> onProfileCompleted() async {
    await checkAuthenticationStatus();
  }

  Future<String> getInitialRoute() async {
    await checkAuthenticationStatus();
    return _state.initialRoute;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _updateState(const AuthenticationState.guest());
  }

  void _onAuthStateChanged(User? user) {
    checkAuthenticationStatus();
  }

  void _updateState(AuthenticationState newState) {
    _state = newState;
    notifyListeners();
  }
}
