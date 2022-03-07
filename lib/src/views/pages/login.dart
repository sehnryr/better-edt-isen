import 'dart:async';
import 'dart:convert';

import 'package:edt_isen/src/api/aurion.dart';
import 'package:edt_isen/src/common/create_route.dart';
import 'package:edt_isen/src/common/progress_hud_wrapper.dart';
import 'package:edt_isen/src/views/components/common/footer.dart';
import 'package:edt_isen/src/views/components/login/icon.dart';
import 'package:edt_isen/src/views/components/login/inputs.dart';
import 'package:edt_isen/src/views/components/login/buttons.dart';
import 'package:edt_isen/src/utils/secure_storage.dart';
import 'package:edt_isen/src/common/login.dart';
import 'package:edt_isen/src/views/pages/lost_password.dart';
import 'package:edt_isen/src/views/pages/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool usernameError = false;
  bool passwordError = false;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _usernameValidation(String username) {
    return username.isNotEmpty || RegExp(r'[a-z0-9]{6:}$').hasMatch(username);
  }

  bool _passwordValidation(String password) {
    return password.isNotEmpty || RegExp(r'^[ ]{6:}$').hasMatch(password);
    // TODO: get the correct regex string for the password
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: padding,
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const AppIcon(),
              const SizedBox(height: 50),
              UsernameInput(
                controller: usernameController,
                error: usernameError,
                onChanged: (String username) => setState(
                    () => usernameError = !_usernameValidation(username)),
              ),
              PasswordInput(
                controller: passwordController,
                error: passwordError,
                onChanged: (String password) => setState(
                    () => passwordError = !_passwordValidation(password)),
              ),
              LoginButton(onPressed: () async {
                final username = usernameController.text;
                final password = passwordController.text;

                usernameError = !_usernameValidation(username);
                passwordError = !_passwordValidation(password);

                if (usernameError || passwordError) {
                  if (usernameError) {
                    setState(() => usernameError = usernameError);
                  }
                  if (passwordError) {
                    setState(() => passwordError = passwordError);
                  }
                } else {
                  final progress = ProgressHUD.of(context);
                  progress?.show();
                  try {
                    final bool loginState =
                        await Aurion.login(username, password);
                    if (!loginState) {
                      const snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text("Échec de l'authentification"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      await Aurion.fetchSchedule();
                      final String? schedule =
                          await SecureStorage.getSchedule();
                      Navigator.of(context).pushReplacement(createRoute(
                        ScheduleScreen(
                            schedule: schedule != null
                                ? json.decode(schedule)
                                : null),
                        Direction.fromRight,
                      ));
                    }
                  } on TimeoutException {
                    const snackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("Temps d'attente dépassé"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  progress?.dismiss();
                }
              }),
              LostPasswordButton(onPressed: () {
                setState(() {
                  if (usernameError) {
                    usernameError = usernameController.text.isNotEmpty;
                  }
                  if (passwordError) {
                    passwordError = passwordController.text.isNotEmpty;
                  }
                });
                Navigator.of(context).push(createRoute(
                    LostPasswordScreen(
                      usernameController: usernameController,
                    ),
                    Direction.fromBottom));
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(
        "Cette application est à l'usage exclusif des étudiants de l'EPSI.",
      ),
      extendBody: true,
    );
  }
}
