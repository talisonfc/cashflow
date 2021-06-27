import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardReport extends StatelessWidget {
  final String title;
  final String value;
  final Color textValueColor;

  CardReport({this.title, this.value, this.textValueColor});

  @override
  Widget build(BuildContext context) {
    return Consumer<CashFlowRepository>(
      builder: (ctx, repository, child) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text:
                TextSpan(style: Theme.of(context).textTheme.bodyText1, children: [
              TextSpan(
                text: "$title\n",
              ),
              TextSpan(
                text: repository.hideValues ? "-" : value,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: textValueColor),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
