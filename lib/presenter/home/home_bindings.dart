import 'package:cashflow/core/settings.dart';
import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/external/external.dart';
import 'package:cashflow/presenter/home/_exports.dart';
import 'package:cashflow/presenter/presenter.dart';
import 'package:get/instance_manager.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<ISettings>(() => Settings());
    // ---------------- REMOVER
    // Get.lazyReplace<IExpenseDatasource>(
    //     () => ExpenseDatasource(settings: Get.find()));
    // Get.lazyReplace<IGetExpensesByCashflow>(
    //     () => GetExpensesByCashflow(Get.find()));

    // Get.lazyReplace<IIncomeDatasource>(
    //     () => IncomeDatasource(settings: Get.find()));
    // Get.lazyReplace<IGetIncomesByCashflow>(
    //     () => GetIncomesByCashflow(datasource: Get.find()));
    // Get.lazyReplace<IDeleteExpense>(
    //     () => DeleteExpense(datasource: Get.find()));

    // for (final index in List.generate(12, (index) => index)) {
    //   Get.lazyReplace(
    //       () => ExpensesController(
    //           getExpenses: Get.find(), deleteExpense: Get.find()),
    //       tag: 'CASHFLOW/$index/EXPENSES');

    //   Get.lazyReplace(() => IncomesController(getIncomes: Get.find()),
    //       tag: 'CASHFLOW/$index/INCOMES');
    // }
    // ----------------

    Get.lazyReplace(() => HomeController());
  }
}
