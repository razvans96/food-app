import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/user.dart';
import 'package:food_app/services/user_register_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isLogin = true;
  bool isLoading = false;
  String? error;

  void toggleFormType() {
    isLogin = !isLogin;
    error = null;
    notifyListeners();
  }

  Future<bool?> signInWithEmailAndPassword(
      String email, String password) async {
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

  /// Iniciar sesión con Google
  Future<bool?> signInWithGoogle() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      // Forzamos la aparición del selector de cuenta de Google
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final googleUser = await googleSignIn.signIn();
      // Si el usuario cancela
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.additionalUserInfo?.isNewUser;
    } on Exception catch (e) {
      error = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Registro de datos adicionales del usuario
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
      final userUid = currentUser?.uid;
      final userEmail = currentUser?.email;
      if (userUid == null || userEmail == null) {
        error = 'Usuario no autenticado. Por favor, inicia sesión.';
        isLoading = false;
        notifyListeners();
        return;
      }

      final appUser = AppUser(
        userUid: userUid,
        userEmail: userEmail,
        userName: userName,
        userSurname: userSurname,
        userPhone: userPhone,
        userDob: userDob,
      );
      await UserRegisterService().registerUser(appUser);
    } on Exception catch (e) {
      error = 'No se pudo registrar el usuario. '
          'Intenta de nuevo. '
          '$e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Cerrar sesión
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    notifyListeners();
  }

  /// Obtener el usuario actual de Firebase
  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> checkUserValidity() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.reload();
        if (_firebaseAuth.currentUser == null) {
          await _firebaseAuth.signOut();
        }
      } on Exception catch (_) {
        await _firebaseAuth.signOut();
      }
    }
  }
}
