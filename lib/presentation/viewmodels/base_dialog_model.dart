import 'package:flutter/material.dart';

class BaseDialogModel {
  final double opacity;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final double iconSize;
  final double titleFontSize;
  final double messageFontSize;
  final double buttonFontSize;

  const BaseDialogModel({
    this.opacity = 0.95,
    this.borderRadius = 20,
    this.contentPadding = const EdgeInsets.all(24),
    this.iconSize = 80,
    this.titleFontSize = 24,
    this.messageFontSize = 18,
    this.buttonFontSize = 16,
  });
}
