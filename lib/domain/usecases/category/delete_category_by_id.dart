import 'package:cashflow/domain/datasources/_exports.dart';

abstract class IDeleteCategoryById {
  Future<bool> call(String id);
}

class DeleteCategoryById implements IDeleteCategoryById {
  final ICategoryDatasource datasource;

  DeleteCategoryById({required this.datasource});

  @override
  Future<bool> call(String id) async {
    return await datasource.deleteById(id);
  }
}
