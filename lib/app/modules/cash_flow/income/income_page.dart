import 'package:caixabios/app/model/cash_flow_model.dart';
import 'package:caixabios/app/model/payment_type.dart';
import 'package:caixabios/app/modules/cash_flow/income/components/income_resume.dart';
import 'package:caixabios/app/modules/cash_flow/income/income_controller.dart';
import 'package:caixabios/cash_flow_routes.dart';
import 'package:caixabios/fotonica_ui_components/empty.dart';
import 'package:caixabios/fotonica_ui_components/simple_dialog_actions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class IncomePage extends GetView<IncomeController> {
  final bool hideAddBtn;
  final bool hideRemoveBtn;

  IncomePage({this.hideAddBtn = false, this.hideRemoveBtn = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // shrinkWrap: true,
        children: [
          if (!hideAddBtn)
            Wrap(
              children: [
                TextButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      await CashFlowRoutes.toAddIncome();
                      controller.read();
                    },
                    label: Text("Nova entrada")),
                TextButton.icon(
                  icon: Icon(Icons.list_alt),
                  label: Text("Entrada em lote"),
                  onPressed: () async {
                    await CashFlowRoutes.toBatchIncome();
                    controller.read();
                  },
                ),
                TextButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return SimpleDialog(
                              title: Text(
                                  "Tem certeza que deseja remover todas as entradas?"),
                              children: [
                                SimpleDialogActions(
                                  value: true,
                                )
                              ],
                            );
                          }).then((v) {
                        if (v != null && v) {
                          controller.deleteAll();
                        }
                      });
                    },
                    icon: Icon(Icons.cleaning_services_sharp),
                    label: Text("Limpar entradas"))
              ],
            ),
          Expanded(
            child: Card(
              child: controller.obx(
                (state) => ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: controller.state!.map((ic) {
                    return ListTile(
                      title: Text(ic.clientName),
                      subtitle: Wrap(
                        spacing: 8,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child:
                                Text(ic.createdAt?.toIso8601String() ?? "Data"),
                          ),
                          if (!hideRemoveBtn)
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return SimpleDialog(
                                        title: Text(
                                            "Tem certeza que deseja remover?"),
                                        children: [
                                          SimpleDialogActions(
                                            value: true,
                                          )
                                        ],
                                      );
                                    }).then((confirm) {
                                  if (confirm != null) {
                                    controller.deleteIncomeById(ic.id!);
                                  }
                                });
                              },
                              child: Chip(
                                label: Text("Remover"),
                                backgroundColor: Colors.transparent,
                              ),
                            )
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          Chip(
                            label: Text(ic.paymentType.name()),
                            backgroundColor: Colors.transparent,
                          ),
                          Chip(
                            label: Text(controller.cashFlowRepository.hideValues
                                ? "-"
                                : "R\$ ${ic.value.toStringAsFixed(2)}"),
                            backgroundColor: Colors.transparent,
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
                onEmpty: Empty(
                  message: "Nenhuma entrada disponível!",
                ),
                onLoading: Container(
                    width: double.infinity,
                    child: CircularProgressIndicator.adaptive()),
              ),
            ),
          ),
          Obx(() => IncomeResume(
                cashFlowModel:
                    controller.cashFlowController.currentCashFlow.value,
                onValueLastDayChanged: controller.cashFlowController.updateValueLastDay,
                onValueNextDayChanged: controller.cashFlowController.updateValueToNextDay,
              ))
        ],
      ),
    );
  }
}
