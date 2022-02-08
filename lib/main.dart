import 'dart:convert';
import 'package:edt_isen/src/common/create_route.dart';
import 'package:edt_isen/src/common/progress_hud_wrapper.dart';
import 'package:edt_isen/src/utils/secure_storage.dart';
import 'package:edt_isen/src/views/pages/schedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:edt_isen/src/views/pages/login.dart';

void main() => initializeDateFormatting().then((_) => runApp(const MyApp()));

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
            primaryContainer: const Color(0xFF4D4955),
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
        home: Builder(builder: (context) {
          return const ProgressHUDWrapper(child: PageSelection());
        }),
      ),
    );
  }
}

class PageSelection extends StatefulWidget {
  const PageSelection({Key? key}) : super(key: key);

  @override
  _PageSelectionState createState() => _PageSelectionState();
}

class _PageSelectionState extends State<PageSelection> {
  @override
  void initState() {
    SecureStorage.getSchedule().then((String? value) {
      if (value != null) {
        Navigator.of(context).pushReplacement(createRoute(
          ScheduleScreen(schedule: json.decode(value)),
          Direction.fromRight,
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
