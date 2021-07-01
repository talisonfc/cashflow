import 'package:caixabios/app/model/income_model.dart';
import 'package:caixabios/app/model/payment_type.dart';
import 'package:caixabios/app/modules/cash_flow/widgets/card_report.dart';
import 'package:caixabios/app/modules/cash_flow/widgets/payment_type_options.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/fotonica_ui_components/empty.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:caixabios/fotonica_ui_components/simple_dialog_actions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomePage extends StatefulWidget {
  final bool hideAddBtn;
  final bool hideRemoveBtn;

  IncomePage({this.hideAddBtn = false, this.hideRemoveBtn = false});

  @override
  State<StatefulWidget> createState() {
    return IncomePageState();
  }
}

class IncomePageState extends State<IncomePage> {
  IncomeModel incomeModel = IncomeModel();

  void showForm(CashFlowRepository repository) {
    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: Text("Entrada"),
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
                          label: "Cliente",
                          controller: TextEditingController(
                              text: incomeModel.clientName),
                          onChange: (v) {
                            incomeModel.clientName = v;
                          },
                        ),
                        FotonicaTextField(
                          label: "Valor",
                          type: TextInputType.number,
                          controller: TextEditingController(
                              text: incomeModel.value?.toString()),
                          onChange: (v) {
                            incomeModel.value = double.parse(v);
                          },
                        ),
                        PaymentTypeOptions(
                          initialData: incomeModel.paymentType,
                          onChanged: (pt) {
                            incomeModel.paymentType = pt;
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
                                  setState(() {
                                    repository.cashFlowModel
                                        .addIncome(incomeModel);
                                  });
                                  repository.save();
                                  Navigator.pop(context);
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CashFlowRepository>(
      builder: (ctx, repository, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // shrinkWrap: true,
          children: [
            if (!widget.hideAddBtn)
              TextButton.icon(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    incomeModel = IncomeModel(createdAt: DateTime.now());
                    showForm(repository);
                  },
                  label: Text("Nova entrada")),
            Expanded(
              child: Card(
                child: repository.fiteredIncomes.isNotEmpty
                    ? ListView(
                        shrinkWrap: true,
                        primary: false,
                        children: repository.fiteredIncomes.map((ic) {
                          return ListTile(
                            title: Text(ic.clientName),
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
                                            repository.cashFlowModel.incomes
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
                                  label: Text(ic.paymentType.name()),
                                  backgroundColor: Colors.transparent,
                                ),
                                Chip(
                                  label: Text(repository.hideValues
                                      ? "-"
                                      : "R\$ " + ic.value?.toStringAsFixed(2)),
                                  backgroundColor: Colors.transparent,
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    : Empty(
                        message: "Nenhuma entrada disponível!",
                      ),
              ),
            ),
            Wrap(
              children: [
                CardReport(
                  title: "Saldo dia anterior",
                  value:
                      "R\$ ${repository.cashFlowModel.valueLastDay.toStringAsFixed(2)}",
                ),
                CardReport(
                  title: "Receita do dia",
                  textValueColor: Theme.of(context).primaryColor,
                  value:
                      "R\$ ${repository.cashFlowModel.totalIncome.toStringAsFixed(2)}",
                ),
                CardReport(
                  title: "Despesas do dia",
                  textValueColor: Theme.of(context).hintColor,
                  value:
                      "R\$ ${repository.cashFlowModel.totalExpense.toStringAsFixed(2)}",
                ),
                if (repository.cashFlowModel.valueToNextDay != null)
                  CardReport(
                    title: "Saldo para o próximo dia",
                    textValueColor: Colors.green,
                    value:
                    "R\$ ${repository.cashFlowModel.valueToNextDay.toStringAsFixed(2)}",
                  ),
                CardReport(
                  title: "Saldo",
                  textValueColor: Theme.of(context).accentColor,
                  value:
                      "R\$ ${repository.cashFlowModel.saldo.toStringAsFixed(2)}",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
