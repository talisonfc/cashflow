import 'package:cashflow/domain/_exports.dart';

abstract class ISaveExpense {
  Future<ExpenseEntity> call(ExpenseEntity expense);
}

class SaveExpense implements ISaveExpense {
  final IExpenseDatasource datasource;

  SaveExpense({required this.datasource});

  @override
  Future<ExpenseEntity> call(ExpenseEntity expense) async {
    return await datasource.save(expense);
  }
}
