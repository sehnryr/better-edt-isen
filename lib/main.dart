import 'package:flutter/material.dart';
import 'package:edt_isen/src/views/pages/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode _currentFocus = FocusScope.of(context);
        if (!_currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF6D6875),
            primaryVariant: const Color(0xFF4D4955),
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Color(0xFF6D6875),
              letterSpacing: -1.5,
              fontSize: 34,
              fontWeight: FontWeight.w500,
            ),
            button: TextStyle(
              color: Colors.white,
              letterSpacing: 1.25,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            overline: TextStyle(
              letterSpacing: 1.5,
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
