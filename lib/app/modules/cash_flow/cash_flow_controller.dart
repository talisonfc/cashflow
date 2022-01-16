import 'package:caixabios/app/model/cash_flow_model.dart';
import 'package:caixabios/app/model/expense_model.dart';
import 'package:caixabios/app/model/income_model.dart';
import 'package:caixabios/app/modules/cash_flow/shared/read_cash_flow_id_action.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class CashFlowController extends GetxController with StateMixin<CashFlowModel>{
  final CashFlowRepository cashFlowRepository;

  CashFlowController({required this.cashFlowRepository});

  late DocumentReference documentReference;

  @override
  void onInit() async {
    super.onInit();
    var cashFlowId = ReadCashFlowIdAction().call();

    documentReference = FirebaseFirestore.instance.doc('cashflow/$cashFlowId');
    final snapshot = await documentReference.get();
    if (snapshot.exists) {
      final model =
          CashFlowModel.fromJson(snapshot.data() as Map<String, dynamic>);
      model.id = cashFlowId;
      change(model, status: RxStatus.success());
    } else {
      final model = CashFlowModel(createdAt: DateTime.now());
      model.id = cashFlowId;
      documentReference.set(model.toJson());
    }
  }

  void updateIncomes(List<IncomeModel> incomes){
    change(state!.copyWith(incomes: incomes), status: RxStatus.success());
  }

  void udpateExpenses(List<ExpenseModel> expenses){
    change(state!.copyWith(expenses: expenses), status: RxStatus.success());
  }
}
