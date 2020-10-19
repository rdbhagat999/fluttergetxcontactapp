import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:get/get.dart';

class EditContactScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: false);
    Get.lazyPut<ContactController>(() => ContactController(), fenix: false);
  }
}
