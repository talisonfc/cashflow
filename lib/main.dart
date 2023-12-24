import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Transition;
// import 'package:amplify_api/amplify_api.dart';
// import 'package:cashflow/presenter/modules.dart';
// import 'package:cashflow/modules/userinfo/userinfo.dart';
import 'package:cashflow/presenter/income/income.dart';
import 'package:cashflow/presenter/presenter.dart';
import 'package:cashflow/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:origami/origami.dart';
import 'amplifyconfiguration.dart';
import 'auth/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(CashFlowApp());
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAuthCognito());
    // await Amplify.addPlugin(AmplifyAPI());
    await Amplify.configure(amplifyconfig);
    safePrint('Successfully configured');
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}

class CashFlowApp extends StatelessWidget {
  const CashFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: GetMaterialApp(
        initialRoute: RouteName.home,
        debugShowCheckedModeBanner: false,
        theme: OrigamiTheme.build(),
        getPages: [
          ...AuthModule(name: RouteName.auth).pages,
          GetPage(
              transition: Transition.noTransition,
              name: RouteName.home,
              page: () => HomePage(),
              binding: HomeBindings()),
          GetPage(
              name: RouteName.category,
              page: () => CategoryPage(),
              binding: CategoryBindings()),
          GetPage(
              name: RouteName.context,
              page: () => ContextPage(),
              binding: ContextBindings()),
          GetPage(
              transition: Transition.rightToLeft,
              name: RouteName.origin,
              page: () => OriginPage(),
              binding: OriginBindings()),
          GetPage(
              transition: Transition.rightToLeft,
              name: RouteName.cashflowDetails,
              page: () => CashflowDetailsPage(),
              binding: CashflowDetailsBindings(),
              children: [
                GetPage(
                    transition: Transition.rightToLeft,
                    name: RouteName.income,
                    page: () => IncomePage(),
                    binding: IncomeBindings()),
                GetPage(
                    transition: Transition.rightToLeft,
                    name: RouteName.expense,
                    page: () => ExpensePage(),
                    binding: ExpenseBindings()),
              ]),
          GetPage(
              transition: Transition.rightToLeft,
              name: RouteName.userinfo,
              page: () => UserInfoPage(),
              binding: UserInfoBindings()),
        ],
        builder: Authenticator.builder(),
      ),
    );
  }
}
