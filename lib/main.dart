import 'package:caixabios/app/app_page.dart';
import 'package:caixabios/app/repositories/cash_flow_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (ctx) => CashFlowRepository())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('es', ''), // Spanish, no country code
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            ),
          ),
        ),
        textTheme: TextTheme(
            // headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            // headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            // bodyText2: TextStyle(fontSize: 20.0, fontFamily: 'Hind'),
            // bodyText1: TextStyle(fontSize: 20.0, fontFamily: 'Hind'),
            // button: TextStyle(fontSize: 20.0, fontFamily: 'Hind'),
            ),
      ),
      home: AppPage(),
    );
  }
}
