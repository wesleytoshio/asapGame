import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomReactiveTextField extends StatelessWidget {
  final String? formControlName;
  final String? labelText;
  final bool obscureText;
  final void Function()? onPressedSuffix;
  final IconData? suffixIcon;
  final TextInputAction? textInputAction;
  const CustomReactiveTextField({
    Key? key,
    this.formControlName,
    this.obscureText = false,
    this.labelText,
    this.onPressedSuffix,
    this.suffixIcon,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      key: key,
      formControlName: formControlName,
      obscureText: obscureText,
      obscuringCharacter: "*",
      textInputAction: textInputAction,
      decoration: InputDecoration(
        floatingLabelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 22,
        ),
        labelText: labelText,
        suffixIcon: IconButton(
          onPressed: onPressedSuffix,
          splashRadius: 25,
          icon: Icon(suffixIcon),
        ),
      ),
    );
  }
}
