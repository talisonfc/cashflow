
import 'package:caixabios/cash_flow_routes.dart';
import 'package:get/route_manager.dart';

class ReadIncomeIdAction {

  String call(){
    final parameters = Get.parameters;
    return '${parameters[CashFlowRoutes.incomeId]}';
  }
}