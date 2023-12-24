import 'package:cashflow/domain/_exports.dart';

class CashflowByMonth {
  final List<ExpenseEntity> expenses;
  final List<IncomeEntity> incomes;

  CashflowByMonth({required this.expenses, required this.incomes});
}

class CashflowByYear {
  Map<int, CashflowByMonth> mapOfCashflow = {};

  CashflowByYear();

  void addMonth(int month, CashflowByMonth cashflowByMonth) {
    mapOfCashflow.putIfAbsent(month, () => cashflowByMonth);
  }

  CashflowByMonth? cashflowByMonth(int month) {
    if (mapOfCashflow.containsKey(month)) {
      return mapOfCashflow[month]!;
    }
    return null;
  }
}

class CashflowModelView {
  Map<int, CashflowByYear> mapOfCashflow = {};
  late int currentYear;

  CashflowModelView() {
    currentYear = DateTime.now().year;
  }

  void setYear(int year) {
    currentYear = year;
  }

  void addCashflowByYear(int year, CashflowByYear cashflowByYear) {
    mapOfCashflow[year] = cashflowByYear;
  }

  void addMonth(int month, CashflowByMonth cashflowByMonth) {
    mapOfCashflow.putIfAbsent(currentYear, () => CashflowByYear());
    mapOfCashflow[currentYear]!.addMonth(month, cashflowByMonth);
  }

  CashflowByMonth? getMonth(int month) {
    if (mapOfCashflow.containsKey(currentYear)) {
      return mapOfCashflow[currentYear]!.cashflowByMonth(month);
    }
    return null;
  }
}
