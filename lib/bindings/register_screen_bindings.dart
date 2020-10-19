import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:get/get.dart';

class RegisterScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
