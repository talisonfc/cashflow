import 'package:cashflow/presenter/income/income.dart';
import 'package:cashflow/presenter/presenter.dart';
import 'package:cashflow/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const CashFlowApp());
}

class CashFlowApp extends StatelessWidget {
  const CashFlowApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RouteName.home,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            transition: Transition.noTransition,
            name: RouteName.home,
            page: () => HomePage(),
            binding: HomeBindings()),
        GetPage(
            name: RouteName.category,
            page: () => CategoryPage(),
            binding: CategoryBindings()),
        GetPage(
            name: RouteName.context,
            page: () => ContextPage(),
            binding: ContextBindings()),
        GetPage(
            transition: Transition.rightToLeft,
            name: RouteName.expense,
            page: () => ExpensePage(),
            binding: ExpenseBindings()),
        GetPage(
            transition: Transition.rightToLeft,
            name: RouteName.origin,
            page: () => OriginPage(),
            binding: OriginBindings()),
        GetPage(
            transition: Transition.rightToLeft,
            name: RouteName.income,
            page: () => IncomePage(),
            binding: IncomeBindings()),
      ],
    );
  }
}
