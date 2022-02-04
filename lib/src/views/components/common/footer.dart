import 'package:edt_isen/src/common/login.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final String text;

  const Footer(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: padding,
      child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.overline,
          )),
    );
  }
}
