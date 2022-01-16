
import 'package:caixabios/app/modules/cash_flow/expense/create/expense_create_controller.dart';
import 'package:get/instance_manager.dart';

class ExpenseCreateBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => ExpenseCreateController());
  }
}