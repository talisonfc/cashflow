import 'package:cashflow/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class FloatingActionButtonWithMenu extends StatefulWidget {
  const FloatingActionButtonWithMenu({Key? key, required this.cashflowId})
      : super(key: key);

  final String cashflowId;

  @override
  State<StatefulWidget> createState() {
    return _FloatingActionButtonWithMenu();
  }
}

class _FloatingActionButtonWithMenu
    extends State<FloatingActionButtonWithMenu> {
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (!isMenuOpen) {
          showBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(.8),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 48,
                      right: 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // TextButton.icon with icon on the right side of the text
                        TextButton.icon(
                            onPressed: () {},
                            label: Icon(Icons.compare_arrows_rounded),
                            icon: Text('Transferência')),
                        TextButton.icon(
                            onPressed: () {
                              print(
                                  '${RouteName.cashflowDetails}${RouteName.expense}'
                                      .replaceAll(':id', widget.cashflowId));
                              Get.toNamed(
                                  '${RouteName.cashflowDetails}${RouteName.expense}'
                                      .replaceAll(':id', widget.cashflowId));
                            },
                            label: Icon(Icons.start_rounded),
                            icon: Text('Saída')),
                        TextButton.icon(
                            onPressed: () {
                              Get.toNamed(
                                  '${RouteName.cashflowDetails}${RouteName.income}'
                                      .replaceAll(':id', widget.cashflowId));
                            },
                            label: Icon(Icons.reply_rounded),
                            icon: Text('Entrada'))
                      ],
                    ),
                  ),
                );
              });
        } else {
          Navigator.of(context).pop();
        }
        setState(() {
          isMenuOpen = !isMenuOpen;
        });
      },
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: AlwaysStoppedAnimation(isMenuOpen ? 1 : 0),
      ),
    );
  }
}
