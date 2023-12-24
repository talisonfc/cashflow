import 'package:cashflow/domain/_exports.dart';

abstract class IGetIncomesByCashflow {
  Future<List<IncomeEntity>> call(
      {String? cashflowId, DateTime? startDate, DateTime? endDate});
}

class GetIncomesByCashflow implements IGetIncomesByCashflow {
  final IIncomeDatasource datasource;

  GetIncomesByCashflow({required this.datasource});

  @override
  Future<List<IncomeEntity>> call(
      {String? cashflowId, DateTime? startDate, DateTime? endDate}) async {
    if (cashflowId == null) throw Exception('cashflowId is required');
    return await datasource.readByCashflow(
        cashflowId: cashflowId, endDate: endDate, startDate: startDate);
  }
}
