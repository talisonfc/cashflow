import 'dart:convert';

import 'package:caixabios/app/model/business_model.dart';
import 'package:caixabios/app/model/cash_flow_model.dart';
import 'package:caixabios/app/model/expense_model.dart';
import 'package:caixabios/app/model/income_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class CashFlowRepository extends ChangeNotifier {
  Box database;
  CashFlowModel cashFlowModel =
      CashFlowModel(incomes: [], expenses: [], createdAt: DateTime.now());

  BusinessModel businessModel = BusinessModel(businessCashFlow: []);
  bool hideValues = false;

  CashFlowRepository() {
    init();
  }

  String query = "";
  DateTime dateTimeFilter = DateTime.now();

  void init() async {
    await Hive.initFlutter();
    database = await Hive.openBox('database');

    if (database.get("business") != null) {
      businessModel = BusinessModel.fromJson(JsonDecoder().convert(database.get("business")));
    }

    // get today cashflow, if not exist add to businessCashFlow
    DateTime today = DateTime.now();
    Iterable<CashFlowModel> tmp = businessModel.businessCashFlow
        .where((bcf) =>
            bcf.createdAt.day == today.day &&
            bcf.createdAt.month == today.month &&
            bcf.createdAt.year == today.year);

    if (tmp.isNotEmpty) {
      cashFlowModel = tmp.first;
    } else {
      CashFlowModel model = CashFlowModel(createdAt: DateTime.now(), expenses: [], incomes: []);
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
        .where((it) =>
            it.clientName.contains(query) &&
            it.createdAt.year == dateTimeFilter.year &&
            it.createdAt.month == dateTimeFilter.month &&
            it.createdAt.day == dateTimeFilter.day)
        .toList();
  }

  List<ExpenseModel> get fiteredExpenses {
    return cashFlowModel.expenses
        .where((it) =>
            it.description.contains(query) &&
            it.createdAt.year == dateTimeFilter.year &&
            it.createdAt.month == dateTimeFilter.month &&
            it.createdAt.day == dateTimeFilter.day)
        .toList();
  }

  void changeHideValues() {
    this.hideValues = !this.hideValues;
    notifyListeners();
  }
}
