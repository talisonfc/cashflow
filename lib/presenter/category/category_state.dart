import 'package:cashflow/domain/entities/category_entity.dart';

class CategoryState {
  final List<CategoryEntity> categories;

  CategoryState({this.categories = const []});

  factory CategoryState.success({List<CategoryEntity> categories = const []}) {
    return CategoryState(categories: categories);
  }
}
