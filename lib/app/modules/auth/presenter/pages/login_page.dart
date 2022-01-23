import 'package:caixabios/app/modules/auth/presenter/auth_controller.dart';
import 'package:caixabios/fotonica_ui_components/fotonica_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends GetView<AuthController> {
  final Function() goToRegister;
  final Function() goToResetPassword;
  final Function() onSignIn;

  LoginPage(
      {required this.goToRegister,
      required this.goToResetPassword,
      required this.onSignIn});

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
        child: ReactiveForm(
          formGroup: controller.loginForm,
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
              Text('Autenticação via E-mail e Senha'),
              SizedBox(
                height: 16,
              ),
              ReactiveTextField(
                formControlName: 'email',
                decoration: InputDecoration(
                    hintText: 'Digite seu e-mail',
                    label: Text('E-mail')),
              ),
              SizedBox(
                height: 8,
              ),
              ReactiveTextField(
                formControlName: 'password',
                decoration: InputDecoration(
                    hintText: 'Digite sua senha', label: Text('Senha')),
                obscureText: true,
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(onPressed: onSignIn, child: Text('Entrar')),
              TextButton(
                  onPressed: goToResetPassword,
                  child: Text('Esqueceu a senha?')),
              TextButton(
                  onPressed: () {
                    print(controller.loginForm.value);
                    print(controller.loginForm.valid);
                    goToRegister();
                  },
                  child: Text('Fazer cadastro')),
              // SizedBox(
              //   height: 16,
              // ),
              // Divider(),
              // SizedBox(
              //   height: 16,
              // ),
              // Text('Autenticação via Google'),
              // SizedBox(
              //   height: 8,
              // ),
              // ElevatedButton(onPressed: () {}, child: Text('Google'))
            ],
          ),
        ),
      ),
    ));
  }
}
