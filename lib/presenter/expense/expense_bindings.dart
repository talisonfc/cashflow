import 'package:cashflow/core/settings.dart';
import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/external/external.dart';
import 'package:get/get.dart';
import 'expense.dart';

class ExpenseBindings extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ISettings>()) {
      Get.lazyReplace<ISettings>(() => Settings());
    }
    if (!Get.isRegistered<IExpenseDatasource>()) {
      Get.lazyReplace<IExpenseDatasource>(
          () => ExpenseDatasource(settings: Get.find()));
    }
    Get.lazyReplace<ISaveExpense>(() => SaveExpense(datasource: Get.find()));

    Get.lazyPut<ExpenseController>(
      () => ExpenseController(saveExpense: Get.find()),
    );
  }
}
