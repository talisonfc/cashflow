

import 'package:cashflow/domain/domain.dart';

abstract class IGetOrigins {
  Future<List<OriginEntity>> call();
}

class GetOrigins implements IGetOrigins {
  final IOriginDatasource datasource;

  GetOrigins({required this.datasource});

  @override
  Future<List<OriginEntity>> call() async {
    return await datasource.getOrigins();
  }
}