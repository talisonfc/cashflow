import 'package:cashflow/presenter/home/cashflow_by_year_view.dart';
import 'package:cashflow/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:origami/origami.dart';
import '_exports.dart';
import '../presenter.dart';

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
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverSafeArea(
            sliver: SliverToBoxAdapter(
                child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          // height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.userinfo);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Stack(
                        children: [
                          ClipOval(
                            child: Image.network(
                              'https://avatars.githubusercontent.com/u/1006964?v=4',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              top: 2,
                              right: 2,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    shape: BoxShape.circle),
                              ))
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_active_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ))
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Olá, Talison',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              )
            ],
          ),
        ))),
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverList(
              delegate: SliverChildListDelegate([
            InkWell(
              onTap: () {
                CashflowDefinition.open(context);
              },
              child: Text(
                '+ Novo fluxo de caixa',
                textAlign: TextAlign.end,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(height: 16),
            CashflowAvailables()
          ])),
        )
      ],
    ));

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: MenuPage(),
        ),
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
          return CashflowByYearView(
            onMonthChanged: (month) {},
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
