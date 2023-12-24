import 'package:cashflow/presenter/home/widgets/cashflow_by_month_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: ReactiveForm(
                        formGroup: FormGroup({
                          'year': FormControl<String>(value: '2023'),
                        }),
                        child: ReactiveDropdownField(
                            formControlName: 'year',
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                labelText: 'Ano',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                isDense: true),
                            items: List.generate(
                                9,
                                (index) => DropdownMenuItem(
                                    value: '202${index + 1}',
                                    child: Text('202${index + 1}'))))),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TabBar(
                      padding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      controller: tabController,
                      isScrollable: true,
                      indicator: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      unselectedLabelColor: Colors.black,
                      onTap: (index) {
                        Get.parameters = {
                          'month': '${index + 1}',
                          'year': '2023'
                        };
                        widget.onMonthChanged(index + 1);
                      },
                      splashBorderRadius: BorderRadius.circular(32),
                      tabs: List.generate(monthNames.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(monthNames[index]),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: List.generate(monthNames.length, (index) {
                  return CashflowByMonthView(
                    key: Key('CASHFLOW_$index'),
                    id: 'CASHFLOW/$index',
                  );
                }),
              ),
            ),
          ],
        ));
  }
}
