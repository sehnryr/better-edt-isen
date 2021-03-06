import 'package:flutter/material.dart';
import 'package:edt_isen/src/common/login.dart';

class BaseInput extends StatefulWidget {
  final TextEditingController controller;
  final Iterable<String> autofillHints;
  final void Function(String)? onChanged;
  final String labelText;
  final String errorText;
  final Icon prefixIcon;
  final bool isPassword;
  final bool error;

  const BaseInput({
    Key? key,
    required this.controller,
    required this.autofillHints,
    required this.labelText,
    required this.errorText,
    required this.prefixIcon,
    this.onChanged,
    this.isPassword = false,
    this.error = false,
  }) : super(key: key);

  @override
  _BaseInputState createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  final FocusNode _focusNode = FocusNode();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 90.0,
      child: TextFormField(
        onChanged: widget.onChanged,
        focusNode: _focusNode,
        autofillHints: widget.autofillHints,
        controller: widget.controller,
        obscureText: widget.isPassword ? !_showPassword : false,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          labelText: widget.labelText,
          errorText: widget.error ? widget.errorText : null,
          border: OutlineInputBorder(
            borderRadius: borderRadius,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    if (!_focusNode.hasPrimaryFocus) {
                      _focusNode.unfocus();
                      _focusNode.canRequestFocus = false;
                    }
                    setState(() => _showPassword = !_showPassword);
                  },
                )
              : null,
        ),
      ),
    );
  }
}
