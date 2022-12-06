import 'package:flutter/material.dart';

typedef PasswordControlValidator = String? Function(String? value);

class PasswordControl extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String labelText;
  final PasswordControlValidator? validator;

  const PasswordControl(
      {Key? key,
      this.controller,
      this.textInputAction,
      required this.labelText,
      this.validator})
      : super(key: key);

  @override
  State<PasswordControl> createState() => _PasswordControlState();
}

class _PasswordControlState extends State<PasswordControl> {
  final GlobalKey<FormFieldState> _passwordFormFieldKey =
      GlobalKey<FormFieldState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _passwordFormFieldKey,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorMaxLines: 2,
        suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: _toggle),
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      validator: widget.validator,
      onChanged: (text) {
        _passwordFormFieldKey.currentState!.validate();
      },
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
