import 'package:caixabios/app/modules/cash_flow/cash_flow_page.dart';
import 'package:caixabios/app/modules/reports/reports_page.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/cash_flow_routes.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_elevated_button.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:caixabios/fotonica_ui_components/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WorkspaceView extends GetView<CashFlowRepository> {

  void openDailyCashFlow(BuildContext context, CashFlowRepository repository) {
    if (repository.cashFlowModel.valueLastDay != null) {
      final today = DateTime.now();
      CashFlowRoutes.toCashFlow(today);
    }
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (ctx) => CashFlowPage()));
    else
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
                    inputFormatters: [InputFormatters.number()],
                    controller: TextEditingController(
                        text: repository.cashFlowModel.valueLastDay.toString()),
                    onChange: (v) {
                      repository.cashFlowModel.valueLastDay = double.parse(v);
                    },
                    focusNode: FocusNode(),
                    label: 'Label',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  builder: (ctx) => CashFlowPage()));
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle bodyText1 =
        Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20);
    
    return Scaffold(
        body: Center(
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        children: [
          Center(
            child: Container(
                padding: EdgeInsets.all(16),
                width: 500,
                child: Image.asset("assets/images/biosdiagnostico.png")),
          ),
          Wrap(
            children: [
              Card(
                child: TextButton.icon(
                  onPressed: () {
                    openDailyCashFlow(context, controller);
                  },
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Caixa do dia",
                      style: bodyText1,
                    ),
                  ),
                  icon: Icon(Icons.monetization_on),
                ),
              ),
              Card(
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => CashFlowPage(
                                  filter: true,
                                )));
                  },
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Consultar caixa",
                      style: bodyText1,
                    ),
                  ),
                  icon: Icon(Icons.search),
                ),
              ),
              Card(
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => ReportsPage(
                                  repository: controller,
                                )));
                  },
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Relatórios financeiros",
                      style: bodyText1,
                    ),
                  ),
                  icon: Icon(Icons.picture_as_pdf),
                ),
              ),
              // TextButton(onPressed: (){}, child: Text("Consultar caixa"))
            ],
          )
        ],
      ),
    ));
  }
}