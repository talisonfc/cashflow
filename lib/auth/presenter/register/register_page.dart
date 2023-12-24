import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:origami/origami.dart';
import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.primaries[0],
            Colors.primaries[1],
          ])),
        ),
      ),
      body: ReactiveForm(
          formGroup: controller.formGroup,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            children: [
              ReactiveTextFieldWidget(
                formControlName: 'email',
                label: 'E-mail',
                suffix: Icon(Icons.email),
              ),
              SizedBox(height: 16),
              ReactiveTextFieldWidget(
                formControlName: 'password',
                label: 'Senha',
                suffix: Icon(Icons.lock),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ReactiveTextFieldWidget(
                formControlName: 'confirmPassword',
                label: 'Confirmar senha',
                suffix: Icon(Icons.lock),
                obscureText: true,
              ),
              SizedBox(height: 16),
              Obx(() {
                return ButtonWithLoading(
                    loading: controller.isRequesting.value,
                    onPressed: () {
                      controller.register();
                    },
                    label: 'Cadastrar');
              }),
            ],
          )),
    );
  }
}
