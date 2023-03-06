import 'package:cashflow/domain/domain.dart';
import 'package:get/get.dart';
import 'home.dart';

class HomeController extends GetxController with StateMixin<HomeState> {
  final IGetExpenses getExpenses;
  final IGetIncomes getIncomes;

  HomeController({required this.getExpenses, required this.getIncomes});

  final CashflowModelView cashflow = CashflowModelView();

  @override
  void onInit() async {
    super.onInit();
    change(HomeState.loading(), status: RxStatus.loading());
    searchByMonth(month: DateTime.now().month);
  }

  void searchByMonth({int month = 1}) async {
    final cashflowByMonth = cashflow.getMonth(month);
    if (cashflowByMonth != null) {
      change(HomeState.success(expenses: cashflowByMonth.expenses),
          status: RxStatus.success());
    } else {
      final now = DateTime.now();
      final startDate = DateTime.utc(now.year, month, 1);
      final endDate = DateTime.utc(now.year, month, 31);
      final expenses =
          await getExpenses(startDate: startDate, endDate: endDate);
      final incomes = await getIncomes(startDate: startDate, endDate: endDate);
      cashflow.addMonth(
          month, CashflowByMonth(expenses: expenses, incomes: incomes));
      change(HomeState.success(expenses: expenses, incomes: incomes),
          status: RxStatus.success());
    }
  }
}
