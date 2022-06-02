import 'package:flutter/material.dart';

///  [ '#4ca665','#4ca665' ].toColors;
///  '#4ca665'.toColor;
extension ColorExtensionList on List<String> {
  List<Color> get toColors {
    return map((e) => e.toColor).toList();
  }
}

extension ColorExtension on String {
  Color get toColor {
    return Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);

    /// if you have  need custom opacity or alpha you can use
    /// replaceAll("#", "0XFF" or any value );
  }
}
