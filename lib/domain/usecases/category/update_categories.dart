import 'package:cashflow/domain/_exports.dart';

abstract class IUpdateCategories {
  Future<List<CategoryEntity>> call(List<CategoryEntity> categories);
}

class UpdateCategories implements IUpdateCategories {
  final ICategoryDatasource datasource;

  UpdateCategories(this.datasource);

  @override
  Future<List<CategoryEntity>> call(List<CategoryEntity> categories) async {
    return await datasource.update(categories);
  }
}
