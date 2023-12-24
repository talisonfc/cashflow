import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'cashflow_availables_bindings.dart';
import 'cashflow_availables_controller.dart';

class CashflowAvailables extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CashflowAvailablesController>(initState: (state) {
      CashflowAvailablesBindings().dependencies();
    }, builder: (controller) {
      return controller.obx((state) {
        return Row(
          children: (state ?? [])
              .map((cashflow) => cashflowButton(context, cashflow))
              .toList(),
        );
      });
    });
  }

  Widget cashflowButton(
      BuildContext context, CashflowDefinitionEntity cashflow) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.cashflowDetails.replaceAll(':id', cashflow.id!));
      },
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(25)),
              child: Icon(Icons.zoom_out_map),
            ),
            const SizedBox(height: 8),
            Text(cashflow.name ?? 'Cashflow',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
