import 'dart:convert';

import 'package:caixabios/app/model/business_model.dart';
import 'package:caixabios/app/model/cash_flow_model.dart';
import 'package:caixabios/app/model/expense_model.dart';
import 'package:caixabios/app/model/income_model.dart';
import 'package:caixabios/app/types/report_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class CashFlowRepository extends ChangeNotifier {
  Box database;
  CashFlowModel cashFlowModel =
      CashFlowModel(incomes: [], expenses: [], createdAt: DateTime.now());

  CashFlowModel todayCashFlow;

  BusinessModel businessModel = BusinessModel(businessCashFlow: []);
  bool hideValues = false;
  ReportType reportType = ReportType.daily;

  CashFlowRepository() {
    init();
  }

  String query = "";
  DateTime dateTimeFilter = DateTime.now();

  void init() async {
    await Hive.initFlutter();
    database = await Hive.openBox('database');

    if (database.get("business") != null) {
      businessModel = BusinessModel.fromJson(
          JsonDecoder().convert(database.get("business")));
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
      // Configurar o valor inicial do dia como o valor do proximo dia do dia anterior
      double valueLastDay;
      if (tmp.length > 0) {
        CashFlowModel cashFlowModelLastDay = tmp.toList()[tmp.length - 1];
        valueLastDay = cashFlowModelLastDay.valueToNextDay;
      }
      CashFlowModel model = CashFlowModel(
          createdAt: DateTime.now(),
          expenses: [],
          incomes: [],
          valueLastDay: valueLastDay);
      businessModel.addCashFlow(model);
      cashFlowModel = model;
    }

    // cashFlowModel =
    //     CashFlowModel.fromJson(JsonDecoder().convert(database.get("cashFlow")));
    notifyListeners();
  }

  void save() async {
    database.put("business", JsonEncoder().convert(businessModel.toJson()));
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
    notifyListeners();
  }

  void changeReportType(ReportType reportType) {
    this.reportType = reportType;
    notifyListeners();
  }

  void setCashFlow(CashFlowModel cf) {
    cashFlowModel = cf;
    notifyListeners();
  }

  void setTodayCashFlow(){
    cashFlowModel = this.businessModel.businessCashFlow.last;
    // notifyListeners();
  }
}
