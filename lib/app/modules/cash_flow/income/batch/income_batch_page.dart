import 'dart:convert';

import 'package:caixabios/app/model/income_model.dart';
import 'package:caixabios/app/model/payment_type.dart';
import 'package:caixabios/cash_flow_routes.dart';
import 'package:caixabios/fotonica_ui_components/dialog_Area.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:flutter/material.dart';

class IncomeBatchPage extends StatelessWidget {
  Map<String, String> mapPaymentTypeToCode = {
    "Dinheiro": "cash",
    "Crédito": "credit_card",
    "DEBITO": "debit_card"
  };

  TextEditingController tec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DialogArea(
        child: SimpleDialog(
      title: Text("Caixa diário"),
      children: [
        Container(
          width: 500,
          child: ListView(
            shrinkWrap: true,
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
                        CashFlowRoutes.back();
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
                            // TODO: add lote
                            // repository.cashFlowModel.addIncome(ict);
                          }
                        }
                        // TODO: save lote
                        // repository.save();
                        CashFlowRoutes.back();
                      },
                      child: Text("Salvar"))
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
