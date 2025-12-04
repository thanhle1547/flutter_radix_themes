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
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    return SizedBox(
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          RadixOutlineButton(
            text: 'Outline',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixOutlineButton.styleFrom(
              borderRadius: radixRadiusFactor.none.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixOutlineButton(
            text: 'Outline',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixOutlineButton.styleFrom(
              borderRadius: radixRadiusFactor.large.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixOutlineButton(
            text: 'Outline',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixOutlineButton.styleFrom(
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
