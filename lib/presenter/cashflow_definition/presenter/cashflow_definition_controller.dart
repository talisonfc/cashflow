import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cashflow/domain/_exports.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CashflowDefinitionController extends GetxController {
  CashflowDefinitionController({required this.createCashflow});

  final ICreateCashflow createCashflow;
  final loading = false.obs;
  late String userId;

  @override
  void onInit() {
    Amplify.Auth.getCurrentUser().then((authUser) {
      userId = authUser.userId;
    });
    super.onInit();
  }

  final formGroup = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
  });

  void submit({VoidCallback? onSuccess, VoidCallback? onError}) {
    loading.value = true;
    createCashflow
        .call(CashflowDefinitionEntity.fromJson(formGroup.value)
            .copyWith(userId: userId))
        .then((value) {
      onSuccess?.call();
    }).catchError((err) {
      loading.value = false;
      onError?.call();
    });
  }
}
