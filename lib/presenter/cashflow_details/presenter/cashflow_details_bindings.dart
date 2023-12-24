import 'package:get/get.dart';
import 'package:cashflow/core/settings.dart';
import 'cashflow_details_controller.dart';
import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/external/external.dart';
import 'cashflow_details_by_month_controller.dart';

class CashflowDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<ISettings>(() => Settings());
    Get.lazyReplace<IExpenseDatasource>(
        () => ExpenseDatasource(settings: Get.find()));
    Get.lazyReplace<IGetExpensesByCashflow>(
        () => GetExpensesByCashflow(Get.find()));

    Get.lazyReplace<IIncomeDatasource>(
        () => IncomeDatasource(settings: Get.find()));
    Get.lazyReplace<IGetIncomesByCashflow>(
        () => GetIncomesByCashflow(datasource: Get.find()));
    Get.lazyReplace<IDeleteExpense>(
        () => DeleteExpense(datasource: Get.find()));

    for (final index in List.generate(12, (index) => index)) {
      Get.lazyReplace(
          () => CashflowDetailsByMonthController(
              year: DateTime.now().year,
              month: index + 1,
              getExpensesByCashflow: Get.find(),
              getIncomesByCashflow: Get.find()),
          tag: 'CASHFLOW/$index');
    }

    Get.lazyReplace(() => CashflowDetailsController());
  }
}
