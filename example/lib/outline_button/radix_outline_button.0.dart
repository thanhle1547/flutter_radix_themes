import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixOutlineButton].

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
      title: 'Radix Outline Button',
      home: const Scaffold(
        backgroundColor: RadixColors.white,
        body: RadixOutlineButtonExample(),
      ),
    );
  }
}

class RadixOutlineButtonExample extends StatelessWidget {
  const RadixOutlineButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        RadixOutlineButton(
          text: 'Outline',
          mainAxisSize: MainAxisSize.min,
          styleModifier: RadixOutlineButton.styleFrom(
            graySwatch: radixColorScheme.gray,
            accentColorSwatch: RadixColors.crimson.light,
          ),
        ),
        RadixOutlineButton(
          text: 'Outline',
          mainAxisSize: MainAxisSize.max,
          styleModifier: RadixOutlineButton.styleFrom(
            graySwatch: radixColorScheme.gray,
            accentColorSwatch: RadixColors.crimson.light,
          ),
        ),
      ],
    );
  }
}
