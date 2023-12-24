import 'package:flutter/material.dart';
import 'package:origami/origami.dart';
import 'widgets.dart';

class CashflowByMonthView extends StatelessWidget {
  const CashflowByMonthView({super.key, required this.id});

  final String id;

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
                    color:
                        Theme.of(context).colorScheme.secondary.withOpacity(.2),
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
                    splashBorderRadius: BorderRadius.circular(32),
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
              Expanded(
                  child: TabBarView(children: [
                ExpensesView(
                  id: '$id/EXPENSES',
                ),
                IncomesView(
                  id: '$id/INCOMES',
                )
              ]))
            ],
          ),
        ));
  }
}
