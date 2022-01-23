import 'package:caixabios/app/model/cash_flow_model.dart';
import 'package:caixabios/app/model/expense_model.dart';
import 'package:caixabios/app/model/income_model.dart';
import 'package:caixabios/app/modules/cash_flow/shared/read_cash_flow_id_action.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class CashFlowController extends GetxController {
  final CashFlowRepository cashFlowRepository;

  CashFlowController({required this.cashFlowRepository});

  late DocumentReference documentReference;
  Rx<CashFlowModel> currentCashFlow =
      Rx(CashFlowModel(createdAt: DateTime.now()));

  RxList<CashFlowModel> flows = RxList.empty();
  CashFlowModel? selectedCashFlow;

  final initializing = true.obs;

  @override
  void onInit() async {
    super.onInit();
    var cashFlowId = ReadCashFlowIdAction().call();
    final firestore = FirebaseFirestore.instance;

    documentReference = firestore.doc('cashflow/$cashFlowId');

    final dt30daysAgo = DateTime.now().subtract(Duration(days: 30));
    firestore
        .collection('cashflow')
        .where('createdAt', isGreaterThan: dt30daysAgo.millisecondsSinceEpoch)
        .get()
        .then((snapshot) {
      flows.value = snapshot.docs.map((doc) {
        return CashFlowModel.fromJson(doc.data())..id;
      }).toList();
    });

    final snapshot = await documentReference.get();
    if (snapshot.exists) {
      currentCashFlow.value =
          CashFlowModel.fromJson(snapshot.data() as Map<String, dynamic>);
      currentCashFlow.value.id = cashFlowId;
    } else {
      currentCashFlow.value = CashFlowModel(createdAt: DateTime.now());
      currentCashFlow.value.id = cashFlowId;
      documentReference.set(currentCashFlow.value.toJson());
    }
    initializing.value = false;
  }

  void updateIncomes(List<IncomeModel> incomes) {
    currentCashFlow.value = currentCashFlow.value.copyWith(incomes: incomes);
  }

  void udpateExpenses(List<ExpenseModel> expenses) {
    currentCashFlow.value = currentCashFlow.value.copyWith(expenses: expenses);
  }

  void updateValueToNextDay(double value) {
    currentCashFlow.value =
        currentCashFlow.value.copyWith(valueToNextDay: value);
    save();
  }

  void updateValueLastDay(double value) {
    currentCashFlow.value = currentCashFlow.value.copyWith(valueLastDay: value);
    save();
  }

  void save() {
    documentReference.set(currentCashFlow.value.toJson());
  }
}
