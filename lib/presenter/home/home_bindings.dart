import 'package:cashflow/core/settings.dart';
import 'package:cashflow/domain/domain.dart';
import 'package:cashflow/external/external.dart';
import 'package:cashflow/presenter/home/home.dart';
import 'package:get/instance_manager.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<ISettings>(() => Settings());
    Get.lazyReplace<IExpenseDatasource>(
        () => ExpenseDatasource(settings: Get.find()));
    Get.lazyReplace<IGetExpenses>(() => GetExpenses(Get.find()));

    Get.lazyReplace<IIncomeDatasource>(
        () => IncomeDatasource(settings: Get.find()));
    Get.lazyReplace<IGetIncomes>(() => GetIncomes(datasource: Get.find()));

    Get.lazyReplace(
        () => HomeController(getExpenses: Get.find(), getIncomes: Get.find()));
  }
}
