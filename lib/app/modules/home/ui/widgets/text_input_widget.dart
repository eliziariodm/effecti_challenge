import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final String label;
  final bool disabled;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  const TextInputWidget({
    super.key,
    required this.label,
    this.disabled = false,
    this.controller,
    this.onChanged,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return TextFormField(
      readOnly: disabled,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        labelStyle: theme.textTheme.labelMedium,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
      ),
    );
  }
}
