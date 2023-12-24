import 'package:cashflow/domain/_exports.dart';
import 'package:flutter/material.dart';

class ExpenseWidget extends StatelessWidget {
  const ExpenseWidget({Key? key, required this.expense}) : super(key: key);

  final ExpenseEntity expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.input,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelValueTile(label: 'Descrição', value: expense.description),
              LabelValueTile(label: 'Valor', value: expense.value.toString()),
              LabelValueTile(label: 'Data', value: expense.when.toString()),
              LabelValueTile(
                  label: 'Categoria', value: expense.categoryId ?? ''),
              LabelValueTile(label: 'Contexto', value: expense.contextId ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}

class LabelValueTile extends StatelessWidget {
  const LabelValueTile({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label, value;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: label, style: TextStyle(color: Colors.grey, fontSize: 10)),
      TextSpan(text: '\n'),
      TextSpan(
          text: value, style: TextStyle(color: Colors.black, fontSize: 16)),
    ]));
  }
}
