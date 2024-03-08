import 'package:flutter/material.dart';

class FormInput<T> extends StatelessWidget {
  final String label;
  final String validationMessage;
  final T initialValue;
  final TextInputType inputType;
  final void Function(String?)? onSaved;
  final bool Function(String?)? validate;

  const FormInput ({
    super.key,
    required this.label,
    required this.inputType,
    required this.initialValue,
    required this.validationMessage,
    required this.onSaved,
    this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        keyboardType: inputType,
        initialValue: initialValue.toString(),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        validator: (value) {
          if (validate != null && !validate!(value)) {
            return validationMessage;
          } 
          if (validate == null && (value == null || value.isEmpty)) {
            return validationMessage;
          }
          return null;
        },
        onSaved: onSaved,
      )
    );
  }
}