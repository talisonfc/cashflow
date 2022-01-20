import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPager extends StatelessWidget {
  final Function() onRegister;

  RegisterPager({required this.onRegister});

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
              Container(
                width: 100,
                height: 100,
                child: Placeholder(),
              ),
              Text(
                'App Name',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text('Cadastro'),
              ElevatedButton(onPressed: onRegister, child: Text('Salvar'))
            ],
          ),
        ),
      ),
    ));
  }
}
