import 'package:caixabios/app/model/business_model.dart';
import 'package:caixabios/app/model/cash_flow_model.dart';
import 'package:caixabios/app/model/expense_model.dart';
import 'package:caixabios/app/model/income_model.dart';
import 'package:caixabios/app/types/report_type.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CashFlowRepository extends GetxController {
  late DatabaseReference databaseReference;

  // Box database;
  CashFlowModel cashFlowModel =
      CashFlowModel(incomes: [], expenses: [], createdAt: DateTime.now());

  late CashFlowModel todayCashFlow;
  BusinessModel businessModel = BusinessModel();
  bool hideValues = false;
  ReportType reportType = ReportType.daily;

  CashFlowRepository() {
    init();
  }

  String query = "";
  DateTime dateTimeFilter = DateTime.now();

  void init() async {
    // await Hive.initFlutter();
    // database = await Hive.openBox('database');

    databaseReference = FirebaseDatabase.instance.ref('business');
    
    final snapshot = await databaseReference.get();

    if (snapshot.value != null) {
      businessModel = BusinessModel.fromJson(snapshot.value as Map<String, dynamic>);
    }

    // Configurar o valor inicial do dia como o valor do proximo dia do dia anterior
    double valueLastDay = 0;
    if (businessModel.businessCashFlow.length > 0) {
      CashFlowModel cashFlowModelLastDay = businessModel
          .businessCashFlow[businessModel.businessCashFlow.length - 1];
      valueLastDay = cashFlowModelLastDay.valueToNextDay;
    }

    // get today cashflow, if not exist add to businessCashFlow
    DateTime today = DateTime.now();
    Iterable<CashFlowModel> tmp = businessModel.businessCashFlow.where((bcf) =>
        bcf.createdAt.day == today.day &&
        bcf.createdAt.month == today.month &&
        bcf.createdAt.year == today.year);

    if (tmp.isNotEmpty) {
      print("[INFO] load business data");
      cashFlowModel = tmp.first;
    } else {
      print("[INFO] load business data generated");

      CashFlowModel model = CashFlowModel(
          createdAt: DateTime.now(),
          expenses: [],
          incomes: [],
          valueLastDay: valueLastDay);
      // businessModel.addCashFlow(model);
      cashFlowModel = model;
    }

    // cashFlowModel =
    //     CashFlowModel.fromJson(JsonDecoder().convert(database.get("cashFlow")));
  }

  void save() async {
    databaseReference.set(businessModel);
    // database.put("business", JsonEncoder().convert(businessModel.toJson()));
    // database.put("cashFlow", JsonEncoder().convert(cashFlowModel.toJson()));
  }

  void remove(IncomeModel income) {
    cashFlowModel.incomes.remove(income);
    save();
  }

  void addExpense(ExpenseModel expense) {
    cashFlowModel.expenses.add(expense);
    save();
  }

  void setQuery(String v) {
    query = v;
  }

  List<IncomeModel> get fiteredIncomes {
    return cashFlowModel.incomes
        .where((it) => it.clientName == null || it.clientName.contains(query))
        .toList();
  }

  List<ExpenseModel> get fiteredExpenses {
    return cashFlowModel.expenses
        .where((it) => it.description == null || it.description.contains(query))
        .toList();
  }

  void changeHideValues() {
    this.hideValues = !this.hideValues;
  }

  void changeReportType(ReportType? reportType) {
    if (reportType != null) {
      this.reportType = reportType;
    }
  }

  void setCashFlow(CashFlowModel? cf) {
    if (cf != null) {
      cashFlowModel = cf;
    }
  }

  void setTodayCashFlow() {
    cashFlowModel = this.businessModel.businessCashFlow.last;
    //
  }
}
