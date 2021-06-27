import 'package:caixabios/app/model/cash_flow_model.dart';

class BusinessModel {
  List<CashFlowModel> businessCashFlow;

  BusinessModel({this.businessCashFlow});

  void addCashFlow(CashFlowModel model) {
    businessCashFlow.add(model);
  }

  BusinessModel.fromJson(Map<String, dynamic> json) {
    businessCashFlow = json["businessCashFlow"] != null
        ? json["businessCashFlow"].map<CashFlowModel>((el) {
            return CashFlowModel.fromJson(el);
          }).toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    return {
      "businessCashFlow": businessCashFlow != null
          ? businessCashFlow.map((e) => e.toJson()).toList()
          : []
    };
  }
}
