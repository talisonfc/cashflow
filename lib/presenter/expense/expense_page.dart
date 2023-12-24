import 'package:cashflow/presenter/presenter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:origami/origami.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FloatingBottomSheet extends StatelessWidget {
  final Widget child;
  final String title;

  const FloatingBottomSheet(
      {Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: child);
  }
}

class ExpensePage extends GetView<ExpenseController> {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Saída'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ReactiveForm(
                  formGroup: controller.formGroup,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      const ReactiveTextFieldWidget(
                          label: ExpenseLabel.DESCRIPTION,
                          formControlName: ExpenseConstants.DESCRIPTION),
                      ReactiveDateTimeInput(
                          label: ExpenseLabel.WHEN,
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 265)),
                          lastDate: DateTime.now(),
                          formControlName: ExpenseConstants.WHEN),
                      CategoryDropdown(),
                      ContextDropdown(),
                      const ReactiveTextFieldWidget(
                          label: ExpenseLabel.VALUE,
                          keyboardType: TextInputType.number,
                          formControlName: ExpenseConstants.VALUE),
                    ],
                  )),
            ),
            Obx(() => Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(.2),
                  child: Wrap(
                    spacing: 8,
                    alignment: WrapAlignment.end,
                    children: [
                      Button(
                        label: 'Cancelar',
                        onPressed: () {},
                      ),
                      ButtonWithLoading(
                        onPressed: () async {
                          // if (controller.formGroup.valid) {
                          if (await controller.save()) {
                            Get.back();
                          }
                          // }
                        },
                        requestingLabel: 'Salvando...',
                        label: 'Salvar',
                        loading: controller.loading.value,
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
