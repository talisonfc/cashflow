import 'package:cashflow/domain/_exports.dart';
import 'package:get/get.dart';
import 'cashflow_by_month_utils.dart';

class IncomesController extends GetxController
    with StateMixin<List<IncomeEntity>> {
  IncomesController({required this.getIncomes});

  final IGetIncomesByCashflow getIncomes;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    final (year, month) = getParameters();
    loadIncomesByYearAndMonth(year, month);
  }

  void loadIncomesByYearAndMonth(int year, int month) {
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0);

    getIncomes(startDate: startDate, endDate: endDate).then((value) {
      if (value.isEmpty) {
        change([], status: RxStatus.empty());
        return;
      }
      change(value, status: RxStatus.success());
    }).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}
