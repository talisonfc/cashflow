import 'package:flutter/material.dart';

class YearSelector extends StatefulWidget {
  const YearSelector(
      {super.key, required this.initialValue, required this.onYearChanged});

  final Function(int) onYearChanged;
  final int initialValue;

  @override
  State<YearSelector> createState() => _YearSelectorState();
}

class _YearSelectorState extends State<YearSelector> {
  late List<int> years;

  @override
  void initState() {
    super.initState();
    years = List.generate(5, (index) {
      return widget.initialValue - 2 + index;
    });
  }

  void update(int year) {
    setState(() {
      years = List.generate(5, (index) {
        return year - 2 + index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: years
          .asMap()
          .map((index, year) {
            return MapEntry(
                index,
                TextButton(
                    onPressed: () {
                      update(year);
                    },
                    child: Text(year.toString(),
                        style: TextStyle(
                            fontSize: 10 *
                                fontSizeWeight(
                                  index + 1,
                                ),
                            fontWeight: FontWeight.lerp(FontWeight.w100,
                                FontWeight.bold, colorWeight(index + 1) / 4),
                            color: Colors.black
                                .withOpacity(colorWeight(index + 1) / 3)))));
          })
          .values
          .toList(),
    );
  }

  double fontSizeWeight(int index) {
    if (index < 3) {
      return index / 2 - 1 / 2 + 1;
    }
    return -index / 2 + 5 / 2 + 1;
  }

  double colorWeight(int index) {
    if (index < 3) {
      return index / 2 - 1 / 2 + 2;
    }
    return -index / 2 + 5 / 2 + 2;
  }
}
