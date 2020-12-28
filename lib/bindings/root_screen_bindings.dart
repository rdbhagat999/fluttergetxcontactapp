import 'package:fluttergetxcontactapp/controllers/controllers.dart';
import 'package:get/get.dart';

class RootScreenBindings extends Bindings {
  @override
  void dependencies() {
    // eager-loading authController and ContactController, also marking them as permanent
    // so that the same instance is available on different screens when we call Get.find() method
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ContactController>(ContactController(), permanent: true);
    Get.lazyPut<UploadController>(() => UploadController(), fenix: false);
  }
}
