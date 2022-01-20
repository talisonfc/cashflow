import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  final Function() onSend;

  ResetPasswordPage({required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      elevation: 4,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16),
        width: 500,
        // height: 500,
        child: Form(
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              Text('Digite seu e-mail e clique em enviar'),
              SizedBox(
                height: 16,
              ),
              FotonicaTextField(
                label: 'E-mail',
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(onPressed: onSend, child: Text('Enviar'))
            ],
          ),
        ),
      ),
    ));
  }
}
