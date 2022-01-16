import 'package:caixabios/app/model/expense_model.dart';
import 'package:caixabios/app/modules/cash_flow/shared/read_cash_flow_id_action.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ExpenseCreateController extends GetxController
    with StateMixin<ExpenseModel> {
  late CollectionReference collectionReference;

  @override
  void onInit() {
    super.onInit();
    final cashFlowId = ReadCashFlowIdAction().call();
    collectionReference =
        FirebaseFirestore.instance.collection('cashflow/$cashFlowId/expenses');
    initModel();
  }

  void initModel() {
    final model = ExpenseModel(createdAt: DateTime.now());
    change(model, status: RxStatus.success());
  }

  void save() {
    collectionReference.add(state!.toJson()).then((value) {
      initModel();
    }).catchError((error) {
      // TODO: tratar error
      throw error;
    });
  }
}
