import 'package:edt_isen/src/views/components/common/base_button.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final void Function() onPressed;

  const LoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      text: "CONNEXION",
      onPressed: onPressed,
    );
  }
}
