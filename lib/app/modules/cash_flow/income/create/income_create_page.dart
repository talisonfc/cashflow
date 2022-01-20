import 'package:caixabios/app/modules/cash_flow/income/create/income_create_controller.dart';
import 'package:caixabios/app/modules/cash_flow/shared/components/payment_type_options.dart';
import 'package:caixabios/cash_flow_routes.dart';
import 'package:caixabios/fotonica_ui_components/dialog_Area.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:caixabios/fotonica_ui_components/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class IncomeCreatePage extends GetView<IncomeCreateController> {
  @override
  Widget build(BuildContext context) {
    return DialogArea(
      child: SimpleDialog(
        title: Text('Entrada'),
        children: [
          Container(
            width: 500,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: controller.obx(
                (state) => Form(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        FotonicaTextField(
                            // focusNode: focusClient,
                            label: "Cliente",
                            controller: TextEditingController(
                                text: controller.state!.clientName),
                            onChange: (v) {
                              controller.state!.clientName = v;
                            }),
                        FotonicaTextField(
                          label: "Valor",
                          type: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [InputFormatters.number()],
                          controller: TextEditingController(
                              text: controller.state!.value.toString()),
                          onChange: (v) {
                            if (v.isNotEmpty)
                              controller.state!.value = double.parse(v);
                          },
                        ),
                        PaymentTypeOptions(
                          initialData: controller.state!.paymentType,
                          onChanged: (pt) {
                            if (pt != null) controller.state!.paymentType = pt;
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
                                  CashFlowRoutes.back();
                                  // TODO: save
                                  // repository.cashFlowModel
                                  //     .addIncome(incomeModel);
                                  // incomeModel = new IncomeModel(
                                  //     createdAt: DateTime.now());
                                  // repository.save();
                                  // Navigator.pop(context, true);
                                  // TODO: permanecer na pagina para adicionar novo income
                                },
                                child: Text("Salvar"))
                          ],
                        )
                      ],
                    ),
                  ),
                  onLoading: Center(child: CircularProgressIndicator.adaptive(),)
              ),
            ),
          )
        ],
      ),
    );
  }
}
