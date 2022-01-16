

import 'package:caixabios/app/model/expense_model.dart';
import 'package:caixabios/app/modules/cash_flow/cash_flow_controller.dart';
import 'package:caixabios/app/modules/cash_flow/shared/read_cash_flow_id_action.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ExpenseController extends GetxController with StateMixin<List<ExpenseModel>>{

  final CashFlowController cashFlowController;

  ExpenseController({required this.cashFlowController});

  late String cashFlowId;
  late CollectionReference collectionReference;

  bool hideValues = false;

  @override
  void onInit() {
    super.onInit();

    cashFlowId = ReadCashFlowIdAction()();
    collectionReference =
        FirebaseFirestore.instance.collection('cashflow/$cashFlowId/expenses');
    read();
  }

  void read() async {
    change([], status: RxStatus.loading());
    final snapshot = await collectionReference.get();

    List<ExpenseModel> expenses = snapshot.docs.map((doc) {
      final model = ExpenseModel.fromJson(doc.data() as Map<String, dynamic>);
      model.id = doc.id;
      return model;
    }).toList();
    change(expenses, status: RxStatus.success());
    cashFlowController.udpateExpenses(expenses);
  }
}