import '../../_exports.dart';

abstract class IDeleteExpense {
  Future<bool> call(ExpenseEntity entity);
}

class DeleteExpense implements IDeleteExpense {
  final IExpenseDatasource datasource;

  DeleteExpense({required this.datasource});

  @override
  Future<bool> call(ExpenseEntity entity) async {
    return await datasource.deleteExpense(entity);
  }
}
