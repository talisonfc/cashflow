

import 'package:cashflow/domain/domain.dart';

class OriginState {

  final List<OriginEntity> origins;

  OriginState({this.origins = const []});

  factory OriginState.success({required List<OriginEntity> origins}) {
    return OriginState(origins: origins);
  }

  factory OriginState.loading() {
    return OriginState();
  }
}