import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/external/cashflow_datasource.dart';
import 'package:get/get.dart';
import 'cashflow_definition_controller.dart';

class CashflowDefinitionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<ICashflowDatasource>(
        () => CashflowDatasource(settings: Get.find()));

    Get.lazyReplace<ICreateCashflow>(
        () => CreateCashflow(datasource: Get.find()));

    Get.lazyReplace<CashflowDefinitionController>(
        () => CashflowDefinitionController(createCashflow: Get.find()));
  }
}
