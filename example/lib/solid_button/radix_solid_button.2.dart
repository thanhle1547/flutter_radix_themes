import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixSolidButton.icon].

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
        iconTheme: IconThemeData(
          size: 18,
        ),
      ),
      title: 'Radix Solid Icon Button',
      home: const Scaffold(body: RadixSolidIconButtonExample()),
    );
  }
}

class RadixSolidIconButtonExample extends StatelessWidget {
  const RadixSolidIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);

    return Center(
      child: RadixSolidButton.icon(
        icon: Icon(Icons.bookmark_border_outlined),
        styleModifier: RadixSolidButton.styleFrom(
          graySwatch: radixColorScheme.gray,
          accentColorSwatch: RadixColors.crimson.light,
        ),
      ),
    );
  }
}
