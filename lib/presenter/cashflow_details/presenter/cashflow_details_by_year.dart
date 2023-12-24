import 'package:cashflow/presenter/presenter.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'components/components.dart';
import 'cashflow_details_by_month.dart';

class CashflowDetailsByYear extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CashflowDetailsByYearState();
  }
}

class _CashflowDetailsByYearState extends State<CashflowDetailsByYear>
    with TickerProviderStateMixin {
  late TabController tabController;
  late List<String> monthNames;

  @override
  void initState() {
    super.initState();
    monthNames = CashflowDetailsUtils.monthNames.values.toList();
    tabController = TabController(
        length: monthNames.length,
        vsync: this,
        initialIndex: DateTime.now().month - 1);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: monthNames.length,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.center,
              child: YearSelector(
                initialValue: DateTime.now().year,
                onYearChanged: (year) {},
              ),
            ),
          ),
          TabBar(
            padding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            controller: tabController,
            isScrollable: true,
            indicator: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(16),
            ),
            unselectedLabelColor: Colors.black,
            splashBorderRadius: BorderRadius.circular(16),
            tabs: List.generate(monthNames.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(monthNames[index]),
              );
            }),
          ),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children: List.generate(monthNames.length, (index) {
                  return CashflowDetailsByMonth(
                    id: 'CASHFLOW/$index',
                  );
                })),
          ),
        ],
      ),
    );
  }
}
