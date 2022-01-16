import 'package:caixabios/app/model/cash_flow_model.dart';
import 'package:caixabios/app/model/month_report_model.dart';

class BusinessModel {
  List<CashFlowModel> businessCashFlow;

  BusinessModel({this.businessCashFlow = const <CashFlowModel>[]});

  void addCashFlow(CashFlowModel model) {
    businessCashFlow.add(model);
  }

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
        businessCashFlow: json["businessCashFlow"] != null
            ? json["businessCashFlow"].map<CashFlowModel>((el) {
                return CashFlowModel.fromJson(el);
              }).toList()
            : []);
  }

  BusinessModel copyWith({List<CashFlowModel>? businessCashFlow}) {
    return BusinessModel(
        businessCashFlow: businessCashFlow ?? this.businessCashFlow);
  }

  Map<String, dynamic> toJson() {
    return {
      "businessCashFlow": businessCashFlow.map((e) => e.toJson()).toList()
    };
  }

  MonthReportModel monthReport(int month) {
    MonthReportModel monthReportModel =
        MonthReportModel(month: 0, totalExpense: 0, totalIncome: 0);
    this
        .businessCashFlow
        .where((ic) => ic.createdAt.month == month)
        .forEach((it) {
      monthReportModel.totalIncome += it.totalIncome;
      monthReportModel.totalExpense += it.totalExpense;
    });
    return monthReportModel;
  }
}
