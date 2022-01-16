import 'package:caixabios/app/modules/cash_flow/expense/create/expense_create_controller.dart';
import 'package:caixabios/app/modules/cash_flow/shared/components/output_options.dart';
import 'package:caixabios/cash_flow_routes.dart';
import 'package:caixabios/fotonica_ui_components/dialog_Area.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:caixabios/fotonica_ui_components/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ExpenseCreatePage extends GetView<ExpenseCreateController> {
  FocusNode firstNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return DialogArea(
        child: SimpleDialog(
      title: Text("Saída"),
      children: [
        Container(
            width: 500,
            // height: 500,
            child: controller.obx(
              (state) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      FotonicaTextField(
                        label: "Descrição",
                        focusNode: firstNode,
                        maxLines: 4,
                        controller: TextEditingController(
                            text: controller.state!.description),
                        onChange: (v) {
                          controller.state!.description = v;
                        },
                      ),
                      FotonicaTextField(
                        label: "Valor",
                        controller: TextEditingController(
                            text: controller.state!.value.toString()),
                        inputFormatters: [InputFormatters.number()],
                        onChange: (v) {
                          if (v.isNotEmpty)
                            controller.state!.value = double.parse(v);
                        },
                        type: TextInputType.number,
                      ),
                      OutputOptions(
                        initialData: controller.state!.outputOption,
                        onChanged: (v) {
                          if (v != null) controller.state!.outputOption = v;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              CashFlowRoutes.back();
                            },
                            child: Text("Cancelar"),
                          ),
                          TextButton(
                              onPressed: () {
                                controller.save();
                              },
                              child: Text("Salvar"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ))
      ],
    ));
  }
}
