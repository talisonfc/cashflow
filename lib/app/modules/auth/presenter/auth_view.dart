import 'dart:async';

import 'package:caixabios/app/modules/auth/presenter/auth_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import './pages/_exports.dart';
import 'package:flutter/material.dart';

enum AuthState { REGISTER, LOGIN, RESET_PASSWORD }

class AuthView extends GetView<AuthController> {
  final Function() onAfterLogin;

  AuthView({required this.onAfterLogin});

  final authStateStreamController = StreamController<AuthState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: StreamBuilder(
          stream: authStateStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return Builder(builder: (context) {
                switch (snapshot.data) {
                  case AuthState.REGISTER:
                    {
                      return RegisterPager(
                        onRegister: () {
                          controller.register();
                          authStateStreamController.add(AuthState.LOGIN);
                        },
                      );
                    }
                  case AuthState.RESET_PASSWORD:
                    {
                      return ResetPasswordPage(
                        onSend: (){
                          controller.reset();
                          authStateStreamController.add(AuthState.LOGIN);
                        },
                      );
                    }
                  default:
                    {
                      return LoginPage(
                        goToRegister: () {
                          authStateStreamController.add(AuthState.REGISTER);
                        },
                        goToResetPassword: (){
                          authStateStreamController.add(AuthState.RESET_PASSWORD);
                        },
                        onSignIn: (){
                          // controller.signInWithEmailAndPassword();
                          onAfterLogin();
                        },
                      );
                    }
                }
              });
            } else {
              authStateStreamController.add(AuthState.LOGIN);
              return Center(
                child: Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      Text('Inicializando...')
                    ]),
              );
            }
          }),
    );
  }
}
