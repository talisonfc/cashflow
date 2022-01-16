

import 'package:caixabios/app/modules/cash_flow/income/create/income_create_controller.dart';
import 'package:get/instance_manager.dart';

class IncomeCreateBindings extends Bindings {

  @override
  void dependencies() {
    
    Get.lazyPut(() => IncomeCreateController());
  }
}