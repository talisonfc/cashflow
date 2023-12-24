import 'package:cashflow/domain/_exports.dart';
import 'package:get/get.dart';
import '_exports.dart';

class HomeController extends GetxController with StateMixin<HomeState> {
  HomeController();

  final CashflowModelView cashflow = CashflowModelView();

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.success());
  }
}
