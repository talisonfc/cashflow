import 'package:flutter/material.dart';
import 'package:cashflow/presenter/home/home.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:origami/origami.dart';

class ExpensesView extends GetView<HomeController> {
  const ExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) {
          final expenses = state!.expenses;
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: Colors.grey.shade300,
            ),
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return ListTile(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              children: [
                                Text(expense.description),
                                Text(expense.when.toString()),
                                Text('R\$ ${expense.value.toStringAsFixed(2)}'),
                                Button(
                                  label: 'Remover',
                                  onPressed: (){},
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                leading: CircleAvatar(
                  child: Icon(Icons.food_bank),
                ),
                title: Text(expense.description),
                subtitle: Text(expense.when.toString()),
                trailing: Text('R\$ ${expense.value.toStringAsFixed(2)}'),
              );
            },
            itemCount: expenses.length,
          );
        },
        onLoading: Center(child: CircularProgressIndicator()),
        onError: (error) {
          return Center(child: Text(error.toString()));
        });
  }
}
