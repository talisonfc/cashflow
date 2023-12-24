import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../data/data.dart';

class AuthController extends GetxController {
  AuthController({required this.authClient});

  final IAuthClient authClient;

  final isRequesting = false.obs;
  final obscureText = true.obs;

  final formGroup = FormGroup({
    'email': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  @override
  void onInit() {
    super.onInit();

    formGroup.value = {'email': 'tfccivil@gmail.com', 'password': 'k1j23l1k2'};
  }

  void login() {
    isRequesting.value = true;
    Future.delayed(Duration(seconds: 2), () {
      isRequesting.value = false;
    });
  }
}
