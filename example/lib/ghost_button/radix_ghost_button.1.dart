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
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    return SizedBox(
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          RadixGhostButton(
            text: 'Ghost',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixGhostButton.styleFrom(
              borderRadius: radixRadiusFactor.none.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixGhostButton(
            text: 'Ghost',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixGhostButton.styleFrom(
              borderRadius: radixRadiusFactor.large.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixGhostButton(
            text: 'Ghost',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixGhostButton.styleFrom(
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
