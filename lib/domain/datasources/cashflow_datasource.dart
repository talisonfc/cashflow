import 'package:cashflow/domain/_exports.dart';

abstract class ICashflowDatasource {
  Future<CashflowDefinitionEntity> create(
      CashflowDefinitionEntity cashflowDefinition);

  Future<List<CashflowDefinitionEntity>> readByUser({String? userId});
}
