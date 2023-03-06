import 'package:cashflow/domain/datasources/datasources.dart';

abstract class IDeleteCategoryById {
  Future<bool> call(String id);
}

class DeleteCategoryById implements IDeleteCategoryById {
  final ICategoryDatasource datasource;

  DeleteCategoryById(this.datasource);

  @override
  Future<bool> call(String id) async {
    return await datasource.deleteById(id);
  }
}
