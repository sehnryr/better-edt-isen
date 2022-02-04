import 'package:edt_isen/src/common/create_route.dart';
import 'package:edt_isen/src/views/components/common/footer.dart';
import 'package:edt_isen/src/views/components/login/icon.dart';
import 'package:edt_isen/src/views/components/login/inputs.dart';
import 'package:edt_isen/src/views/components/login/buttons.dart';
import 'package:edt_isen/src/common/login.dart';
import 'package:edt_isen/src/views/pages/lost_password.dart';
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
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Scaffold(
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
                  onChanged: (String string) => setState(() => usernameError =
                      string.isEmpty ||
                          !RegExp(r'^[a-z0-9]+$').hasMatch(string)),
                ),
                PasswordInput(
                  controller: passwordController,
                  error: passwordError,
                  onChanged: (String string) => setState(() => passwordError =
                      string.isEmpty ||
                          string.contains(
                              " ")), // TODO: get the correct regex string for the password
                ),
                LoginButton(
                    onPressed: () => {
                          if (usernameController.text.isEmpty)
                            setState(() => usernameError = true),
                          if (passwordController.text.isEmpty)
                            setState(() => passwordError = true),
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
          "Cette application est à l'usage exclusif des étudiants de l'ISEN.",
        ),
        extendBody: true,
      ),
    );
  }
}
