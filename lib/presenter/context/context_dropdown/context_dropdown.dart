import 'package:cashflow/core/core.dart';
import 'package:cashflow/external/context_datasource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'context_dropdown_input_controller.dart';
import 'context_dropdown_input.dart';
import 'package:cashflow/domain/_exports.dart';

class ContextDrodownBindings extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ISettings>()) {
      Get.lazyReplace<ISettings>(() => Settings());
    }
    if (!Get.isRegistered<IContextDatasource>()) {
      Get.lazyReplace<IContextDatasource>(
          () => ContextDatasource(settings: Get.find()));
    }
    if (!Get.isRegistered<IGetContexts>()) {
      Get.lazyPut<IGetContexts>(() => GetContexts(Get.find()));
    }
    Get.lazyPut(() => ContextDropdownInputController(getContexts: Get.find()));
  }
}

class ContextDropdown extends StatelessWidget {
  ContextDropdown({super.key}) {
    ContextDrodownBindings().dependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const ContextDropdownInput();
  }
}
