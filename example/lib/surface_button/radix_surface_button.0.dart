import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixSurfaceButton].

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
      title: 'Radix Surface Button',
      home: const Scaffold(body: RadixSurfaceButtonExample()),
    );
  }
}

class RadixSurfaceButtonExample extends StatelessWidget {
  const RadixSurfaceButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        RadixSurfaceButton(
          text: 'Surface',
          mainAxisSize: MainAxisSize.min,
          styleModifier: RadixSurfaceButton.styleFrom(
            graySwatch: radixColorScheme.gray,
            accentColorSwatch: RadixColors.crimson.light,
          ),
        ),
        RadixSurfaceButton(
          text: 'Surface',
          mainAxisSize: MainAxisSize.max,
          styleModifier: RadixSurfaceButton.styleFrom(
            graySwatch: radixColorScheme.gray,
            accentColorSwatch: RadixColors.crimson.light,
          ),
        ),
      ],
    );
  }
}
