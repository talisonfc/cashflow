import 'package:cashflow/domain/_exports.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/route_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'expense_constants.dart';

class ExpenseController extends GetxController {
  final ISaveExpense saveExpense;

  ExpenseController({required this.saveExpense});

  @override
  void onInit() {
    super.onInit();

    final params = Get.parameters;
    cashflowId = params['id'] ?? '';
  }

  late String cashflowId;

  final FormGroup formGroup = FormGroup({
    ExpenseConstants.VALUE:
        FormControl<double>(value: null, validators: [Validators.required]),
    ExpenseConstants.WHEN:
        FormControl<DateTime>(value: null, validators: [Validators.required]),
    ExpenseConstants.DESCRIPTION:
        FormControl<String>(value: null, validators: [Validators.required]),
    ExpenseConstants.CATEGORY_ID: FormControl<String>(),
    ExpenseConstants.CONTEXT_ID: FormControl<String>(),
  });

  final loading = false.obs;

  Future<bool> save() async {
    loading.value = true;
    try {
      await saveExpense(ExpenseEntity.fromFormGroup(formGroup.value)
          .copyWith(cashflowId: cashflowId));
      loading.value = false;
      return true;
    } catch (e) {
      loading.value = false;
      return false;
    }
  }
}
