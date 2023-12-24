import 'package:cashflow/presenter/income/income.dart';
import 'package:cashflow/presenter/presenter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:origami/molecules/_exports.dart';
import 'package:reactive_forms/reactive_forms.dart';

class IncomePage extends GetView<IncomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrada'),
      ),
      body: controller.obx((state) {
        return ReactiveForm(
            formGroup: controller.form,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ReactiveTextFieldWidget(
                  formControlName: 'name',
                  label: 'Nome',
                ),
                ReactiveDateTimeInput(
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now(),
                    formControlName: 'when',
                    label: 'Data'),
                OriginDropdown(),
                ReactiveTextFieldWidget(
                  formControlName: 'value',
                  label: 'Valor',
                  keyboardType: TextInputType.number,
                ),
              ],
            ));
      }),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background.withOpacity(.2)),
          child: Obx(() {
            return ButtonWithLoading(
              label: 'Salvar',
              requestingLabel: 'Salvando...',
              loading: controller.isLoading.value,
              onPressed: () async {
                if (await controller.save()) {
                  Get.back();
                }
              },
            );
          })),
    );
  }
}
