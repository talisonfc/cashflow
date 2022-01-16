import 'package:flutter/material.dart';

class DialogArea extends StatelessWidget {
  final Widget child;

  DialogArea({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.black.withOpacity(0.5), child: child);
  }
}
