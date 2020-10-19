import 'package:flutter/material.dart';
import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:fluttergetxcontactapp/views/views.dart';
import 'package:get/get.dart';

class RootScreen extends StatelessWidget {
  static const pageId = 'root_screen';

  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) =>
          Get.lazyPut<AuthController>(() => AuthController(), fenix: false),
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
