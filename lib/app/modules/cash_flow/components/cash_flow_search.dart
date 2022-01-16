import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashFlowSearch extends StatelessWidget {
  final CashFlowRepository repository;

  CashFlowSearch({required this.repository});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: FotonicaTextField(
            placeholder: "Escreva aqui..",
            filled: false,
            onChange: (v) {
              repository.query = v;
            },
            textStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
            textStyleLabel: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
          ),
        ),
        Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Text("Data:"),
            ),
            DropdownButton(
                hint: Text("Relatórios"),
                underline: Container(),
                onChanged: repository.setCashFlow,
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.white,
                dropdownColor: Theme.of(context).primaryColor,
                value: repository.cashFlowModel,
                items: repository.businessModel.businessCashFlow
                    .map((cf) {
                  return DropdownMenuItem(
                    value: cf,
                    child: Text(
                      DateFormat("d MMM yyyy").format(cf.createdAt),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                  );
                }).toList()),
          ],
        )
      ],
    );
  }
}
