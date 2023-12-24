import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:origami/origami.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.primaries[0],
                  Colors.primaries[1],
                ],
              ),
            ))),
        Expanded(
          flex: 3,
          child: ReactiveForm(
            formGroup: controller.formGroup,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              children: [
                SizedBox(height: 16),
                ReactiveTextFieldWidget(
                  formControlName: 'email',
                  label: 'E-mail',
                  suffix: Icon(Icons.email),
                ),
                SizedBox(height: 16),
                Obx(
                  () => ReactiveTextFieldWidget(
                    formControlName: 'password',
                    label: 'Senha',
                    suffix: IconButton(
                        onPressed: () {
                          controller.obscureText.value =
                              !controller.obscureText.value;
                        },
                        icon: Icon(Icons.lock)),
                    obscureText: controller.obscureText.value,
                  ),
                ),
                SizedBox(height: 16),
                Obx(() {
                  return ButtonWithLoading(
                      loading: controller.isRequesting.value,
                      onPressed: () {
                        controller.login();
                      },
                      label: 'Entrar');
                }),
                SizedBox(height: 16),
                LinkWidget(
                  label: 'Esqueceu a senha?',
                  onPressed: () {
                    Get.toNamed('/auth/reset-password');
                  },
                ),
                LinkWidget(
                  label: 'Criar conta',
                  onPressed: () {
                    Get.toNamed('/auth/register');
                  },
                )
              ],
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Caption('Outros métodos de login'),
                Wrap(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.facebook)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.architecture))
                  ],
                )
              ],
            ))
      ],
    ));
  }
}
