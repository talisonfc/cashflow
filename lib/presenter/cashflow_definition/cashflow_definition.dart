import 'package:flutter/material.dart';
import 'presenter/presenter.dart';

class CashflowDefinition {
  static void open(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return CashflowDefinitionView();
        });
  }
}
