import 'package:caixabios/app/model/payment_type.dart';

class IncomeModel {
  String? id;
  DateTime? createdAt;
  String clientName;
  double value;
  PaymentType paymentType;

  IncomeModel(
      { this.createdAt,
      this.clientName = '',
      this.value = 0,
      this.paymentType = PaymentType.cash});

  factory IncomeModel.fromJson(Map<String, dynamic> json) {
    return IncomeModel(
        createdAt: DateTime.fromMillisecondsSinceEpoch(json["createdAt"]),
        clientName: json["clientName"],
        value: json["value"],
        paymentType: PaymentTypeBuilder.build(json["paymentType"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "createdAt": createdAt?.millisecondsSinceEpoch ?? null,
      "clientName": clientName,
      "value": value,
      "paymentType": paymentType.code(),
    };
  }
}
