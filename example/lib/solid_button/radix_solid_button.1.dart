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
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    return SizedBox(
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          RadixSolidButton(
            text: 'Solid',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixSolidButton.styleFrom(
              borderRadius: radixRadiusFactor.none.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixSolidButton(
            text: 'Solid',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixSolidButton.styleFrom(
              borderRadius: radixRadiusFactor.large.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixSolidButton(
            text: 'Solid',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixSolidButton.styleFrom(
              borderRadius: radixRadiusFactor.full.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
