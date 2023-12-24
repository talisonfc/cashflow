import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/presenter/presenter.dart';

class ContextDropdownInputController
    extends DropdownInputController<ContextEntity, String> {
  final IGetContexts getContexts;

  ContextDropdownInputController({
    required this.getContexts,
  });

  @override
  String getLabel(ContextEntity item) {
    return item.name;
  }

  @override
  Future<List<ContextEntity>> load() async {
    return await getContexts();
  }

  @override
  String getValue(ContextEntity item) {
    return item.id!;
  }
}
