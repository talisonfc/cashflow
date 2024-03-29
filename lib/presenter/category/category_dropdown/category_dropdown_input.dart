import 'package:flutter/material.dart';
import 'package:origami/origami.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'category_dropdown_input_controller.dart';

class CategoryDropdownInput extends GetView<CategoryDropdownInputController> {
  const CategoryDropdownInput({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return ReactiveDropdownWidget<String>(
          formControlName: 'categoryId',
          label: 'Categoria',
          items: controller.items);
    },
        onLoading: const ReactiveDropdownWidget(
          formControlName: 'categoryId',
          label: 'Categoria',
          isLoading: true,
        ));
  }
}
