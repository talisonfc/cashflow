import 'user_info_controller.dart';
import 'package:get/get.dart';

class UserInfoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace(() => UserInfoController());
  }
}
