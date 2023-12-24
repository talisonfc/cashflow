import 'package:cashflow/domain/_exports.dart';

abstract class IOriginDatasource {
  Future<List<OriginEntity>> getOrigins();
  Future<List<OriginEntity>> updateOrigins(List<OriginEntity> origins);
  Future<bool> deleteOriginById(String id);
}
