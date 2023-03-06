import 'package:cashflow/core/settings.dart';
import 'package:cashflow/domain/domain.dart';
import 'package:cashflow/external/external.dart';

import 'category.dart';
import 'package:get/instance_manager.dart';

class CategoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<ISettings>(() => Settings());
    Get.lazyReplace<ICategoryDatasource>(
        () => CategoryDatasource(settings: Get.find()));
    Get.lazyReplace<IGetCategories>(() => GetCategories(Get.find()));
    Get.lazyReplace<IUpdateCategories>(() => UpdateCategories(Get.find()));
    Get.lazyReplace<IDeleteCategoryById>(() => DeleteCategoryById(Get.find()));

    Get.lazyReplace(() => CategoryController(
        getCategories: Get.find(),
        updateCategories: Get.find(),
        deleteCategoryById: Get.find()));
  }
}
