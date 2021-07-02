import 'dart:io';

import 'package:caixabios/app/model/month_report_model.dart';
import 'package:caixabios/app/modules/cash_flow/expense_page.dart';
import 'package:caixabios/app/modules/cash_flow/income_page.dart';
import 'package:caixabios/app/modules/cash_flow/widgets/card_report.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/app/types/report_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

class ReportsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReportsPageState();
  }
}

class ReportsPageState extends State<ReportsPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  Map<int, String> months = {
    1: "Janeiro",
    2: "Fevereiro",
    3: "Março",
    4: "Abril",
    5: "Maio",
    6: "Junho",
    7: "Julho",
    8: "Agosto",
    9: "Setembro",
    10: "Outubro",
    11: "Novembro",
    12: "Dezembro"
  };

  int currentMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  void changeMonth(int m) {
    setState(() {
      currentMonth = m;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CashFlowRepository>(
      builder: (ctx, repository, child) {
        MonthReportModel monthReportModel =
            repository.businessModel.monthReport(currentMonth);
        return Scaffold(
          appBar: AppBar(
            title: Text("Relatórios financeiro"),
          ),
          body: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Wrap(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        child: Text(
                          "Tipo de relatório:",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      DropdownButton(
                          hint: Text("Relatórios"),
                          underline: Container(),
                          onChanged: repository.changeReportType,
                          value: repository.reportType,
                          items: ReportType.values.map((t) {
                            return DropdownMenuItem(
                              value: t,
                              child: Text(
                                t.name(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                              ),
                            );
                          }).toList()),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        child: Text(
                          repository.reportType == ReportType.monthly
                              ? "Mês"
                              : "Data:",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      if (repository.reportType == ReportType.daily)
                        DropdownButton(
                            hint: Text("Relatórios"),
                            underline: Container(),
                            onChanged: repository.setCashFlow,
                            value: repository.cashFlowModel,
                            items: repository.businessModel.businessCashFlow
                                .map((cf) {
                              return DropdownMenuItem(
                                value: cf,
                                child: Text(
                                  DateFormat("d MMM yyyy").format(cf.createdAt),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                ),
                              );
                            }).toList()),
                      if (repository.reportType == ReportType.monthly)
                        DropdownButton(
                            hint: Text("Relatórios"),
                            underline: Container(),
                            onChanged: changeMonth,
                            value: currentMonth,
                            items: months
                                .map((m, month) {
                                  return MapEntry(
                                      m,
                                      DropdownMenuItem(
                                        value: m,
                                        child: Text(
                                          month,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                        ),
                                      ));
                                })
                                .values
                                .toList()),
                    ],
                  ),
                ),
              ),
              if (repository.reportType == ReportType.daily)
                Container(
                  width: 500,
                  child: TabBar(
                      labelColor: Colors.black,
                      controller: tabController,
                      tabs: [
                        Tab(
                          icon: Icon(Icons.monetization_on),
                          child: Text("Entrada"),
                        ),
                        Tab(
                          icon: Icon(Icons.account_balance_outlined),
                          child: Text("Saída"),
                        )
                      ]),
                ),
              if (repository.reportType == ReportType.daily)
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        IncomePage(
                          hideRemoveBtn: true,
                          hideAddBtn: true,
                        ),
                        ExpensePage(
                          hideAddBtn: true,
                          hideRemoveBtn: true,
                        )
                      ],
                    ),
                  ),
                ),
              if (repository.reportType == ReportType.monthly)
                Expanded(
                  child: Card(
                    child: ListView(
                      shrinkWrap: true,
                      children: months
                          .map((m, name) {
                            MonthReportModel mrm =
                                repository.businessModel.monthReport(m);
                            return MapEntry(
                                m,
                                ListTile(
                                  title: Text(name),
                                  trailing: Wrap(
                                    spacing: 16,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            children: [
                                              TextSpan(
                                                text: "Receita\n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .hintColor),
                                              ),
                                              TextSpan(
                                                text: mrm.totalIncome
                                                    .toStringAsFixed(2),
                                              )
                                            ]),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            children: [
                                              TextSpan(
                                                text: "Despesas\n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor),
                                              ),
                                              TextSpan(
                                                text: mrm.totalExpense
                                                    .toStringAsFixed(2),
                                              )
                                            ]),
                                      )
                                    ],
                                  ),
                                ));
                          })
                          .values
                          .toList(),
                    ),
                  ),
                ),
              if (repository.reportType == ReportType.monthly)
                Wrap(
                  children: [
                    CardReport(
                      title: "Receita total",
                      text: monthReportModel.totalIncome?.toString() ?? "0.00",
                    ),
                    CardReport(
                      title: "Despesa total",
                      text:
                          monthReportModel.totalExpense?.toString() ?? "0.00",
                    )
                  ],
                ),
              TextButton.icon(
                  onPressed: () async {
                    // final Uint8List fontData = File('open-sans.ttf').readAsBytesSync();
                    // final ttf = pw.Font.ttf(fontData.buffer.asByteData());
                    final pdf = pw.Document();
                    pdf.addPage(pw.Page(
                        pageFormat: PdfPageFormat.a4,
                        build: (pw.Context context) {
                          return pw.Center(
                            child: pw.Text('Hello World',
                                style: pw.TextStyle(fontSize: 40)),
                          ); // Center
                        })); // Page

                    File file = File(
                        "/Users/talisoncosta/Documents/fotonica/caixabios/example.pdf");
                    await file.writeAsBytes(await pdf.save());
                    // await Printing.layoutPdf(
                    //     onLayout: (PdfPageFormat format) async => pdf.save());
                  },
                  icon: Icon(
                    Icons.picture_as_pdf,
                    color: Colors.redAccent,
                  ),
                  label: Text(
                    "Emitir Relatório",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        );
      },
    );
  }
}
