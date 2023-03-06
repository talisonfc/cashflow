import 'package:cashflow/domain/domain.dart';

abstract class IGetContexts {
  Future<List<ContextEntity>> call();
}

class GetContexts implements IGetContexts {
  final IContextDatasource datasource;

  GetContexts(this.datasource);

  @override
  Future<List<ContextEntity>> call() async {
    return await datasource.read();
  }
}
