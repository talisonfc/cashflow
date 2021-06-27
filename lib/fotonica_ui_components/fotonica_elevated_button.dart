import 'package:flutter/material.dart';

class FotonicaElevatedButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final Icon icon;
  final Color color;
  final Color labelColor;

  FotonicaElevatedButton({this.label, this.onPressed, this.icon, this.color, this.labelColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color != null ? color : Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Wrap(
        children: [
          if(icon != null)
            icon,
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold, color: this.labelColor != null ? this.labelColor : Colors.white),
          )
        ],
      ),
    );
  }
}
