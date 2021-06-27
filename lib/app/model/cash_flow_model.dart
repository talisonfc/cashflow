import 'package:caixabios/app/model/expense_model.dart';
import 'package:caixabios/app/model/income_model.dart';

class CashFlowModel {
  DateTime createdAt;
  List<IncomeModel> incomes;
  List<ExpenseModel> expenses;
  double valueLastDay;
  double valueToNextDay;

  CashFlowModel({this.createdAt, this.incomes, this.expenses});

  CashFlowModel.fromJson(Map<String, dynamic> json) {
    createdAt = json["createdAt"] != null ? DateTime.fromMillisecondsSinceEpoch(
        json["createdAt"]) : DateTime.now();
    incomes = json["incomes"] != null
        ? json["incomes"]
        .map<IncomeModel>((ic) => IncomeModel.fromJson(ic))
        .toList()
        : [];
    expenses = json["expenses"] != null
        ? json["expenses"]
        .map<ExpenseModel>((ic) => ExpenseModel.fromJson(ic))
        .toList()
        : [];
    valueLastDay = json["valueLastDay"];
    valueToNextDay = json["valueToNextDay"];
  }

  void addIncome(IncomeModel model) {
    incomes.add(model);
  }

  Map<String, dynamic> toJson() {
    return {
      "valueLastDay": valueLastDay,
      "valueToNextDay": valueToNextDay,
      "incomes": incomes != null ? incomes.map((it) => it.toJson()).toList() : [
      ],
      "expenses": expenses != null
          ? expenses.map((it) => it.toJson()).toList()
          : []
    };
  }

  double get totalIncome {
    double total = 0;
    incomes.forEach((el) {
      if (el != null) {
        total += el.value;
      }
    });
    return total;
  }

  double get saldo {
    return totalIncome + valueLastDay - totalExpense;
  }

  double get totalExpense {
    double total = 0;
    expenses.forEach((el) {
      if (el != null) {
        total += el.value;
      }
    });
    return total;
  }
}
