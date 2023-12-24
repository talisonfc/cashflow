import 'package:cashflow/domain/_exports.dart';

abstract class ICreateCashflow {
  Future<CashflowDefinitionEntity> call(
      CashflowDefinitionEntity cashflowDefinition);
}

class CreateCashflow implements ICreateCashflow {
  final ICashflowDatasource datasource;

  CreateCashflow({required this.datasource});

  @override
  Future<CashflowDefinitionEntity> call(
      CashflowDefinitionEntity cashflowDefinition) async {
    return await datasource.create(cashflowDefinition);
  }
}
