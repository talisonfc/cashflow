import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:origami/origami.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'origin.dart';

class OriginPage extends GetView<OriginController> {
  const OriginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Origens')),
        body: controller.obx((state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ReactiveForm(
              formGroup: controller.form,
              child: ReactiveInputs(
                formArrayName: 'origins',
                onAdd: () {
                  return FormGroup({
                    'id': FormControl<String>(value: ''),
                    'name': FormControl<String>(
                        value: '', validators: [Validators.required]),
                  });
                },
                onDeleteByIndex: (index) {
                  controller.deleteByIndex(index);
                },
                buildForm: (formGroup) {
                  return Expanded(
                    child: Wrap(
                      children: const [
                        ReactiveInput(
                          label: 'Nome',
                          formControlName: 'name',
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
            onLoading: const Center(
              child: CircularProgressIndicator(),
            )),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(.2)),
            child: Obx(() {
              return ButtonWithLoading(
                label: 'Salvar',
                requestingLabel: 'Salvando...',
                requesting: controller.isLoading.value,
                onPressed: () {
                  controller.save();
                },
              );
            })));
  }
}
