import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';

class AuthService with PrintLogMixin {
  FirebaseAuth _fireAuth = FirebaseAuth.instance;

  Future<UserCredential> registerUser(String email, String password) async {
    UserCredential _authResult = await _fireAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    printLog(_authResult);
    return _authResult;
  }

  Future<UserCredential> loginUser(String email, String password) async {
    UserCredential _authResult = await _fireAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    printLog(_authResult);
    return _authResult;
  }

  Future<void> signOutUser() async {
    await _fireAuth.signOut();
  }
}
