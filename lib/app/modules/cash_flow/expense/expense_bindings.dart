
import 'package:caixabios/app/modules/cash_flow/cash_flow_controller.dart';
import 'package:caixabios/app/modules/cash_flow/expense/expense_controller.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:get/instance_manager.dart';

class ExpenseBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => CashFlowRepository());
    Get.lazyPut(() => CashFlowController(cashFlowRepository: Get.find()));
    Get.lazyPut(() => ExpenseController(cashFlowController: Get.find()));
  }
}