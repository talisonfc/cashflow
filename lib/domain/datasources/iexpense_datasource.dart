import 'package:cashflow/domain/domain.dart';

abstract class IExpenseDatasource {
  Future<List<ExpenseEntity>> read({DateTime? startDate, DateTime? endDate});
  Future<ExpenseEntity> save(ExpenseEntity expense);
  Future<ExpenseEntity> update(ExpenseEntity expense);
}
