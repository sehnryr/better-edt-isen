import 'package:edt_isen/src/views/components/login/button.dart';
import 'package:edt_isen/src/views/components/login/footer.dart';
import 'package:edt_isen/src/views/components/login/icon.dart';
import 'package:edt_isen/src/views/components/login/inputs.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const AppIcon(),
                const SizedBox(height: 50),
                UsernameInput(controller: usernameController),
                PasswordInput(controller: passwordController),
                LoginButton(onPressed: () => print(usernameController.text))
              ],
            ),
          ),
        ),
        bottomNavigationBar: const Footer(
            "Cette application est à l'usage exclusif des étudiants de l'ISEN."),
        extendBody: true,
      ),
    );
  }
}
