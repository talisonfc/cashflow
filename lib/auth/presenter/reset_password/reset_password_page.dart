import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:origami/origami.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'reset_password_controller.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Redefinir senha'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.primaries[0],
              Colors.primaries[1],
            ])),
          ),
        ),
        body: Column(
          children: [
            ReactiveForm(
              formGroup: controller.formGroup,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                children: [
                  BodyText1('Esqueceu sua senha?'),
                  Caption('Para resetar sua senha, digite seu e-mail abaixo.'),
                  ReactiveTextFieldWidget(
                    formControlName: 'email',
                    label: 'E-mail',
                    suffix: Icon(Icons.email),
                  ),
                  SizedBox(height: 16),
                  Obx(() {
                    return ButtonWithLoading(
                        loading: controller.isRequesting.value,
                        onPressed: () {
                          controller.reset();
                        },
                        label: 'Entrar');
                  }),
                ],
              ),
            ),
          ],
        ));
  }
}
