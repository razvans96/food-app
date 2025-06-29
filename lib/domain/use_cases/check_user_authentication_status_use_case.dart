import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/domain/entities/user_auth_status.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CheckUserAuthenticationStatusUseCase {

  const CheckUserAuthenticationStatusUseCase();

  Future<UserAuthStatus> execute() async {
    try {
    
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        return UserAuthStatus.notAuthenticated;
      }

      final firebaseToken = await firebaseUser.getIdToken();
      if (firebaseToken == null || firebaseToken.isEmpty) {
        await FirebaseAuth.instance.signOut();
        return UserAuthStatus.notAuthenticated;
      }

      return UserAuthStatus.authenticated;
      
    } on FirebaseException {
      await FirebaseAuth.instance.signOut();
      return UserAuthStatus.notAuthenticated;
    }
  }
}
