import 'package:caixabios/app/model/business_model.dart';
import 'package:caixabios/app/model/month_report_model.dart';
import 'package:caixabios/app/modules/reports/report_util.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AnualReport {

  static pw.Document generate(BusinessModel businessModel){

    pw.Document pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {

          List<List<String>> table1 = [
            ["Mês", "Receita", "Despesa"]
          ];

          table1
              .addAll(ReportUtil.months.map((m, name) {
                MonthReportModel monthReportModel = businessModel.monthReport(m);
            return MapEntry(m, [
              name,
              "R\$ ${monthReportModel.totalIncome.toStringAsFixed(2)}",
              "R\$ ${monthReportModel.totalExpense.toStringAsFixed(2)}"
            ]);
          }).values.toList());

          return [
            pw.Text("Bios Diagnóstico"),
            pw.Text("Data: ${DateFormat("dd/MM/yyyy").format(DateTime.now())}"),
            pw.SizedBox(height: 8),
            pw.Text("Relatório Anual"),
            pw.SizedBox(height: 8),
            pw.Table.fromTextArray(data: table1)
          ];
        }
    ));

    return pdf;
  }
}