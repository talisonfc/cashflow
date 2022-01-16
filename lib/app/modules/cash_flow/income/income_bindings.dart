import 'package:caixabios/app/modules/cash_flow/cash_flow_controller.dart';
import 'package:caixabios/app/modules/cash_flow/income/income_controller.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:get/instance_manager.dart';

class IncomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CashFlowRepository());
    Get.lazyPut(() => CashFlowController(cashFlowRepository: Get.find()));
    Get.lazyPut(() => IncomeController(
        cashFlowRepository: Get.find(), cashFlowController: Get.find()));
  }
}
