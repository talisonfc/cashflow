import 'package:cashflow/presenter/presenter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class IncomesView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      final incomes = controller.state!.incomes;
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: Colors.grey.shade300,
        ),
        itemBuilder: (context, index) {
          final income = incomes[index];
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
                            Text(income.name),
                            Text(income.when.toString()),
                            Text('R\$ ${income.value.toStringAsFixed(2)}'),
                          ],
                        ),
                      ),
                    );
                  });
            },
            leading: CircleAvatar(
              child: Icon(Icons.food_bank),
            ),
            title: Text(income.name),
            subtitle: Text(income.when.toString()),
            trailing: Text('R\$ ${income.value.toStringAsFixed(2)}'),
          );
        },
        itemCount: incomes.length,
      );
    });
  }
}
