import 'package:flutter/material.dart';

class LostPasswordButton extends StatelessWidget {
  final void Function() onPressed;

  const LostPasswordButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text("Mot de passe oublié ?"),
    );
  }
}
