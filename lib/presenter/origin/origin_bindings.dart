import 'package:cashflow/core/settings.dart';
import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/external/origin_datasource.dart';
import 'package:get/get.dart';
import 'origin.dart';

class OriginBindings extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ISettings>()) {
      Get.lazyPut<ISettings>(() => Settings());
    }

    Get.lazyPut<IOriginDatasource>(
        () => OriginDatasource(settings: Get.find()));

    Get.lazyPut<IGetOrigins>(() => GetOrigins(datasource: Get.find()));

    Get.lazyPut<IUpdateOrigins>(() => UpdateOrigins(datasource: Get.find()));

    Get.lazyPut<IDeleteOriginById>(
        () => DeleteOriginById(datasource: Get.find()));

    Get.lazyPut<OriginController>(() => OriginController(
        getOrigins: Get.find(),
        updateOrigins: Get.find(),
        deleteOriginById: Get.find()));
  }
}
