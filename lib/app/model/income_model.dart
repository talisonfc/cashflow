import 'package:caixabios/app/model/payment_type.dart';

class IncomeModel {
  DateTime createdAt;
  String clientName;
  double value;
  PaymentType paymentType = PaymentType.cash;

  IncomeModel({this.createdAt, this.clientName, this.value, this.paymentType});

  IncomeModel.fromJson(Map<String, dynamic> json){
    createdAt = DateTime.fromMillisecondsSinceEpoch(json["createdAt"]);
    clientName = json["clientName"];
    value = json["value"];
    paymentType = PaymentTypeBuilder.build(json["paymentType"]);
  }

  Map<String, dynamic> toJson(){
    return {
      "createdAt": createdAt.millisecondsSinceEpoch,
      "clientName": clientName,
      "value": value,
      "paymentType": paymentType.code(),
    };
  }
}
