import 'package:cashflow/domain/_exports.dart';

abstract class ICreateIncome {
  Future<IncomeEntity> call(IncomeEntity incomeEntity);
}

class CreateIncome implements ICreateIncome {
  final IIncomeDatasource datasource;

  CreateIncome({required this.datasource});

  @override
  Future<IncomeEntity> call(IncomeEntity incomeEntity) async {
    return await datasource.save(incomeEntity);
  }
}
