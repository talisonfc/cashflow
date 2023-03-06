import 'package:cashflow/core/core.dart';
import 'package:cashflow/domain/domain.dart';
import 'package:cashflow/external/external.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'category_dropdown_input_controller.dart';
import 'category_dropdown_input.dart';

class CategoryDropdownBindings extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ISettings>()) {
      Get.lazyReplace<ISettings>(() => Settings());
    }
    if (!Get.isRegistered<ICategoryDatasource>()) {
      Get.lazyReplace<ICategoryDatasource>(
          () => CategoryDatasource(settings: Get.find()));
    }
    if (!Get.isRegistered<IGetCategories>()) {
      Get.lazyPut<IGetCategories>(() => GetCategories(Get.find()));
    }
    Get.lazyPut(
        () => CategoryDropdownInputController(getCategories: Get.find()));
  }
}

class CategoryDropdown extends StatelessWidget {
  CategoryDropdown({super.key}) {
    CategoryDropdownBindings().dependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const CategoryDropdownInput();
  }
}
