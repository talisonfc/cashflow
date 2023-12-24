import 'package:flutter/material.dart';
import 'package:origami/origami.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'origin_dropdown_input_controller.dart';

class OriginDropdownInput extends GetView<OriginDropdownInputController> {
  const OriginDropdownInput({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return ReactiveDropdownWidget<String>(
          formControlName: 'originId',
          label: 'Origem',
          items: controller.items);
    },
        onLoading: const ReactiveDropdownWidget(
          formControlName: 'originId',
          label: 'Origem',
          isLoading: true,
        ));
  }
}
