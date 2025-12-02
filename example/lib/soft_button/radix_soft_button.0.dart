import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixSoftButton].

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
      title: 'Radix Soft Button',
      home: const Scaffold(body: RadixSoftButtonExample()),
    );
  }
}

class RadixSoftButtonExample extends StatelessWidget {
  const RadixSoftButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        RadixSoftButton(
          text: 'Soft',
          mainAxisSize: MainAxisSize.min,
          styleModifier: RadixSoftButton.styleFrom(
            graySwatch: radixColorScheme.gray,
            accentColorSwatch: RadixColors.crimson.light,
          ),
        ),
        RadixSoftButton(
          text: 'Soft',
          mainAxisSize: MainAxisSize.max,
          styleModifier: RadixSoftButton.styleFrom(
            graySwatch: radixColorScheme.gray,
            accentColorSwatch: RadixColors.crimson.light,
          ),
        ),
      ],
    );
  }
}
