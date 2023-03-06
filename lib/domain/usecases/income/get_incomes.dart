import 'package:cashflow/domain/domain.dart';

abstract class IGetIncomes {
  Future<List<IncomeEntity>> call({DateTime? startDate, DateTime? endDate});
}

class GetIncomes implements IGetIncomes {
  final IIncomeDatasource datasource;

  GetIncomes({required this.datasource});

  @override
  Future<List<IncomeEntity>> call(
      {DateTime? startDate, DateTime? endDate}) async {
    return await datasource.read(endDate: endDate, startDate: startDate);
  }
}
