import 'package:caixabios/app/model/cash_flow_model.dart';
import 'package:caixabios/app/modules/reports/report_util.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:caixabios/app/model/payment_type.dart';
import 'package:caixabios/app/model/expense_model.dart';

class DailyReport {

  static pw.Document generate(CashFlowModel cashFlowModel){
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          List<List<String>> table1 = [
            ["Cliente", "Forma de pagamento", "Valor"]
          ];

          table1
              .addAll(cashFlowModel.incomes.map((e) {
            return [
              e.clientName,
              e.paymentType.name(),
              e.value.toString()
            ];
          }));

          List<List<String>> table2 = [
            ["Descrição", "Origem da receita", "Valor"]
          ];

          table2.addAll(
              cashFlowModel.expenses.map((e) {
                return [
                  e.description,
                  e.outputOption.name(),
                  e.value.toString()
                ];
              }));

          CashFlowModel cfm = cashFlowModel;
          Map<String, dynamic> resumo = {
            "Saldo dia anterior": {
              "text":
              "R\$ ${cfm.valueLastDay.toStringAsFixed(2)}"
            },
            "Receita do dia": {
              "text":
              "R\$ ${cfm.totalIncome.toStringAsFixed(2)}\n",
              "infos": [
                pw.TextSpan(
                    text: "Receita em espécie\n",
                    style: ReportUtil.styleTitle),
                pw.TextSpan(
                    text:
                    "R\$ ${cfm.totalCash.toStringAsFixed(2)}\n",
                    style: ReportUtil.styleText),
                pw.TextSpan(
                    text: "Receita débito/pix\n",
                    style: ReportUtil.styleTitle),
                pw.TextSpan(
                    text:
                    "R\$ ${cfm.totalDebitPix.toStringAsFixed(2)}\n",
                    style: ReportUtil.styleText),
                pw.TextSpan(
                    text: "Receita credito\n",
                    style: ReportUtil.styleTitle),
                pw.TextSpan(
                    text:
                    "R\$ ${cfm.totalCredit.toStringAsFixed(2)}\n",
                    style: ReportUtil.styleText)
              ]
            },
            "Despesas do dia": {
              "text":
              "R\$ ${cfm.expenseFromLocal.toStringAsFixed(2)}"
            },
            "Saldo para o próximo dia": {
              "text":
              "R\$ ${cfm.valueToNextDay.toStringAsFixed(2)}"
            },
            "Saldo em espécie": {
              "text": "R\$ ${cfm.saldoLocal.toStringAsFixed(2)}"
            }
          };

          return [
            pw.Text("Bios Diagnóstico"),
            pw.Text("Data: ${DateFormat("dd/MM/yyyy").format(cfm.createdAt)}"),
            pw.SizedBox(height: 8),
            pw.Text("Resumo"),
            pw.SizedBox(height: 8),
            pw.Wrap(
              children: resumo
                  .map((key, value) {
                return MapEntry(
                    key,
                    ReportUtil.pdfCardReport(
                        title: key,
                        text: value["text"],
                        infos: value["infos"]));
              })
                  .values
                  .toList(),
            ),
            pw.SizedBox(height: 8),
            pw.Text("Receita"),
            pw.SizedBox(height: 8),
            pw.Table.fromTextArray(
                data: table1, context: context),
            pw.SizedBox(height: 8),
            pw.Text("Despesas"),
            pw.SizedBox(height: 8),
            pw.Table.fromTextArray(
                data: table2, context: context)
          ];
        }));

    return pdf;
  }

}