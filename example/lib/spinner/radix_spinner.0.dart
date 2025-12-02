import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixSpinner].

void main() => runApp(const RadixSpinnerApp());

class RadixSpinnerApp extends StatelessWidget {
  const RadixSpinnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [
          RadixTheme.kExtensionFallbackLight,
        ],
      ),
      home: RadixSpinnerExample(),
    );
  }
}

class RadixSpinnerExample extends StatelessWidget {
  const RadixSpinnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: RadixColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          RadixSpinner(),
          RadixFigmaSpinner(),
        ],
      ),
    );
  }
}
