import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterController extends GetxController {
  final isRequesting = false.obs;

  final formGroup = FormGroup({
    'email': FormControl(),
    'password': FormControl(),
    'confirmPassword': FormControl(),
  });

  void register() {}
}
