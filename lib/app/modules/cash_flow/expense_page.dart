import 'dart:async';

import 'package:caixabios/app/model/expense_model.dart';
import 'package:caixabios/app/modules/cash_flow/widgets/card_report.dart';
import 'package:caixabios/app/modules/cash_flow/widgets/output_options.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/fotonica_ui_components/empty.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:caixabios/fotonica_ui_components/input_formatters.dart';
import 'package:caixabios/fotonica_ui_components/simple_dialog_actions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensePage extends StatefulWidget {
  final bool hideAddBtn;
  final bool hideRemoveBtn;

  ExpensePage({this.hideAddBtn = false, this.hideRemoveBtn = false});

  @override
  State<StatefulWidget> createState() {
    return ExpensePageState();
  }
}

class ExpensePageState extends State<ExpensePage> {
  ExpenseModel expense = ExpenseModel(createdAt: DateTime.now());
  FocusNode firstNode = FocusNode();

  void showForm(CashFlowRepository repository) {

    Timer(Duration(seconds: 1), (){
      firstNode.nextFocus();
    });

    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: Text("Saída"),
            children: [
              Container(
                width: 500,
                // height: 500,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        FotonicaTextField(
                          label: "Descrição",
                          focusNode: firstNode,
                          maxLines: 4,
                          controller:
                              TextEditingController(text: expense.description),
                          onChange: (v) {
                            expense.description = v;
                          },
                        ),
                        FotonicaTextField(
                          label: "Valor",
                          controller: TextEditingController(
                              text: expense.value?.toString()),
                          inputFormatters: [InputFormatters.number()],
                          onChange: (v) {
                            if (v != null) expense.value = double.parse(v);
                          },
                          type: TextInputType.number,
                        ),
                        OutputOptions(
                          initialData: expense.outputOption,
                          onChanged: (v) {
                            expense.outputOption = v;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancelar"),
                            ),
                            TextButton(
                                onPressed: () {
                                  expense.createdAt = DateTime.now();
                                  setState(() {
                                    repository.addExpense(expense);
                                  });
                                  expense = ExpenseModel(createdAt: DateTime.now());
                                  Navigator.pop(context, true);
                                },
                                child: Text("Salvar"))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }).then((value) {
          if(value){
            showForm(repository);
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle hintStyle = Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).hintColor);

    return Consumer<CashFlowRepository>(
      builder: (ctx, repository, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (!widget.hideAddBtn)
              TextButton.icon(
                icon: Icon(Icons.add),
                onPressed: () {
                  expense = ExpenseModel(createdAt: DateTime.now());
                  showForm(repository);
                },
                label: Text("Nova saída"),
              ),
            Expanded(
              child: Card(
                child: repository.fiteredExpenses.isNotEmpty
                    ? ListView(
                        shrinkWrap: true,
                        primary: false,
                        children: repository.fiteredExpenses.map((ic) {
                          return ListTile(
                            title: Text(ic.description ?? "Descrição"),
                            subtitle: Wrap(
                              spacing: 8,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(ic.createdAt.toIso8601String()),
                                ),
                                if (!widget.hideRemoveBtn)
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
                                          setState(() {
                                            repository.cashFlowModel.expenses
                                                .remove(ic);
                                            repository.save();
                                          });
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
                                  label:
                                      Text(ic.outputOption.name() ?? "Output"),
                                  backgroundColor: Colors.transparent,
                                ),
                                Chip(
                                  label: Text(repository.hideValues
                                      ? "-"
                                      : "R\$ ${ic.value?.toStringAsFixed(2)}"),
                                  backgroundColor: Colors.transparent,
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    : Empty(
                        message: "Nenhuma saída disponível!",
                      ),
              ),
            ),
            Wrap(
              children: [
                CardReport(
                  title: "Despesas do dia",
                  textValueColor: Theme.of(context).hintColor,
                  text:
                      "R\$ ${repository.cashFlowModel.totalExpense.toStringAsFixed(2)}\n",
                  adicionalInfos: [
                    TextSpan(
                        text: "Caixa do dia\n",
                        style: hintStyle
                    ),
                    TextSpan(
                        text: "R\$ ${repository.cashFlowModel.expenseFromLocal.toStringAsFixed(2)}\n"
                    ),
                    TextSpan(
                        text: "Caixa geral\n",
                        style: hintStyle
                    ),
                    TextSpan(
                        text: "R\$ ${repository.cashFlowModel.expenseFromGeral.toStringAsFixed(2)}\n"
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
