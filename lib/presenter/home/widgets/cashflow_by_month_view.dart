import 'package:cashflow/presenter/home/home.dart';
import 'package:cashflow/presenter/home/widgets/incomes_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:origami/origami.dart';
import 'widgets.dart';

class CashflowByMonthView extends GetView<HomeController> {
  const CashflowByMonthView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(.2),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: TabBar(
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    indicator: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.secondary,
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      Wrap(
                        children: [
                          IconLabeled(
                            icon: Icons.upgrade_rounded,
                            label: 'Saídas',
                          ),
                        ],
                      ),
                      IconLabeled(
                          icon: Icons.move_down_rounded, label: 'Entradas'),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Button(
              //     label: 'Adicionar',
              //     onPressed: () {},
              //   ),
              // ),
              Expanded(child: TabBarView(children: [ExpensesView(), IncomesView()]))
            ],
          ),
        ));
  }
}
