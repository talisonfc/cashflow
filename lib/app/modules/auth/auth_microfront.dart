import 'package:caixabios/app/modules/auth/presenter/auth_bindings.dart';
import 'package:caixabios/app/modules/auth/presenter/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AuthMicroFront {
  Page page({required String name, required Function() onAfterLogin}) {
    return GetPage(
        name: name,
        page: () => AuthView(onAfterLogin: onAfterLogin),
        binding: AuthBindings());
  }
}
