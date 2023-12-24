import 'package:cashflow/domain/_exports.dart';

abstract class IDeleteContextById {
  Future<bool> call(String id);
}

class DeleteContextById implements IDeleteContextById {
  final IContextDatasource datasource;

  DeleteContextById(this.datasource);

  @override
  Future<bool> call(String id) async {
    return await datasource.deleteById(id);
  }
}
