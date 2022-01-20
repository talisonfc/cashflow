import 'dart:js';

import 'package:caixabios/app/modules/auth/auth_microfront.dart';
import 'package:caixabios/app/modules/home/home_page.dart';
import 'package:caixabios/app/modules/cash_flow/cash_flow_bindings.dart';
import 'package:caixabios/app/modules/cash_flow/cash_flow_page.dart';
import 'package:caixabios/app/modules/cash_flow/expense/create/expense_create_bindings.dart';
import 'package:caixabios/app/modules/cash_flow/expense/create/expense_create_page.dart';
import 'package:caixabios/app/modules/cash_flow/expense/expense_bindings.dart';
import 'package:caixabios/app/modules/cash_flow/expense/expense_page.dart';
import 'package:caixabios/app/modules/cash_flow/income/batch/income_batch_page.dart';
import 'package:caixabios/app/modules/cash_flow/income/create/income_create_bindings.dart';
import 'package:caixabios/app/modules/cash_flow/income/create/income_create_page.dart';
import 'package:caixabios/app/modules/cash_flow/income/income_bindings.dart';
import 'package:caixabios/app/modules/cash_flow/income/income_page.dart';
import 'package:caixabios/app/modules/workspace/workspace_view.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:caixabios/cash_flow_routes.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

abstract class MicroApp {}

abstract class MicroFront {}

final themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.blue,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    )),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        )),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    bodyText1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
    button: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
  ),
);

final app = GetMaterialApp.router(
  // home: Container(),
  title: 'Flutter Demo',
  debugShowCheckedModeBanner: false,
  localizationsDelegates: [
    // AppLocalizations.delegate, // Add this line
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('en', ''), // English, no country code
    const Locale('es', ''), // Spanish, no country code
  ],
  theme: themeData,
  // initialRoute: CashFlowRoutes.home,
  builder: (context, child) {
    return FutureBuilder<void>(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return child ?? SizedBox.shrink();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  },
  getPages: [
    GetPage(
        name: CashFlowRoutes.home,
        page: () => HomePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CashFlowRepository());
        })),
    AuthMicroFront().page(
        name: CashFlowRoutes.auth,
        onAfterLogin: () {
          CashFlowRoutes.toWorkspace();
        }) as GetPage,
    GetPage(
        name: CashFlowRoutes.workspace,
        page: () => WorkspaceView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CashFlowRepository());
        }),
        children: [
          GetPage(
              name: CashFlowRoutes.cashflow,
              page: () => CashFlowPage(),
              // participatesInRootNavigator: true,
              binding: CashFlowBindings(),
              bindings: [IncomeBindings(), ExpenseBindings()],
              transition: Transition.noTransition,
              opaque: false,
              children: [
                GetPage(
                    name: '${CashFlowRoutes.income}${CashFlowRoutes.addIncome}',
                    transition: Transition.fadeIn,
                    opaque: false,
                    page: () => IncomeCreatePage(),
                    binding: IncomeCreateBindings()),
                GetPage(
                    name:
                        '${CashFlowRoutes.income}${CashFlowRoutes.batchIncom}',
                    transition: Transition.fadeIn,
                    opaque: false,
                    page: () => IncomeBatchPage()),
                GetPage(
                    name:
                        '${CashFlowRoutes.expense}${CashFlowRoutes.addExpense}',
                    opaque: false,
                    transition: Transition.fadeIn,
                    page: () => ExpenseCreatePage(),
                    binding: ExpenseCreateBindings())
              ]),
        ])
  ],
);
