import 'package:caixabios/app/model/cash_flow_model.dart';
import 'package:caixabios/app/modules/cash_flow/shared/components/card_report.dart';
import 'package:flutter/material.dart';

class IncomeResume extends StatelessWidget {
  final CashFlowModel cashFlowModel;
  final bool hideAddBtn;
  final Function(double) onValueNextDayChanged;
  final Function(double) onValueLastDayChanged;

  IncomeResume(
      {required this.cashFlowModel,
      this.hideAddBtn = false,
      required this.onValueLastDayChanged,
      required this.onValueNextDayChanged});

  @override
  Widget build(BuildContext context) {
    TextStyle hintStyle = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: Theme.of(context).hintColor);

    return Wrap(
      children: [
        CardReport(
          title: "Saldo dia anterior",
          value: cashFlowModel.valueLastDay,
          text: "R\$ ${cashFlowModel.valueLastDay.toStringAsFixed(2)}",
          onChanged: hideAddBtn
              ? null
              : (v) {
                  if (v != null) {
                    onValueLastDayChanged(double.parse(v));
                  }
                },
        ),
        CardReport(
          title: "Receita do dia",
          textValueColor: Theme.of(context).primaryColor,
          text: "R\$ ${cashFlowModel.totalIncome.toStringAsFixed(2)}\n",
          adicionalInfos: [
            TextSpan(text: "Receita espécie\n", style: hintStyle),
            TextSpan(
                text: "R\$ ${cashFlowModel.totalCash.toStringAsFixed(2)}\n"),
            TextSpan(text: "Receita débito/pix\n", style: hintStyle),
            TextSpan(
                text:
                    "R\$ ${cashFlowModel.totalDebitPix.toStringAsFixed(2)}\n"),
            TextSpan(text: "Receita credito\n", style: hintStyle),
            TextSpan(
                text: "R\$ ${cashFlowModel.totalCredit.toStringAsFixed(2)}\n")
          ],
        ),
        CardReport(
            title: "Despesas do dia",
            textValueColor: Theme.of(context).hintColor,
            text: "R\$ ${cashFlowModel.expenseFromLocal.toStringAsFixed(2)}"),
        CardReport(
          title: "Saldo para o próximo dia",
          textValueColor: Colors.green,
          value: cashFlowModel.valueToNextDay,
          onChanged: hideAddBtn
              ? null
              : (v) {
                  if (v != null) {
                    onValueNextDayChanged(double.parse(v));
                  }
                },
          text: "R\$ ${cashFlowModel.valueToNextDay.toStringAsFixed(2)}",
        ),
        CardReport(
            title: "Saldo em espécie",
            textValueColor: Theme.of(context).accentColor,
            text: "R\$ ${cashFlowModel.saldoLocal.toStringAsFixed(2)}"),
      ],
    );
  }
}
