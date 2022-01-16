import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:caixabios/fotonica_ui_components/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CardReport extends GetView<CashFlowRepository> {
  final String title;
  final String text;
  final double value;
  final Color? textValueColor;
  final List<TextSpan> adicionalInfos;
  final Function(dynamic v)? onChanged;

  CardReport(
      {required this.title,
      required this.text,
      this.value = 0,
      this.textValueColor,
      this.adicionalInfos = const [],
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> content = [
      TextSpan(
        text: "$title\n",
      ),
      TextSpan(
        text: controller.hideValues ? "-" : text,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold, fontSize: 26, color: textValueColor),
      ),
    ];

    content.addAll(adicionalInfos);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: content,
              ),
            ),
            if (this.onChanged != null)
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          TextEditingController controller =
                              TextEditingController(text: value.toString());
                          return SimpleDialog(
                            title: Text(title),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: FotonicaTextField(
                                  placeholder: title,
                                  controller: controller,
                                  inputFormatters: [InputFormatters.number()],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SimpleDialogOption(
                                      child: Text("Cancelar"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SimpleDialogOption(
                                      child: Text("Salvar"),
                                      onPressed: () {
                                        Navigator.pop(context, controller.text);
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        }).then((v) {
                      if (v != null) onChanged!(v);
                    });
                  })
          ],
        ),
      ),
    );
  }
}
