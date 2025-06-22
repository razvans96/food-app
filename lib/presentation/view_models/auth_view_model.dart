import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/domain/entities/user_auth_status.dart';
import 'package:food_app/domain/use_cases/check_user_auth_status_use_case.dart';
import 'package:food_app/domain/use_cases/create_user_use_case.dart';
import 'package:food_app/shared/results/operation_result.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthViewModel extends ChangeNotifier {
  final CheckUserAuthStatusUseCase _checkUserAuthStatusUseCase;
  final CreateUserUseCase _createUserUseCase;

  AuthViewModel(this._checkUserAuthStatusUseCase, this._createUserUseCase);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isLogin = true;
  bool isLoading = false;
  String? error;

  User? get currentUser => _firebaseAuth.currentUser;

  void toggleFormType() {
    isLogin = !isLogin;
    error = null;
    notifyListeners();
  }

  Future<bool?> signInWithEmailAndPassword(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      UserCredential userCredential;
      if (isLogin) {
        userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      return userCredential.additionalUserInfo?.isNewUser;
    } on FirebaseAuthException catch (e) {
      error = e.message;
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool?> signInWithGoogle() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential.additionalUserInfo?.isNewUser;
    } on Exception catch (e) {
      error = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registerProfile({
    required String userName,
    required String userSurname,
    required String userPhone,
    required String userDob,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final dateParts = userDob.split('/');
      if (dateParts.length != 3) {
        error = 'Formato de fecha inválido';
        isLoading = false;
        notifyListeners();
        return;
      }

      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);
      final dateOfBirth = DateTime(year, month, day);

      final result = await _createUserUseCase.execute(
        userName: userName,
        userSurname: userSurname,
        dateOfBirth: dateOfBirth,
        userPhone: userPhone.isNotEmpty ? userPhone : null,
      );

      if (result.isFailure) {
        error = 'No se pudo registrar el usuario. ${result.error}';
      }
    } on Exception catch (e) {
      error = 'No se pudo registrar el usuario. Intenta de nuevo. $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> checkUserValidity() async {
    try {
      final authStatus = await _checkUserAuthStatusUseCase.execute();
      
      switch (authStatus) {
        case UserAuthStatus.ready:
          return 'home';
        case UserAuthStatus.profileIncomplete:
          return 'register';
        case UserAuthStatus.notAuthenticated:
          return null;
      }
    } on Exception catch (_) {
      await _firebaseAuth.signOut();
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    notifyListeners();
  }
}
