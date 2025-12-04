import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixOutlineButton.icon].

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
      title: 'Radix Outline Icon Button',
      home: const Scaffold(
        backgroundColor: RadixColors.white,
        body: RadixOutlineIconButtonExample(),
      ),
    );
  }
}

class RadixOutlineIconButtonExample extends StatelessWidget {
  const RadixOutlineIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);

    return Center(
      child: RadixOutlineButton.icon(
        icon: Icon(Icons.bookmark_border_outlined),
        styleModifier: RadixOutlineButton.styleFrom(
          graySwatch: radixColorScheme.gray,
          accentColorSwatch: RadixColors.crimson.light,
        ),
      ),
    );
  }
}
