import 'package:cashflow/core/core.dart';
import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/external/context_datasource.dart';
import 'package:get/get.dart';
import 'context.dart';

class ContextBindings extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ISettings>()) {
      Get.lazyReplace<ISettings>(() => Settings());
    }
    Get.lazyReplace<IContextDatasource>(
        () => ContextDatasource(settings: Get.find()));
    Get.lazyPut<IGetContexts>(() => GetContexts(Get.find()));
    Get.lazyPut<IUpdateContexts>(() => UpdateContexts(Get.find()));
    Get.lazyPut<IDeleteContextById>(() => DeleteContextById(Get.find()));

    Get.lazyPut<ContextController>(() => ContextController(
        getContexts: Get.find(),
        updateContexts: Get.find(),
        deleteContextById: Get.find()));
  }
}
