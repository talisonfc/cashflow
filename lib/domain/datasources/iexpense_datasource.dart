import 'package:cashflow/domain/_exports.dart';

abstract class IExpenseDatasource {
  Future<List<ExpenseEntity>> readByCashflow(
      {required String cashflowId, DateTime? startDate, DateTime? endDate});
  Future<ExpenseEntity> save(ExpenseEntity expense);
  Future<ExpenseEntity> update(ExpenseEntity expense);
  Future<bool> deleteExpense(ExpenseEntity expense);
}
