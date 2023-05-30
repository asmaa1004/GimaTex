// @dart=2.9
import 'package:flutter/material.dart';
import 'package:gimatex/change_password/change_password.dart';
import 'package:gimatex/login/companies.dart';
import 'package:gimatex/login/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gimatex/switch_screen/switch_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

 SharedPreferences sharedPref;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale> [
        Locale('en'),
        Locale('ar'),// Arabic,
      ],
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      initialRoute: "companies",
      routes: {
        "companies" : (context) =>  const Companies(),
        "login_screen" : (context) =>  const LoginScreen(),
        "switch_screen" : (context) =>  const SwitchScreen(),
        "change_password" : (context) =>  const ChangePassword(),
      },
    );
  }
}

