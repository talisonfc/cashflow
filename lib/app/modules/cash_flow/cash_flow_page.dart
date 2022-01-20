import 'package:caixabios/app/model/payment_type.dart';
import 'package:caixabios/app/modules/cash_flow/actions/close_cashflow_action.dart';
import 'package:caixabios/app/modules/cash_flow/cash_flow_controller.dart';
import 'package:caixabios/app/modules/cash_flow/components/cash_flow_search.dart';
import 'package:caixabios/app/modules/cash_flow/components/cash_flow_title.dart';
import 'package:caixabios/app/modules/cash_flow/expense/expense_page.dart';
import 'package:caixabios/app/modules/cash_flow/income/income_page.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/cash_flow_routes.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:caixabios/fotonica_ui_components/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class CashFlowPage extends GetView<CashFlowController> {
  final bool filter;

  CashFlowPage({this.filter = false});

  bool loading = false;

  PaymentType? paymentType;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: WillPopScope(
          onWillPop: () async {
            CashFlowRoutes.toWorkspace();
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: !filter
                  ? CashFlowTitle(
                      repository: controller.cashFlowRepository,
                    )
                  : CashFlowSearch(repository: controller.cashFlowRepository),
              bottom: TabBar(
                // onTap: (index){
                //   switch(index){
                //     case 0: {
                //       print(Get.parameters);
                //       // delegate.toNamed(CashFlowRoutes.incomePath);
                //       CashFlowRoutes.toIncome(delegate, controller.state!.id!);
                //       break;
                //     }
                //     case 1: {
                //       // delegate.toNamed('/income');
                //       CashFlowRoutes.toExpense(delegate, controller.state!.id!);
                //       break;
                //     }
                //   }
                // },
                tabs: [
                  Tab(
                    icon: Icon(Icons.monetization_on),
                    child: Text("Entrada"),
                  ),
                  Tab(
                    icon: Icon(Icons.account_balance_outlined),
                    child: Text("Saída"),
                  )
                ],
              ),
              actions: [
                IconButton(
                    icon: Icon(controller.cashFlowRepository.hideValues
                        ? Icons.remove_red_eye
                        : Icons.remove),
                    onPressed: () {
                      controller.cashFlowRepository.changeHideValues();
                    }),
                if (!filter)
                  TextButton(
                    onPressed: () {
                      CloseCashFlowAction(
                          cashFlow: controller.cashFlowRepository.cashFlowModel,
                          onCancel: () {
                            // TODO: implementar
                            CashFlowRoutes.back();
                          },
                          onSave: () {
                            // TODO: implementar
                          })(context);
                    },
                    child: Text(
                      "Fechar caixa",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
              ],
            ),
            body: Obx(() => !controller.initializing.value
                ? TabBarView(
                    children: [
                      IncomePage(hideAddBtn: filter, hideRemoveBtn: filter),
                      ExpensePage(hideAddBtn: filter, hideRemoveBtn: filter)
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator.adaptive(),
                  )),
          ),
        ));
  }
}
