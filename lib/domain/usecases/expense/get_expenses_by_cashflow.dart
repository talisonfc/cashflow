import 'package:cashflow/domain/_exports.dart';

abstract class IGetExpensesByCashflow {
  Future<List<ExpenseEntity>> call(
      {String? cashflowId, DateTime? startDate, DateTime? endDate});
}

class GetExpensesByCashflow implements IGetExpensesByCashflow {
  final IExpenseDatasource datasource;

  GetExpensesByCashflow(this.datasource);

  @override
  Future<List<ExpenseEntity>> call(
      {String? cashflowId, DateTime? startDate, DateTime? endDate}) async {
    if (cashflowId == null) throw Exception('cashflowId is required');
    return await datasource.readByCashflow(
        cashflowId: cashflowId, startDate: startDate, endDate: endDate);
  }
}
