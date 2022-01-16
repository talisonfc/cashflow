import 'package:get/route_manager.dart';

class CashFlowRoutes {
  static String cashFlowId = 'cashFlowId';
  static String incomeId = 'incomeId';

  static String initial = '/app';
  static String home = '/home';
  static String cashflow = '/cashflow/:$cashFlowId';
  static String income = '/income';
  static String addIncome = '/add';
  static String editIncome = '/:$incomeId';
  static String batchIncom = '/batch';
  static String expense = '/expense';
  static String addExpense = '/add';

  static String homePath = '$home';
  static String cashflowPath = '$homePath$cashflow';
  static String incomePath = '$cashflowPath$income';
  static String expensePath = '$cashflowPath$expense';

  static String _cashflowRoute(String _cashFlowId) {
    return '$home${cashflow.replaceAll(':$cashFlowId', _cashFlowId)}';
  }

  static void back() {
    Get.rootDelegate.popRoute();
  }

  static toHome(){
    Get.rootDelegate.toNamed(home);
  }

  static toCashFlow(DateTime dateTime) {
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;
    Get.rootDelegate.toNamed(_cashflowRoute('$day-$month-$year'));
  }

  static toIncome(GetDelegate delegate, String _cashFlowId) {
    delegate.toNamed('${_cashflowRoute(_cashFlowId)}$income');
  }

  static toExpense(GetDelegate delegate, String _cashFlowId) {
    delegate.toNamed('${_cashflowRoute(_cashFlowId)}$expense');
  }

  static dynamic toAddExpense() async {
    final parameters = Get.parameters;
    String _cashFlowId = parameters[CashFlowRoutes.cashFlowId]!;
    return await Get.rootDelegate
        .toNamed('${_cashflowRoute(_cashFlowId)}$expense$addExpense');
  }

  static dynamic toAddIncome() async {
    final parameters = Get.parameters;
    String _cashFlowId = parameters[CashFlowRoutes.cashFlowId]!;
    return await Get.rootDelegate
        .toNamed('${_cashflowRoute(_cashFlowId)}$income$addIncome');
  }

  static dynamic toBatchIncome() async {
    final parameters = Get.parameters;
    String _cashFlowId = parameters[CashFlowRoutes.cashFlowId]!;
    return await Get.rootDelegate
        .toNamed('${_cashflowRoute(_cashFlowId)}$income$batchIncom');
  }
}
