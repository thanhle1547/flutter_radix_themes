import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixSolidButton].

void main() {
  runApp(const ButtonApp());
}

class ButtonApp extends StatelessWidget {
  const ButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [
          RadixTheme.kExtensionFallbackLight,
        ],
      ),
      title: 'Radix Solid Button',
      home: const Scaffold(body: RadixSolidButtonExample()),
    );
  }
}

class RadixSolidButtonExample extends StatelessWidget {
  const RadixSolidButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        RadixSolidButton(
          text: 'Solid',
          mainAxisSize: MainAxisSize.min,
          styleModifier: RadixSolidButton.styleFrom(
            graySwatch: radixColorScheme.gray,
            accentColorSwatch: RadixColors.crimson.light,
          ),
        ),
        RadixSolidButton(
          text: 'Solid',
          mainAxisSize: MainAxisSize.max,
          styleModifier: RadixSolidButton.styleFrom(
            graySwatch: radixColorScheme.gray,
            accentColorSwatch: RadixColors.crimson.light,
          ),
        ),
      ],
    );
  }
}
