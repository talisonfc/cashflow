import 'package:caixabios/app/model/income_model.dart';
import 'package:caixabios/app/modules/cash_flow/shared/read_cash_flow_id_action.dart';
import 'package:caixabios/app/modules/cash_flow/shared/read_income_id_action.dart';
import 'package:caixabios/cash_flow_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class IncomeCreateController extends GetxController
    with StateMixin<IncomeModel> {
  late CollectionReference collectionReference;

  @override
  void onInit() async {
    super.onInit();
    final cashFlowId = ReadCashFlowIdAction().call();
    collectionReference =
        FirebaseFirestore.instance.collection('cashflow/$cashFlowId/incomes');
    initModel();
  }

  void initModel() {
    final model = IncomeModel(createdAt: DateTime.now());
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
