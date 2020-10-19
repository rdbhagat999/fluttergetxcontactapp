import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttergetxcontactapp/mixins/mixins.dart';
import 'package:fluttergetxcontactapp/models/models.dart';

class UserService with PrintLogMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> createNewUser(UserModel user) async {
    await _firestore.collection("users").doc(user.id).set({
      "id": user.id,
      "email": user.email,
    });
    return user;
  }
}
