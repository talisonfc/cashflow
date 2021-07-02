import 'package:caixabios/app/model/payment_type.dart';
import 'package:caixabios/app/modules/cash_flow/expense_page.dart';
import 'package:caixabios/app/modules/cash_flow/income_page.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:caixabios/fotonica_ui_components/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CashFlowPage extends StatefulWidget {
  final bool filter;

  CashFlowPage({this.filter = false});

  @override
  State<StatefulWidget> createState() {
    return CashFlowPageState();
  }
}

class CashFlowPageState extends State<CashFlowPage> {
  bool loading = false;

  PaymentType paymentType;

  @override
  void initState() {
    super.initState();
    Provider.of<CashFlowRepository>(context, listen: false).setTodayCashFlow();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Consumer<CashFlowRepository>(
        builder: (ctx, repository, child) => Scaffold(
          // drawer: CashFlowDrawer(),
          appBar: AppBar(
            title: !widget.filter
                ? Wrap(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                            "Fluxo de caixa (${DateFormat("d MMM yyyy").format(repository.cashFlowModel.createdAt)})"),
                      ),
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            DateTime initialDate = repository.cashFlowModel.createdAt;
                            DateTime firstDate =
                                DateTime.now().subtract(Duration(days: 7));
                            DateTime lastDate =
                                DateTime.now().add(Duration(days: 5));
                            showDatePicker(
                                    context: context,
                                    initialDate: initialDate,
                                    firstDate: firstDate,
                                    lastDate: lastDate)
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  repository.cashFlowModel.createdAt = value;
                                  repository.save();
                                });
                              }
                            });
                          })
                    ],
                  )
                : Wrap(
                    spacing: 8,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: FotonicaTextField(
                          placeholder: "Escreva aqui..",
                          filled: false,
                          onChange: (v) {
                            setState(() {
                              repository.query = v;
                            });
                          },
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.white),
                          textStyleLabel: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Wrap(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            child: Text("Data:"),
                          ),
                          DropdownButton(
                              hint: Text("Relatórios"),
                              underline: Container(),
                              onChanged: repository.setCashFlow,
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              dropdownColor: Theme.of(context).primaryColor,
                              value: repository.cashFlowModel,
                              items: repository.businessModel.businessCashFlow
                                  .map((cf) {
                                return DropdownMenuItem(
                                  value: cf,
                                  child: Text(
                                    DateFormat("d MMM yyyy")
                                        .format(cf.createdAt),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                );
                              }).toList()),
                        ],
                      )
                      // TextButton(
                      //   onPressed: () {
                      //     DateTime end = DateTime.now();
                      //     DateTime start = DateTime.now();
                      //     start = start.subtract(Duration(days: 1000));
                      //     showDatePicker(
                      //             context: context,
                      //             initialDate: end,
                      //             firstDate: start,
                      //             lastDate: end)
                      //         .then((value) {
                      //       if (value != null)
                      //         setState(() {
                      //           repository.dateTimeFilter = value;
                      //         });
                      //     });
                      //   },
                      //   child: Text(
                      //     "Data: " +
                      //         DateFormat("dd/MM/yyyy")
                      //             .format(repository.dateTimeFilter),
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .bodyText1
                      //         .copyWith(color: Colors.white),
                      //   ),
                      // ),
                      // DropdownButton(
                      //     hint: Text("Tipo de pagamento"),
                      //     style: TextStyle(color: Colors.white),
                      //     iconEnabledColor: Colors.white,
                      //     underline: Container(),
                      //     dropdownColor: Colors.white,
                      //     value: paymentType,
                      //     onChanged: (pt) {
                      //       setState(() {
                      //         paymentType = pt;
                      //       });
                      //     },
                      //     items: PaymentType.values.map((pt) {
                      //       return DropdownMenuItem(
                      //           child: Text(
                      //             pt.name(),
                      //             style: Theme.of(context).textTheme.bodyText1,
                      //           ),
                      //           value: pt);
                      //     }).toList())
                    ],
                  ),
            bottom: TabBar(
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
                  icon: Icon(repository.hideValues
                      ? Icons.remove_red_eye
                      : Icons.remove),
                  onPressed: () {
                    repository.changeHideValues();
                  }),
              if (!widget.filter)
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return SimpleDialog(
                            title: Text(
                                "Quer deixar algum valor para o próximo dia?"),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: FotonicaTextField(
                                  label: "Valor",
                                  controller: TextEditingController(
                                      text: repository
                                          .cashFlowModel.valueToNextDay
                                          ?.toString()),
                                  inputFormatters: [InputFormatters.number()],
                                  onChange: (v) {
                                    if (v != null) {
                                      repository.cashFlowModel.valueToNextDay =
                                          double.parse(v);
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancelar")),
                                    TextButton(
                                        onPressed: () {
                                          repository.save();
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Salvar"))
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Text(
                    "Fechar caixa",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
            ],
          ),
          body: TabBarView(
            children: [
              IncomePage(
                hideAddBtn: widget.filter,
                hideRemoveBtn: widget.filter,
              ),
              ExpensePage(
                hideAddBtn: widget.filter,
                hideRemoveBtn: widget.filter,
              )
            ],
          ),
        ),
      ),
    );
  }
}
