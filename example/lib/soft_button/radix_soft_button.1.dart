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
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    return SizedBox(
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          RadixSoftButton(
            text: 'Soft',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixSoftButton.styleFrom(
              borderRadius: radixRadiusFactor.none.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixSoftButton(
            text: 'Soft',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixSoftButton.styleFrom(
              borderRadius: radixRadiusFactor.large.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixSoftButton(
            text: 'Soft',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixSoftButton.styleFrom(
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
