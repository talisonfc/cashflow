import 'package:cashflow/domain/_exports.dart';
import 'package:cashflow/presenter/presenter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'cashflow_details_by_month_controller.dart';

class CashflowDetailsByMonth extends GetView<CashflowDetailsByMonthController> {
  CashflowDetailsByMonth({required this.id});

  final String id;

  @override
  String? get tag => id;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) {
          return RefreshIndicator(
            onRefresh: () async {
              return controller.load();
            },
            child: ListView(
              children: (state ?? []).map((transaction) {
                if (transaction is ExpenseEntity)
                  return buildExpense(context, transaction);
                else if (transaction is IncomeEntity)
                  return buildIncome(context, transaction);
                else
                  return Divider();
              }).toList(),
            ),
          );
        },
        onEmpty: Center(child: Text('Nenhum dado encontrado')),
        onLoading: Center(child: CircularProgressIndicator()),
        onError: (error) {
          return Center(
            child: Text('Erro ao carregar dados'),
          );
        });
  }

  Widget buildDate(BuildContext context, DateTime date) {
    final dayWithTwoDigits = date.day.toString().padLeft(2, '0');
    final first3LettersOfMonth = CashflowDetailsUtils.getMonthName(date.month)
        .substring(0, 3)
        .toUpperCase();
    return Text('$dayWithTwoDigits $first3LettersOfMonth',
        style: Theme.of(context).textTheme.bodyLarge);
  }

  Widget buildIncome(BuildContext context, IncomeEntity income) {
    return ListTile(
      leading: buildDate(context, income.when!),
      trailing: Text('R\$ ${income.value.toStringAsFixed(2)}',
          style: TextStyle(color: Colors.green)),
      title: Text(income.name,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      subtitle: Text('Cartão de crédito, Talison Nubank',
          style: TextStyle(color: Colors.green)),
    );
  }

  Widget buildExpense(BuildContext context, ExpenseEntity expense) {
    return ListTile(
      leading: buildDate(context, expense.when),
      trailing: Text('R\$ ${expense.value.toStringAsFixed(2)}'),
      title: Text(expense.description),
      subtitle: Text('Cartão de crédito, Talison Nubank'),
    );
  }
}
