import 'package:flutter/material.dart';
import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:fluttergetxcontactapp/views/views.dart';
import 'package:get/get.dart';

class RootScreen extends StatelessWidget {
  static const pageId = 'root_screen';

  // calling Get.find method to initialize Controller instances
  final AuthController _authCtrl = Get.find();
  final ContactController _contactCtrl = Get.find();
  final UploadController _uploadCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) =>
          Get.lazyPut<AuthController>(() => AuthController(), fenix: true),
      builder: (_) {
        if (Get.find<AuthController>().user?.uid != null) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
