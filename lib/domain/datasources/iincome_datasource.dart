

import 'package:cashflow/domain/domain.dart';

abstract class IIncomeDatasource {
  Future<List<IncomeEntity>> read({DateTime? startDate, DateTime? endDate});
  Future<IncomeEntity> save(IncomeEntity incomeEntity);
}