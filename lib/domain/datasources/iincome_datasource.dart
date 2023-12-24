import 'package:cashflow/domain/_exports.dart';

abstract class IIncomeDatasource {
  Future<List<IncomeEntity>> readByCashflow(
      {required String cashflowId, DateTime? startDate, DateTime? endDate});
  Future<IncomeEntity> save(IncomeEntity incomeEntity);
}
