import 'package:caixabios/app/model/cash_flow_model.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:caixabios/fotonica_ui_components/input_formatters.dart';
import 'package:flutter/material.dart';

class CloseCashFlowAction {
  final CashFlowModel cashFlow;
  final Function()? onSave;
  final Function()? onCancel;

  CloseCashFlowAction({required this.cashFlow, this.onCancel, this.onSave});

  void call(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: Text("Quer deixar algum valor para o próximo dia?"),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FotonicaTextField(
                  label: "Valor",
                  controller: TextEditingController(
                      text: cashFlow.valueToNextDay.toString()),
                  inputFormatters: [InputFormatters.number()],
                  onChange: (v) {
                    cashFlow.valueToNextDay = double.parse(v);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: onCancel, child: Text("Cancelar")),
                    TextButton(onPressed: onSave, child: Text("Salvar"))
                  ],
                ),
              )
            ],
          );
        });
  }
}
