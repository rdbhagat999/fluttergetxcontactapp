import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:get/get.dart';

class LoginScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
