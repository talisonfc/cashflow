
import 'package:cashflow/domain/domain.dart';

abstract class IUpdateOrigins {
  Future<List<OriginEntity>> call(List<OriginEntity> origins);
}

class UpdateOrigins implements IUpdateOrigins {
  final IOriginDatasource datasource;

  UpdateOrigins({required this.datasource});

  @override
  Future<List<OriginEntity>> call(List<OriginEntity> origins) async {
    return await datasource.updateOrigins(origins);
  }
}