
import 'package:cashflow/domain/domain.dart';

abstract class IUpdateContexts {
  Future<List<ContextEntity>> call(List<ContextEntity> contexts);
}

class UpdateContexts implements IUpdateContexts {
  final IContextDatasource datasource;

  UpdateContexts(this.datasource);

  @override
  Future<List<ContextEntity>> call(List<ContextEntity> contexts) async {
    return await datasource.update(contexts);
  }
}