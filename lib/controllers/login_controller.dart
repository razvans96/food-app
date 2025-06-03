import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLogin = true;
  bool isLoading = false;
  String? error;

  void toggleFormType() {
    isLogin = !isLogin;
    error = null;
    notifyListeners();
  }

  Future<bool?> submit(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      UserCredential userCredential;
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
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
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // usuario canceló

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.additionalUserInfo?.isNewUser;
    } catch (e) {
      error = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
