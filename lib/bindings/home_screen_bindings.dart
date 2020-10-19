import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:get/get.dart';

class HomeScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: false);
    Get.lazyPut<ContactController>(() => ContactController(), fenix: false);
    Get.lazyPut<UploadController>(() => UploadController(), fenix: false);
  }
}
