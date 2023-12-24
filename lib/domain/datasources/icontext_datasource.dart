import '../_exports.dart';

abstract class IContextDatasource {
  Future<List<ContextEntity>> read();
  Future<List<ContextEntity>> update(List<ContextEntity> contexts);
  Future<bool> deleteById(String id);
}
