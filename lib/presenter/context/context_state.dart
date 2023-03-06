

import 'package:cashflow/domain/domain.dart';

class ContextState {
  final List<ContextEntity> contexts;

  ContextState({this.contexts = const []});
  
  factory ContextState.success({List<ContextEntity> contexts = const []}){
    return ContextState(contexts: contexts);
  }
}