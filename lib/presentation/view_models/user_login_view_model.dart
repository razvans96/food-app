import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/presentation/view_models/states/user_login_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UserLoginViewModel extends ChangeNotifier {
  
  UserLoginViewModel();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserLoginState _state = const UserLoginState.initial();
  UserLoginState get state => _state;

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  void toggleFormType() {
    _isLogin = !_isLogin;
    _updateState(const UserLoginState.initial());
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _updateState(const UserLoginState.loading());

    try {
      if (_isLogin) {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email, 
          password: password,
        );
      } else {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, 
          password: password,
        );
      }

      _updateState(const UserLoginState.success());

    } on FirebaseAuthException catch (e) {
      _updateState(UserLoginState.error(e.message ?? 'Error de autenticación'));
    } on Exception catch (e) {
      _updateState(UserLoginState.error('Error inesperado: $e'));
    }
  }

  Future<void> signInWithGoogle() async {
    _updateState(const UserLoginState.loading());

    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        _updateState(const UserLoginState.initial());
        return; // Usuario cancela
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      _updateState(const UserLoginState.success());

    } on Exception catch (e) {
      _updateState(UserLoginState.error('Error al inciar sesión con Google: $e'));
    }
  }

  void _updateState(UserLoginState newState) {
    _state = newState;
    notifyListeners();
  }
}
