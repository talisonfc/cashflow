import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:origami/origami.dart';
import 'widgets.dart';

class ExpensesView extends GetView<ExpensesController> {
  const ExpensesView({super.key, required this.id});

  final String id;

  @override
  String? get tag => id;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) {
          final expenses = state ?? [];
          return RefreshIndicator(
            onRefresh: () async {
              controller.load();
            },
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                final expense = expenses[index];

                return ExpenseWidget(expense: expense);

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
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16))),
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: ListView(
                                    padding: EdgeInsets.all(16),
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const H5('Despesa'),
                                          CloseButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ),
                                      Text(expense.description),
                                      Text(expense.when.toString()),
                                      Text(
                                          'R\$ ${expense.value.toStringAsFixed(2)}'),
                                      Text(expense.categoryId ??
                                          'Sem categoria'),
                                      Text(expense.contextId ?? 'Sem contexto')
                                    ],
                                  )),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 16),
                                    child: Button(
                                      label: 'Remover',
                                      onPressed: () {
                                        controller.delete(expense);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  // leading: CircleAvatar(
                  //   child: Icon(Icons.food_bank),
                  // ),
                  title: Text(expense.description),
                  subtitle: Text(expense.when.toString()),
                  trailing: Text('R\$ ${expense.value.toStringAsFixed(2)}'),
                );
              },
              itemCount: expenses.length,
            ),
          );
        },
        onEmpty: PageState(
            type: PageStateType.empty,
            title: 'Sem despesas',
            subtitle: 'Adicione uma despesa para começar',
            action: Button(
              label: 'Adicionar',
              onPressed: () {
                // Get.toNamed('/expenses/add');
              },
            )),
        onLoading: Center(child: CircularProgressIndicator()),
        onError: (error) {
          return Center(child: Text(error.toString()));
        });
  }
}
