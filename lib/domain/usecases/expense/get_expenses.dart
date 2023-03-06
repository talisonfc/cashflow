import 'package:cashflow/domain/domain.dart';

abstract class IGetExpenses {
  Future<List<ExpenseEntity>> call({DateTime? startDate, DateTime? endDate});
}

class GetExpenses implements IGetExpenses {
  final IExpenseDatasource datasource;

  GetExpenses(this.datasource);

  @override
  Future<List<ExpenseEntity>> call(
      {DateTime? startDate, DateTime? endDate}) async {
    return await datasource.read(startDate: startDate, endDate: endDate);
  }
}
