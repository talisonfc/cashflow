import 'package:cashflow/domain/domain.dart';
import '../../shared/shared.dart';

class CategoryDropdownInputController
    extends DropdownInputController<CategoryEntity, String> {

  final IGetCategories getCategories;

  CategoryDropdownInputController({
    required this.getCategories,
  });

  @override
  String getLabel(CategoryEntity item) {
    return item.name;
  }

  @override
  Future<List<CategoryEntity>> load() async {
    return await getCategories();
  }

  @override
  String getValue(CategoryEntity item) {
    return item.id!;
  }
}
