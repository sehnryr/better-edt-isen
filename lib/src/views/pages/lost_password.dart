import 'package:edt_isen/src/common/login.dart';
import 'package:edt_isen/src/views/components/common/footer.dart';
import 'package:edt_isen/src/views/components/lost_password/buttons.dart';
import 'package:edt_isen/src/views/components/lost_password/components/lost_password_appbar.dart';
import 'package:edt_isen/src/views/components/lost_password/inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LostPasswordScreen extends StatefulWidget {
  final TextEditingController? usernameController;

  const LostPasswordScreen({Key? key, this.usernameController})
      : super(key: key);

  @override
  _LostPasswordScreenState createState() => _LostPasswordScreenState();
}

class _LostPasswordScreenState extends State<LostPasswordScreen> {
  late TextEditingController usernameController;
  late TextEditingController codeController;
  bool usernameError = false;
  bool codeError = false;

  @override
  void initState() {
    usernameController = widget.usernameController ?? TextEditingController();
    codeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Scaffold(
        appBar: LostPasswordAppbar(),
        body: Container(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Mot de passe oublié ?",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              const Text(
                "Indiquez votre identifiant et code¹ et recevez un lien par mail pour réinitialiser votre mot de passe.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              UsernameInput(
                controller: usernameController,
                error: usernameError,
                onChanged: (String string) => setState(() => usernameError =
                    string.isEmpty || !RegExp(r'^[a-z0-9]+$').hasMatch(string)),
              ),
              CodeInput(
                controller: codeController,
                error: codeError,
                onChanged: (String string) => setState(() => codeError =
                    string.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(string)),
              ),
              SendLinkButton(onPressed: () {
                if (usernameController.text.isEmpty) {
                  setState(() => usernameError = true);
                }
                if (codeController.text.isEmpty) {
                  setState(() => codeError = true);
                }
              }),
            ],
          ),
        ),
        bottomNavigationBar: const Footer(
          "¹: Ce code est inscrit sur votre carte d'étudiant à coté de N° Etudiant, première ligne à gauche sous le code-barres, ou bien sur votre passeport infomatique. ",
        ),
      ),
    );
  }
}
