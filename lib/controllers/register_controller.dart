import 'package:flutter/material.dart';
import 'package:food_app/services/register_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterController extends ChangeNotifier {
  bool isLoading = false;
  String? error;

  Future<void> submit({
    required String name,
    required String surname,
    required String phone,
    required String dob,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        error = 'Usuario no autenticado. Por favor, inicia sesión.';
        isLoading = false;
        notifyListeners();
        return;
      }
      await RegisterService().registerUser(
        userId: userId,
        name: name,
        surname: surname,
        phone: phone,
        dob: dob,
      );
      isLoading = false;
      notifyListeners();
      // Nav to next page
    } catch (e) {
      error = 'No se pudo registrar el usuario. Intenta de nuevo.';
      isLoading = false;
      notifyListeners();
    }
  }
}