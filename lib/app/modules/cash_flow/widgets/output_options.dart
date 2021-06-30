

import 'package:caixabios/app/model/expense_model.dart';
import 'package:flutter/material.dart';

class OutputOptions extends StatefulWidget{

  final OutputOption initialData;
  final Function(OutputOption) onChanged;

  OutputOptions({this.initialData, this.onChanged});

  @override
  State<StatefulWidget> createState() {
    return OutputOptionsState();
  }
}

class OutputOptionsState extends State<OutputOptions>{

  OutputOption outputOption;

  @override
  void initState() {
    super.initState();
    setState(() {
      outputOption = widget.initialData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: OutputOption.values.map((oo){
        return RadioListTile(
          title: Text(oo.name()),
          value: oo,
          groupValue: outputOption,
          onChanged: (el){
            setState(() {
              outputOption = el;
            });
            widget.onChanged(el);
          },
        );
      }).toList(),
    );
  }
}