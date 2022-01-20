import 'package:caixabios/app/model/expense_model.dart';
import 'package:caixabios/app/model/income_model.dart';
import 'package:caixabios/app/model/payment_type.dart';

class CashFlowModel {
  String? id;
  DateTime createdAt;
  List<IncomeModel> incomes;
  List<ExpenseModel> expenses;
  double valueLastDay;
  double valueToNextDay;
  double saldoCaixaGeral;

  CashFlowModel(
      {required this.createdAt,
      this.incomes = const <IncomeModel>[],
      this.expenses = const <ExpenseModel>[],
      this.valueToNextDay = 0,
      this.valueLastDay = 0,
      this.saldoCaixaGeral = 0});

  factory CashFlowModel.fromJson(Map<String, dynamic> json) {
    return CashFlowModel(
        createdAt: json["createdAt"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["createdAt"])
            : DateTime.now(),
        incomes: json["incomes"] != null
            ? json["incomes"]
                .map<IncomeModel>((ic) => IncomeModel.fromJson(ic))
                .toList()
            : [],
        expenses: json["expenses"] != null
            ? json["expenses"]
                .map<ExpenseModel>((ic) => ExpenseModel.fromJson(ic))
                .toList()
            : [],
        valueLastDay: json["valueLastDay"],
        valueToNextDay: json["valueToNextDay"]);
  }

  CashFlowModel copyWith({
    DateTime? createdAt,
    List<IncomeModel>? incomes,
    List<ExpenseModel>? expenses,
    double? valueLastDay,
    double? valueToNextDay,
    double? saldoCaixaGeral,
  }) {
    return CashFlowModel(
      createdAt: createdAt ?? this.createdAt,
      incomes: incomes ?? this.incomes,
      expenses: expenses ?? this.expenses,
      valueLastDay: valueLastDay ?? this.valueLastDay,
      valueToNextDay: valueToNextDay ?? this.valueToNextDay,
      saldoCaixaGeral: saldoCaixaGeral ?? this.saldoCaixaGeral,
    );
  }

  void addIncome(IncomeModel model) {
    incomes.add(model);
  }

  Map<String, dynamic> toJson() {
    return {
      "createdAt": createdAt.millisecondsSinceEpoch,
      "valueLastDay": valueLastDay,
      "valueToNextDay": valueToNextDay,
      // "incomes": incomes.map((it) => it.toJson()).toList(),
      // "expenses": expenses.map((it) => it.toJson()).toList()
    };
  }

  double get totalIncome {
    double total = 0;
    incomes.forEach((el) {
      total += el.value;
    });
    return total;
  }

  double get saldo {
    double s = totalIncome + valueLastDay - totalExpense;
    s -= valueToNextDay;
    return s;
  }

  double get saldoLocal {
    double s = totalCash + valueLastDay - expenseFromLocal;
    s -= valueToNextDay;
    return s;
  }

  double get saldoGeral {
    double s = totalDebitPix + totalCredit - expenseFromGeral;
    s -= valueToNextDay;
    return s;
  }

  double get totalExpense {
    double total = 0;
    expenses.forEach((el) {
      total += el.value;
    });
    return total;
  }

  double get expenseFromLocal {
    double total = 0;
    expenses.where((e) => e.outputOption == OutputOption.local).forEach((el) {
      total += el.value;
    });
    return total;
  }

  double get expenseFromGeral {
    double total = 0;
    expenses.where((e) => e.outputOption == OutputOption.geral).forEach((el) {
      total += el.value;
    });
    return total;
  }

  double get totalCash {
    double total = 0;
    incomes.where((e) => e.paymentType == PaymentType.cash).forEach((el) {
      total += el.value;
    });
    return total;
  }

  double get totalCredit {
    double total = 0;
    incomes
        .where((e) => e.paymentType == PaymentType.credit_card)
        .forEach((el) {
      total += el.value;
    });
    return total;
  }

  double get totalDebitPix {
    double total = 0;
    incomes
        .where((e) =>
            e.paymentType == PaymentType.debit_card ||
            e.paymentType == PaymentType.pix)
        .forEach((el) {
      total += el.value;
    });
    return total;
  }
}
