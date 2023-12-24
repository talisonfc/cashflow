import 'package:cashflow/domain/_exports.dart';
import 'package:get/get.dart';
import 'cashflow_by_month_utils.dart';

class ExpensesController extends GetxController
    with StateMixin<List<ExpenseEntity>> {
  ExpensesController({required this.getExpenses, required this.deleteExpense});

  final IGetExpensesByCashflow getExpenses;
  final IDeleteExpense deleteExpense;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    final (year, month) = getParameters();
    loadByYearAndMonth(year, month);
  }

  // (int, int) getParameters() {
  //   final params = Get.parameters;
  //   if (params.isNotEmpty) {
  //     if (params.containsKey('year') && params.containsKey('month')) {
  //       final year = int.parse(params['year']!);
  //       final month = int.parse(params['month']!);
  //       return (year, month);
  //     }
  //   } else {
  //     final now = DateTime.now();
  //     return (now.year, now.month);
  //   }
  //   return (0, 0);
  // }

  void loadByYearAndMonth(int year, int month) {
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0);

    getExpenses(startDate: startDate, endDate: endDate).then((value) {
      if (value.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }
      change(value, status: RxStatus.success());
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void delete(ExpenseEntity expense) {
    deleteExpense(expense).then((value) {
      final expenses = state ?? [];
      expenses.remove(expense);
      change(expenses, status: RxStatus.success());
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}
