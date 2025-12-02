import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixGhostButton].

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
      title: 'Radix Ghost Button',
      home: const Scaffold(body: RadixGhostButtonExample()),
    );
  }
}

class RadixGhostButtonExample extends StatelessWidget {
  const RadixGhostButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        RadixGhostButton(
          text: 'Ghost',
          mainAxisSize: MainAxisSize.min,
          styleModifier: RadixGhostButton.styleFrom(
            graySwatch: radixColorScheme.gray,
            accentColorSwatch: RadixColors.crimson.light,
          ),
        ),
        RadixGhostButton(
          text: 'Ghost',
          mainAxisSize: MainAxisSize.max,
          styleModifier: RadixGhostButton.styleFrom(
            graySwatch: radixColorScheme.gray,
            accentColorSwatch: RadixColors.crimson.light,
          ),
        ),
      ],
    );
  }
}
