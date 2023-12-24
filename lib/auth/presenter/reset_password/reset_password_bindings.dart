import 'package:get/get.dart';
import 'reset_password_controller.dart';

class ResetPasswordBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyReplace(() => ResetPasswordController());
  }
}
