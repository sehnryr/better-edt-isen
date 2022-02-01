import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final String text;

  const Footer(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.overline,
          )),
    );
  }
}
