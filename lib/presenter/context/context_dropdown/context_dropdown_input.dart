import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'context_dropdown_input_controller.dart';
import 'package:origami/origami.dart';

class ContextDropdownInput extends GetView<ContextDropdownInputController> {
  const ContextDropdownInput({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return ReactiveDropdownWidget<String>(
          formControlName: 'contextId',
          label: 'Contexto',
          items: controller.items);
    },
        onLoading: const ReactiveDropdownWidget(
          formControlName: 'contextId',
          label: 'Contexto',
          isLoading: true,
        ));
  }
}
