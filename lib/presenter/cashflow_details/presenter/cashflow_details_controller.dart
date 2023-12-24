import 'package:cashflow/domain/_exports.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class CashflowDetailsController extends GetxController with StateMixin {
  CashflowDetailsController();

  @override
  void onInit() {
    super.onInit();

    final params = Get.parameters;
    cashflowId = params['id']!;

    change(null, status: RxStatus.success());
  }

  late String cashflowId;
}
