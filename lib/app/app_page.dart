import 'package:caixabios/app/cash_flow/cash_flow_page.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_elevated_button.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppPageState();
  }
}

class AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CashFlowRepository>(
      builder: (ctx, repository, child) => Scaffold(
          body: Center(
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "BioS Diagnóstico",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Wrap(
              spacing: 20,
              children: [
                Text(
                  "Fechado!",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Theme.of(context).errorColor,
                      fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  child: Text("Abrir caixa"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return SimpleDialog(
                            title: Text("Qual o saldo do dia anterior?"),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 32),
                                child: FotonicaTextField(
                                  placeholder: "Saldo",
                                  type: TextInputType.number,
                                  controller: TextEditingController(
                                      text: repository
                                          .cashFlowModel.valueLastDay
                                          ?.toString()),
                                  onChange: (v) {
                                    if (v != null) {
                                      repository.cashFlowModel.valueLastDay =
                                          double.parse(v);
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FotonicaElevatedButton(
                                      label: "Cancelar",
                                      color: Theme.of(context).errorColor,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    FotonicaElevatedButton(
                                      label: "Continuar",
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    CashFlowPage()));
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
