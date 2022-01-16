
import 'package:caixabios/app/model/payment_type.dart';
import 'package:flutter/material.dart';

class PaymentTypeOptions extends StatefulWidget {

  final PaymentType initialData;
  final Function(PaymentType?) onChanged;

  PaymentTypeOptions({this.initialData = PaymentType.cash, required this.onChanged});

  @override
  State<StatefulWidget> createState() {
    return PaymentTypeOptionsPageState();
  }
}

class PaymentTypeOptionsPageState extends State<PaymentTypeOptions>{

  PaymentType? paymentType;

  @override
  void initState() {
    super.initState();
    paymentType = widget.initialData;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: PaymentType.values.map((pt) {
        return RadioListTile<PaymentType>(
            value: pt,
            title: Text(pt.name()),
            groupValue: paymentType,
            onChanged: (v) {
              setState(() {
                paymentType = pt;
              });
              widget.onChanged(paymentType);
            });
      }).toList(),
    );
  }
}