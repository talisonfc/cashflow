import 'package:cashflow/presenter/home/cashflow_by_year_view.dart';
import 'package:cashflow/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:origami/origami.dart';
import 'home.dart';

class HomePage extends GetView<HomeController> {
  final items = <String, BottomNavigationBarItem>{
    RouteName.home: BottomNavigationBarItem(
        icon: Icon(Icons.swap_vert_rounded), label: 'Fluxo'),
    RouteName.category: BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined), label: 'Categoria'),
    RouteName.context: BottomNavigationBarItem(
        icon: Icon(Icons.spoke_outlined), label: 'Contexto'),
    // RouteName.tags:
    //     BottomNavigationBarItem(icon: Icon(Icons.tag), label: 'Tags'),
    // RouteName.target:
    //     BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Destino'),
    RouteName.origin: BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet_outlined), label: 'Origem'),
  };

  final monthNames = <String>[
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  final years = [
    '2015',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cash Flow'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(RouteName.expense);
                },
                icon: Icon(Icons.upgrade_rounded)),
            IconButton(
                onPressed: () {
                  Get.toNamed(RouteName.income);
                },
                icon: Icon(Icons.move_down_rounded))
          ],
        ),
        body: controller.obx((state) {
          return PageState(
              type: PageStateType.empty,
              title: 'Carregando...',
            );
          return CashflowByYearView(
            onMonthChanged: (month) {
              controller.searchByMonth(month: month);
            },
          );
        },
            onLoading: const Center(
                child: PageState(
              type: PageStateType.empty,
              title: 'Carregando...',
            )),
            onError: (message) => const Center(
                  child: Text('Error'),
                )),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            Get.toNamed(items.keys.toList()[index]);
          },
          items: items.values.toList(),
        ),
      ),
    );
  }
}
