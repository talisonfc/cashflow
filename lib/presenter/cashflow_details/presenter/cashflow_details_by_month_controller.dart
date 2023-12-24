import 'package:cashflow/domain/_exports.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class CashflowDetailsByMonthController extends GetxController
    with StateMixin<List<TransactionEntity>> {
  CashflowDetailsByMonthController(
      {required this.year,
      required this.month,
      required this.getExpensesByCashflow,
      required this.getIncomesByCashflow});

  final int year, month;
  final IGetExpensesByCashflow getExpensesByCashflow;
  final IGetIncomesByCashflow getIncomesByCashflow;

  late String? cashflowId;

  @override
  void onInit() {
    super.onInit();
    final params = Get.parameters;
    cashflowId = params['id'];
    load();
  }

  void load() async {
    try {
      change([], status: RxStatus.loading());
      final transactions = <TransactionEntity>[];
      final expenses = await loadExpensesByYearAndMonth(year, month);
      final incomes = await loadIncomesByYearAndMonth(year, month);
      transactions.addAll(expenses);
      transactions.addAll(incomes);
      if (transactions.isEmpty) {
        change(transactions, status: RxStatus.empty());
        return;
      }
      change(transactions, status: RxStatus.success());
    } catch (error) {
      change([], status: RxStatus.error('Erro ao carregar dados'));
    }
  }

  Future<List<ExpenseEntity>> loadExpensesByYearAndMonth(int year, int month) {
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0);

    return getExpensesByCashflow(
            cashflowId: cashflowId, startDate: startDate, endDate: endDate)
        .then((expenses) {
      return expenses;
    }).catchError((error) {
      throw Exception();
    });
  }

  Future<List<IncomeEntity>> loadIncomesByYearAndMonth(int year, int month) {
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0);

    return getIncomesByCashflow(
            cashflowId: cashflowId, startDate: startDate, endDate: endDate)
        .then((incomes) {
      return incomes;
    }).catchError((error) {
      throw Exception();
    });
  }
}
