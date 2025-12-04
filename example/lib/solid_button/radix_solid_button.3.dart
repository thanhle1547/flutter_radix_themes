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
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    return SizedBox(
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          RadixSolidButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            size: RadixButtonSize.$2,
            styleModifier: RadixSolidButton.styleFrom(
              borderRadius: radixRadiusFactor.none.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixSolidButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            size: RadixButtonSize.$2,
            styleModifier: RadixSolidButton.styleFrom(
              borderRadius: radixRadiusFactor.large.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixSolidButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            size: RadixButtonSize.$2,
            styleModifier: RadixSolidButton.styleFrom(
              borderRadius: radixRadiusFactor.full.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixSolidButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            size: RadixButtonSize.$2,
            styleModifier: RadixButtonStyleModifier(
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
