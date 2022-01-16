import 'package:caixabios/app/model/cash_flow_model.dart';
import 'package:caixabios/app/model/income_model.dart';
import 'package:caixabios/app/modules/cash_flow/cash_flow_controller.dart';
import 'package:caixabios/app/modules/cash_flow/shared/read_cash_flow_id_action.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class IncomeController extends GetxController
    with StateMixin<List<IncomeModel>> {
  CashFlowRepository cashFlowRepository;
  CashFlowController cashFlowController;

  IncomeController({required this.cashFlowRepository, required this.cashFlowController});

  late String cashFlowId;
  late CollectionReference collectionReference;

  @override
  void onInit() async {
    super.onInit();
    cashFlowId = ReadCashFlowIdAction().call();
    collectionReference =
        FirebaseFirestore.instance.collection('cashflow/$cashFlowId/incomes');
    read();
  }

  void read() async {
    change([], status: RxStatus.loading());
    final snapshot = await collectionReference.get();

    List<IncomeModel> incomes = snapshot.docs.map((doc) {
      final model = IncomeModel.fromJson(doc.data() as Map<String, dynamic>);
      model.id = doc.id;
      return model;
    }).toList();
    change(incomes, status: RxStatus.success());
    cashFlowController.updateIncomes(incomes);
  }

  void deleteIncomeById(String incomeId) {
    final docRef = FirebaseFirestore.instance
        .doc('cashflow/$cashFlowId/incomes/$incomeId');
    docRef.delete();
  }

  IncomeModel currentIncome = IncomeModel();
}
