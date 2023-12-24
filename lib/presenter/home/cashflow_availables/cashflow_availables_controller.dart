import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/domain/usecases/cashflow/get_cashflows_by_user.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CashflowAvailablesController extends GetxController
    with StateMixin<List<CashflowDefinitionEntity>> {
  CashflowAvailablesController({required this.getCashflowsByUser});

  final IGetCashflowsByUser getCashflowsByUser;

  @override
  void onInit() {
    super.onInit();

    Amplify.Auth.getCurrentUser().then((authUser) {
      getCashflowsByUser(userId: authUser.userId).then((flows) {
        change(flows, status: RxStatus.success());
      }, onError: (error) {
        change(null, status: RxStatus.error(error.toString()));
      });
    }).catchError((err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}
