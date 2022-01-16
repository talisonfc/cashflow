import 'package:caixabios/cash_flow_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class RootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet(
      initialRoute: CashFlowRoutes.initial,
      key: Get.nestedKey(CashFlowRoutes.homePath),
    );
  }
}
