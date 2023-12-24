import 'package:cashflow/core/settings.dart';
import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/external/origin_datasource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'origin_dropdown_input_controller.dart';
import 'origin_dropdown_input.dart';

class OriginDropdownBingins extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ISettings>()) {
      Get.lazyReplace<ISettings>(() => Settings());
    }

    if (!Get.isRegistered<IOriginDatasource>()) {
      Get.lazyReplace<IOriginDatasource>(
          () => OriginDatasource(settings: Get.find()));
    }

    if (!Get.isRegistered<IGetOrigins>()) {
      Get.lazyPut<IGetOrigins>(() => GetOrigins(datasource: Get.find()));
    }

    Get.lazyPut<OriginDropdownInputController>(
      () => OriginDropdownInputController(getOrigins: Get.find()),
    );
  }
}

class OriginDropdown extends StatelessWidget {
  OriginDropdown({super.key}) {
    OriginDropdownBingins().dependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const OriginDropdownInput();
  }
}
