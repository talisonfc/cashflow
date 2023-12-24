import 'package:get/get.dart';
import 'package:origami/origami.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ResetPasswordController extends GetxController {
  final isRequesting = false.obs;

  final formGroup = FormGroup({
    'email': FormControl(validators: [Validators.required, Validators.email])
  });

  void reset() {}
}
