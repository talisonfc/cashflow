import '../_exports.dart';

abstract class ICategoryDatasource {
  Future<List<CategoryEntity>> read();
  Future<List<CategoryEntity>> update(List<CategoryEntity> categories);
  Future<bool> deleteById(String id);
}
