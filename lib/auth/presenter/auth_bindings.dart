import 'package:get/get.dart';
import 'auth_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace(() => AuthController(authClient: Get.find()));
  }
}
