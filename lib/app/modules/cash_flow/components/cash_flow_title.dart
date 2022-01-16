import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashFlowTitle extends StatelessWidget {
  final CashFlowRepository repository;

  CashFlowTitle({required this.repository});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
              "Fluxo de caixa (${DateFormat("d MMM yyyy").format(repository.cashFlowModel.createdAt)})"),
        ),
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              DateTime initialDate =
                  repository.cashFlowModel.createdAt;
              DateTime firstDate = DateTime.now().subtract(Duration(days: 7));
              DateTime lastDate = DateTime.now().add(Duration(days: 5));
              showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: firstDate,
                      lastDate: lastDate)
                  .then((value) {
                if (value != null) {
                  repository.cashFlowModel.createdAt = value;
                  repository.save();
                }
              });
            })
      ],
    );
  }
}
