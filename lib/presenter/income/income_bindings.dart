import 'package:cashflow/core/settings.dart';
import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/external/external.dart';
import 'package:get/get.dart';
import 'income.dart';

class IncomeBindings extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ISettings>()) {
      Get.lazyReplace<ISettings>(() => Settings());
    }
    if (!Get.isRegistered<IIncomeDatasource>()) {
      Get.lazyReplace<IIncomeDatasource>(
          () => IncomeDatasource(settings: Get.find()));
    }
    Get.lazyReplace<ICreateIncome>(() => CreateIncome(datasource: Get.find()));
    Get.lazyReplace(
        () => IncomeController(createIncome: Get.find<ICreateIncome>()));
  }
}
