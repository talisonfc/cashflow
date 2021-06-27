import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String message;
  final Widget child;
  final Widget icon;

  Empty({Key key, this.message = "Any message defined", this.child, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          icon != null
              ? icon
              : Icon(
                  Icons.hourglass_empty,
                  size: 100,
                  color: Colors.grey,
                ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              this.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey),
            ),
          ),
          if (child != null) child
        ],
      ),
    );
  }
}
