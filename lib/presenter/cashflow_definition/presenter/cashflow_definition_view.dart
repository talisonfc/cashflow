import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:origami/origami.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'cashflow_definition_controller.dart';
import 'cashflow_definition_bindings.dart';

class CashflowDefinitionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CashflowDefinitionController>(initState: (state) {
      CashflowDefinitionBindings().dependencies();
    }, builder: (controller) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            SizedBox(height: 8),
            Container(
              height: 4,
              width: 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.tertiary),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Novo fluxo de caixa',
                    style: Theme.of(context).textTheme.titleSmall),
                Obx(() => TextButton.icon(
                    onPressed: () {
                      controller.submit(onSuccess: () {
                        Get.back();
                      }, onError: () {
                        Get.snackbar('Erro', 'Erro ao salvar');
                      });
                    },
                    label: Text('Salvar'),
                    icon: controller.loading.value
                        ? Container(
                            padding: EdgeInsets.all(4),
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ))
                        : const Icon(Icons.check_rounded)))
              ],
            ),
            SizedBox(height: 8),
            ReactiveForm(
                formGroup: controller.formGroup,
                child: Column(
                  children: [
                    ReactiveTextField(
                      formControlName: 'name',
                      decoration: InputDecoration(labelText: 'Nome'),
                    )
                  ],
                )),
          ],
        ),
      );
    });
  }
}
