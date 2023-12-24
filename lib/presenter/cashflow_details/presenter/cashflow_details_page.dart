import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'cashflow_details_controller.dart';
import 'components/components.dart';
import 'cashflow_details_by_year.dart';

class CashflowDetailsPage extends GetView<CashflowDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Fluxo de Caixa'), elevation: 0),
        body: controller.obx(
            (state) {
              return CashflowDetailsByYear();
            },
            onLoading: (Center(child: CircularProgressIndicator())),
            onError: (error) {
              return Center(child: Text(error.toString()));
            }),
        floatingActionButton:
            FloatingActionButtonWithMenu(cashflowId: controller.cashflowId));
  }
}
