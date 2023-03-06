import 'package:cashflow/presenter/home/widgets/cashflow_by_month_view.dart';
import 'package:flutter/material.dart';

class CashflowByYearView extends StatefulWidget {
  final Function(int month) onMonthChanged;

  const CashflowByYearView({super.key, required this.onMonthChanged});

  @override
  State<StatefulWidget> createState() {
    return _CashflowByYearView();
  }
}

class _CashflowByYearView extends State<CashflowByYearView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: monthNames.length,
        vsync: this,
        initialIndex: DateTime.now().month - 1);
  }

  List<String> monthNames = <String>[
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

  double? cw = null;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: monthNames.length,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: TabBar(
                controller: tabController,
                isScrollable: true,
                indicator: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(32),
                ),
                unselectedLabelColor: Colors.black,
                onTap: (index) {
                  widget.onMonthChanged(index+1);
                },
                tabs: List.generate(monthNames.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(monthNames[index]),
                  );
                }),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: List.generate(monthNames.length, (index) {
                  return CashflowByMonthView();
                }),
              ),
            ),
          ],
        ));
  }
}
