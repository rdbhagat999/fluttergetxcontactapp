import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttergetxcontactapp/helpers/helpers.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';
import 'package:fluttergetxcontactapp/models/models.dart';
import 'package:fluttergetxcontactapp/services/services.dart';
import 'package:fluttergetxcontactapp/views/views.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController with PrintLogMixin {
  FirebaseAuth _fireAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  Rx<User> _firebaseUser = Rx<User>();
  User get user => _firebaseUser.value;
  User setUser(User user) => _firebaseUser.value = user;

  @override
  onInit() {
    _firebaseUser.bindStream(_fireAuth.authStateChanges());
  }

  void _createUser(UserCredential _authResult) async {
    try {
      UserModel user = UserModel(
        id: _authResult.user.uid,
        email: _authResult.user.email,
      );
      await _userService.createNewUser(user);

      setUser(_fireAuth.currentUser);
      Get.offAllNamed(HomeScreen.pageId);
    } catch (e) {
      printLog(e);
      Helpers.showSnackbar(title: 'Error', message: e.message);
    }
  }

  Future<void> register(String email, String password) async {
    try {
      UserCredential _authResult =
          await _authService.registerUser(email.trim(), password.trim());

      printLog(_authResult);

      if (_authResult != null && _authResult.user != null) {
        _createUser(_authResult);
      }
    } catch (e) {
      printLog(e);
      Helpers.showSnackbar(title: 'Error', message: e.message);
    }
  }

  void signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential _authResult =
          await _fireAuth.signInWithCredential(credential);

      if (_authResult != null && _authResult.user != null) {
        _createUser(_authResult);
      }
    } catch (e) {
      printLog(e);
      Helpers.showSnackbar(title: 'Error', message: e.message);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential _authResult =
          await _authService.loginUser(email.trim(), password.trim());

      if (_authResult != null && _authResult.user != null) {
        _createUser(_authResult);
      }
    } catch (e) {
      printLog(e);
      Helpers.showSnackbar(title: 'Error', message: e.message);
    }
  }

  void signOutUser() async {
    try {
      await _authService.signOutUser();
      Get.offAllNamed(RootScreen.pageId);
    } catch (e) {
      printLog(e);
      Helpers.showSnackbar(title: 'Error', message: e.message);
    }
  }
}
