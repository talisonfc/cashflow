import 'package:cashflow/domain/domain.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class IncomeController extends GetxController with StateMixin {
  final ICreateIncome createIncome;

  IncomeController({required this.createIncome});

  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'value': FormControl<double>(validators: [Validators.required]),
    'when': FormControl<DateTime>(validators: [Validators.required]),
    'originId': FormControl<String>(validators: [Validators.required]),
  });

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  Future<bool> save() async {
    try {
      isLoading.value = true;
      await createIncome(IncomeEntity.fromFormGroup(form.value));
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }
}
