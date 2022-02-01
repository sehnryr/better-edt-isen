import 'package:flutter/material.dart';
import 'package:edt_isen/src/views/components/login/base_input.dart';

class UsernameInput extends StatelessWidget {
  final TextEditingController controller;

  const UsernameInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      controller: controller,
      autofillHints: const [AutofillHints.username],
      labelText: "Identifiant",
      errorText: "Veuillez indiquer un identifiant valide",
      prefixIcon: const Icon(Icons.person),
    );
  }
}

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      controller: controller,
      autofillHints: const [AutofillHints.password],
      labelText: "Mot de passe",
      errorText: "Veuillez indiquer un mot de passe valide",
      prefixIcon: const Icon(Icons.lock_open),
      isPassword: true,
      error: false,
    );
  }
}
