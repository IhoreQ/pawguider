import 'package:flutter/services.dart';

class FormItem {
  FormItem({
    this.labelText = '',
    this.errorMessage,
    this.formatters = const [],
    this.keyboardType
  });

  final String labelText;
  final String? errorMessage;
  final List<TextInputFormatter> formatters;
  final TextInputType? keyboardType;
}