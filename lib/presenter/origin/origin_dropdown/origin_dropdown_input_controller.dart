
import 'package:cashflow/domain/domain.dart';
import 'package:cashflow/presenter/presenter.dart';

class OriginDropdownInputController extends DropdownInputController<OriginEntity, String> {
  final IGetOrigins getOrigins;

  OriginDropdownInputController({
    required this.getOrigins,
  });

  @override
  String getLabel(OriginEntity item) {
    return item.name;
  }

  @override
  Future<List<OriginEntity>> load() async {
    return await getOrigins();
  }

  @override
  String getValue(OriginEntity item) {
    return item.id!;
  }
}