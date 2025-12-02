import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixSurfaceButton.icon].

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
      title: 'Radix Surface Icon Button',
      home: const Scaffold(body: RadixSurfaceIconButtonExample()),
    );
  }
}

class RadixSurfaceIconButtonExample extends StatelessWidget {
  const RadixSurfaceIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);

    return Center(
      child: RadixSurfaceButton.icon(
        icon: Icon(Icons.bookmark_border_outlined),
        styleModifier: RadixSurfaceButton.styleFrom(
          graySwatch: radixColorScheme.gray,
          accentColorSwatch: RadixColors.crimson.light,
        ),
      ),
    );
  }
}
