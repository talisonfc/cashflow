import 'package:caixabios/app/cash_flow/expense_page.dart';
import 'package:caixabios/app/cash_flow/income_page.dart';
import 'package:caixabios/app/model/payment_type.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CashFlowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CashFlowPageState();
  }
}

class CashFlowPageState extends State<CashFlowPage> {
  bool loading = false;
  bool filter = false;

  PaymentType paymentType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Consumer<CashFlowRepository>(
        builder: (ctx, repository, child) => Scaffold(
          appBar: AppBar(
            title: !filter
                ? Text("Fluxo de caixa")
                : Wrap(
                    spacing: 8,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: FotonicaTextField(
                          placeholder: "Buscar",
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
                                DateFormat("dd/MM/yyyy").format(cf.createdAt),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.white),
                              ),
                            );
                          }).toList())
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
              IconButton(
                  icon: Icon(filter ? Icons.close : Icons.search),
                  onPressed: () {
                    if (!filter) {
                      repository.dateTimeFilter = DateTime.now();
                    }
                    setState(() {
                      filter = !filter;
                    });
                  }),
              if (!filter)
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
            children: [IncomePage(), ExpensePage()],
          ),
        ),
      ),
    );
  }
}
