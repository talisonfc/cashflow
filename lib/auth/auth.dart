import 'package:get/get.dart';
import 'presenter/presenter.dart';
import 'data/data.dart';

class AuthModuleBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<IAuthClient>(() => AuthClient());
  }
}

class AuthModule {
  AuthModule({this.name = '/auth'});

  final String name;

  List<GetPage> get pages => [
        GetPage(
            transition: Transition.noTransition,
            name: name,
            page: () => AuthPage(),
            binding: AuthBindings(),
            bindings: [AuthModuleBindings()]),
        GetPage(
            name: '$name/register',
            page: () => RegisterPage(),
            binding: RegisterBindings(),
            bindings: [AuthModuleBindings()]),
        GetPage(
            name: '$name/reset-password',
            page: () => ResetPasswordPage(),
            binding: ResetPasswordBindings(),
            bindings: [AuthModuleBindings()])
      ];
}
