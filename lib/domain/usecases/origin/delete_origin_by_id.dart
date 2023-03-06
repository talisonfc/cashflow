

import 'package:cashflow/domain/domain.dart';

abstract class IDeleteOriginById {
  Future<bool> call(String id);
}

class DeleteOriginById implements IDeleteOriginById {

  final IOriginDatasource datasource;

  DeleteOriginById({required this.datasource});

  @override
  Future<bool> call(String id) async {
    return await datasource.deleteOriginById(id);
  }
}