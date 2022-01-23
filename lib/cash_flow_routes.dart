import 'package:get/route_manager.dart';

class CashFlowRoutes {
  static String cashFlowId = 'cashFlowId';
  static String incomeId = 'incomeId';

  static String initial = '/app';
  static String home = '/home';
  static String workspace = '/workspace';
  static String cashflow = '/cashflow/update/:$cashFlowId';
  static String cashflowSearch = '/cashflow/search';
  static String income = '/income';
  static String addIncome = '/add';
  static String editIncome = '/:$incomeId';
  static String batchIncome = '/batch';
  static String expense = '/expense';
  static String addExpense = '/add';
  static String auth = '/auth';

  static String homePath = '$home';
  static String cashflowPath = '$homePath$cashflow';
  static String incomePath = '$cashflowPath$income';
  static String expensePath = '$cashflowPath$expense';

  static String _cashflowPath(String _cashFlowId) {
    return '$workspace${cashflow.replaceAll(':$cashFlowId', _cashFlowId)}';
  }

  static String _cashflowSearchPath = '$workspace$cashflowSearch';

  static void back() {
    Get.back();
  }

  static toHome(){
    Get.rootDelegate.toNamed(home);
  }

  static toWorkspace(){
    Get.rootDelegate.toNamed(workspace);
  }

  static toAuth(){
    Get.rootDelegate.toNamed(auth);
  }

  static toCashFlow(DateTime dateTime) {
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;
    Get.rootDelegate.toNamed(_cashflowPath('$day-$month-$year'));
  }

  static toCashFlowSearch(){
    Get.rootDelegate.toNamed(_cashflowSearchPath);
  }

  static toIncome(GetDelegate delegate, String _cashFlowId) {
    delegate.toNamed('${_cashflowPath(_cashFlowId)}$income');
  }

  static toExpense(GetDelegate delegate, String _cashFlowId) {
    delegate.toNamed('${_cashflowPath(_cashFlowId)}$expense');
  }

  static dynamic toAddExpense() async {
    final parameters = Get.parameters;
    String _cashFlowId = parameters[CashFlowRoutes.cashFlowId]!;
    return await Get.rootDelegate
        .toNamed('${_cashflowPath(_cashFlowId)}$expense$addExpense');
  }

  static dynamic toAddIncome() async {
    final parameters = Get.parameters;
    String _cashFlowId = parameters[CashFlowRoutes.cashFlowId]!;
    return await Get.rootDelegate
        .toNamed('${_cashflowPath(_cashFlowId)}$income$addIncome');
  }

  static dynamic toBatchIncome() async {
    final parameters = Get.parameters;
    String _cashFlowId = parameters[CashFlowRoutes.cashFlowId]!;
    return await Get.rootDelegate
        .toNamed('${_cashflowPath(_cashFlowId)}$income$batchIncome');
  }
}
