

import 'package:flutter/services.dart';

class InputFormatters {

  static TextInputFormatter number(){
    return FilteringTextInputFormatter.allow(
        RegExp(r"[0-9.]"));
  }
}