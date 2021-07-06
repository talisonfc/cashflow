import 'dart:async';
import 'dart:convert';

import 'package:caixabios/app/model/income_model.dart';
import 'package:caixabios/app/model/payment_type.dart';
import 'package:caixabios/app/modules/cash_flow/widgets/card_report.dart';
import 'package:caixabios/app/modules/cash_flow/widgets/payment_type_options.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/fotonica_ui_components/empty.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:caixabios/fotonica_ui_components/input_formatters.dart';
import 'package:caixabios/fotonica_ui_components/simple_dialog_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  FocusNode focusClient = FocusNode();

  Map<String, String> mapPaymentTypeToCode = {
    "Dinheiro": "cash",
    "Crédito": "credit_card",
    "DEBITO": "debit_card"
  };

  void showForm(CashFlowRepository repository) {
    Timer(Duration(seconds: 1), () {
      focusClient.nextFocus();
    });

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
                            focusNode: focusClient,
                            label: "Cliente",
                            controller: TextEditingController(
                                text: incomeModel.clientName),
                            onChange: (v) {
                              incomeModel.clientName = v;
                            }),
                        FotonicaTextField(
                          label: "Valor",
                          type: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [InputFormatters.number()],
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
                                  incomeModel.createdAt = DateTime.now();
                                  setState(() {
                                    repository.cashFlowModel
                                        .addIncome(incomeModel);
                                    incomeModel = new IncomeModel(
                                        createdAt: DateTime.now());
                                  });
                                  repository.save();
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
      if (value) {
        showForm(repository);
      }
    });
  }

  void showEntradaLote(CashFlowRepository repository) {
    showDialog(
        context: context,
        builder: (ctx) {
          TextEditingController tec = TextEditingController();
          return SimpleDialog(
            title: Text("Caixa diário"),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: FotonicaTextField(
                  controller: tec,
                  placeholder: "Cole aqui...",
                  maxLines: 5,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancelar")),
                  TextButton(
                      onPressed: () {
                        LineSplitter ls = new LineSplitter();
                        List<String> lines = ls.convert(tec.text);

                        for (int i = 0; i < lines.length; i += 1) {
                          List<String> r = lines[i].split(" ");
                          if (r.length > 2) {
                            // print(r);
                            r.removeAt(0);
                            String data = r[0];
                            String time = r[1];
                            r.removeRange(0, 2);

                            String pt = "";
                            // Extrair forma de pagamento
                            if (i > 2 && lines[i - 1].split(" ").length == 1) {
                              pt = lines[i - 1];
                            } else {
                              pt = r[r.length - 2];
                              r.removeAt(r.length - 2);
                            }

                            double value = double.parse(
                                r[r.length - 1].replaceAll(",", "."));
                            r.removeAt(r.length - 1);
                            String clientName = r.join(" ");

                            // Extrair data e hora
                            List<int> d1 = data
                                .split("/")
                                .map((it) => int.parse(it))
                                .toList();
                            List<int> d2 = time
                                .split(".")
                                .map((it) => int.parse(it))
                                .toList();
                            DateTime createdAt = DateTime(
                                d1[2], d1[1], d1[0], d2[0], d2[1], d2[2]);

                            IncomeModel ict = IncomeModel(
                                createdAt: createdAt,
                                clientName: clientName,
                                value: value,
                                paymentType: PaymentTypeBuilder.build(
                                    mapPaymentTypeToCode[pt]));
                            repository.cashFlowModel.addIncome(ict);
                          }
                        }
                        repository.save();
                        Navigator.pop(context);
                      },
                      child: Text("Salvar"))
                ],
              )
            ],
          );
        }).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle hintStyle = Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(color: Theme.of(context).hintColor);

    return Consumer<CashFlowRepository>(
      builder: (ctx, repository, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // shrinkWrap: true,
          children: [
            if (!widget.hideAddBtn)
              Wrap(
                children: [
                  TextButton.icon(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        incomeModel = IncomeModel(createdAt: DateTime.now());
                        showForm(repository);
                      },
                      label: Text("Nova entrada")),
                  TextButton.icon(
                    icon: Icon(Icons.list_alt),
                    label: Text("Entrada em lote"),
                    onPressed: () {
                      showEntradaLote(repository);
                    },
                  ),
                  TextButton.icon(
                      onPressed: () {
                        showDialog(context: context, builder: (ctx){
                          return SimpleDialog(
                            title: Text("Tem certeza que deseja remover todas as entradas?"),
                            children: [
                              SimpleDialogActions(value: true,)
                            ],
                          );
                        }).then((v){
                          if(v != null && v){
                            repository.cashFlowModel.incomes.clear();
                            repository.save();
                          }
                        });
                      },
                      icon: Icon(Icons.cleaning_services_sharp),
                      label: Text("Limpar entradas"))
                ],
              ),
            Expanded(
              child: Card(
                child: repository.fiteredIncomes.isNotEmpty
                    ? ListView(
                        shrinkWrap: true,
                        primary: false,
                        children: repository.fiteredIncomes.map((ic) {
                          return ListTile(
                            title: Text(ic.clientName ?? "Nome do cliente"),
                            subtitle: Wrap(
                              spacing: 8,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(ic.createdAt?.toIso8601String() ??
                                      "Data"),
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
                                  label: Text(ic.paymentType.name() ??
                                      "Tipo de pagamento"),
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
                        message: "Nenhuma entrada disponível!",
                      ),
              ),
            ),
            Wrap(
              children: [
                CardReport(
                  title: "Saldo dia anterior",
                  value: repository.cashFlowModel.valueLastDay,
                  text:
                      "R\$ ${repository.cashFlowModel.valueLastDay.toStringAsFixed(2)}",
                  onChanged: widget.hideAddBtn
                      ? null
                      : (v) {
                          if (v != null) {
                            setState(() {
                              repository.cashFlowModel.valueLastDay =
                                  double.parse(v);
                              repository.save();
                            });
                          }
                        },
                ),
                CardReport(
                  title: "Receita do dia",
                  textValueColor: Theme.of(context).primaryColor,
                  text:
                      "R\$ ${repository.cashFlowModel.totalIncome.toStringAsFixed(2)}\n",
                  adicionalInfos: [
                    TextSpan(text: "Receita espécie\n", style: hintStyle),
                    TextSpan(
                        text:
                            "R\$ ${repository.cashFlowModel.totalCash.toStringAsFixed(2)}\n"),
                    TextSpan(text: "Receita débito/pix\n", style: hintStyle),
                    TextSpan(
                        text:
                            "R\$ ${repository.cashFlowModel.totalDebitPix.toStringAsFixed(2)}\n"),
                    TextSpan(text: "Receita credito\n", style: hintStyle),
                    TextSpan(
                        text:
                            "R\$ ${repository.cashFlowModel.totalCredit.toStringAsFixed(2)}\n")
                  ],
                ),
                CardReport(
                    title: "Despesas do dia",
                    textValueColor: Theme.of(context).hintColor,
                    text:
                        "R\$ ${repository.cashFlowModel.expenseFromLocal.toStringAsFixed(2)}"),
                CardReport(
                  title: "Saldo para o próximo dia",
                  textValueColor: Colors.green,
                  value: repository.cashFlowModel.valueToNextDay,
                  onChanged: widget.hideAddBtn
                      ? null
                      : (v) {
                          if (v != null) {
                            setState(() {
                              repository.cashFlowModel.valueToNextDay =
                                  double.parse(v);
                            });
                            repository.save();
                          }
                        },
                  text:
                      "R\$ ${repository.cashFlowModel.valueToNextDay?.toStringAsFixed(2) ?? "0.00"}",
                ),
                CardReport(
                    title: "Saldo em espécie",
                    textValueColor: Theme.of(context).accentColor,
                    text:
                        "R\$ ${repository.cashFlowModel.saldoLocal.toStringAsFixed(2)}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
