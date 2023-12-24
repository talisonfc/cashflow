import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/domain/usecases/cashflow/get_cashflows_by_user.dart';
import 'package:cashflow/external/cashflow_datasource.dart';
import 'package:get/get.dart';
import 'cashflow_availables_controller.dart';

class CashflowAvailablesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<ICashflowDatasource>(
        () => CashflowDatasource(settings: Get.find()));

    Get.lazyReplace<IGetCashflowsByUser>(
        () => GetCashflowsByUser(datasource: Get.find()));

    Get.lazyReplace<CashflowAvailablesController>(
        () => CashflowAvailablesController(getCashflowsByUser: Get.find()));
  }
}
