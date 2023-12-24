import 'package:cashflow/domain/_exports.dart';

abstract class IGetCashflowsByUser {
  Future<List<CashflowDefinitionEntity>> call({String? userId});
}

class GetCashflowsByUser implements IGetCashflowsByUser {
  final ICashflowDatasource datasource;

  GetCashflowsByUser({required this.datasource});

  @override
  Future<List<CashflowDefinitionEntity>> call({String? userId}) async {
    if (userId != null) {
      return await datasource.readByUser(userId: userId);
    }
    throw Exception('UserId is required');
  }
}
