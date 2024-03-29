import 'package:cashflow/domain/_exports.dart';

abstract class IGetCategories {
  Future<List<CategoryEntity>> call();
}

class GetCategories implements IGetCategories {
  final ICategoryDatasource datasource;

  GetCategories(this.datasource);

  @override
  Future<List<CategoryEntity>> call() async {
    return await datasource.read();
  }
}
