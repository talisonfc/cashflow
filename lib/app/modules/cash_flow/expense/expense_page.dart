import 'dart:async';

import 'package:caixabios/app/model/expense_model.dart';
import 'package:caixabios/app/modules/cash_flow/expense/expense_controller.dart';
import 'package:caixabios/app/modules/cash_flow/shared/components/card_report.dart';
import 'package:caixabios/app/modules/cash_flow/shared/components/output_options.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/cash_flow_routes.dart';
import 'package:caixabios/fotonica_ui_components/empty.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:caixabios/fotonica_ui_components/input_formatters.dart';
import 'package:caixabios/fotonica_ui_components/simple_dialog_actions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ExpensePage extends GetView<ExpenseController> {
  final bool hideAddBtn;
  final bool hideRemoveBtn;

  ExpensePage({this.hideAddBtn = false, this.hideRemoveBtn = false});

  @override
  Widget build(BuildContext context) {
    TextStyle hintStyle = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: Theme.of(context).hintColor);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (!hideAddBtn)
            TextButton.icon(
              icon: Icon(Icons.add),
              onPressed: () {
                CashFlowRoutes.toAddExpense();
                // TODO: open create expense
                // showForm(context, controller);
              },
              label: Text("Nova saída"),
            ),
          Expanded(
            child: controller.obx((state) {
              return Card(
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: state!.map((ic) {
                    return ListTile(
                      title: Text(ic.description),
                      subtitle: Wrap(
                        spacing: 8,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(ic.createdAt?.toIso8601String() ?? '-'),
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
                                    // state.remove(ic);
                                    // TODO: remover expense
                                    // controller.save();
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
                            label: Text(ic.outputOption.name()),
                            backgroundColor: Colors.transparent,
                          ),
                          Chip(
                            label: Text(controller.hideValues
                                ? "-"
                                : "R\$ ${ic.value.toStringAsFixed(2)}"),
                            backgroundColor: Colors.transparent,
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
                onEmpty: Empty(
                  message: "Nenhuma saída disponível!",
                ),
                onLoading: Center(
                  child: CircularProgressIndicator.adaptive(),
                )),
          ),
          Wrap(
            children: [
              CardReport(
                title: "Despesas do dia",
                textValueColor: Theme.of(context).hintColor,
                text:
                    "R\$ ${controller.cashFlowController.state!.totalExpense.toStringAsFixed(2)}\n",
                adicionalInfos: [
                  TextSpan(text: "Caixa do dia\n", style: hintStyle),
                  TextSpan(
                      text:
                          "R\$ ${controller.cashFlowController.state!.expenseFromLocal.toStringAsFixed(2)}\n"),
                  TextSpan(text: "Caixa geral\n", style: hintStyle),
                  TextSpan(
                      text:
                          "R\$ ${controller.cashFlowController.state!.expenseFromGeral.toStringAsFixed(2)}\n"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
