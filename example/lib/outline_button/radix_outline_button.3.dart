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
      home: const Scaffold(body: RadixOutlineIconButtonExample()),
    );
  }
}

class RadixOutlineIconButtonExample extends StatelessWidget {
  const RadixOutlineIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    return SizedBox(
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          RadixOutlineButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            size: RadixButtonSize.$2,
            styleModifier: RadixOutlineButton.styleFrom(
              borderRadius: radixRadiusFactor.none.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixOutlineButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            size: RadixButtonSize.$2,
            styleModifier: RadixOutlineButton.styleFrom(
              borderRadius: radixRadiusFactor.large.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixOutlineButton.icon(
            icon: Icon(Icons.bookmark_border_outlined),
            size: RadixButtonSize.$2,
            styleModifier: RadixOutlineButton.styleFrom(
              borderRadius: radixRadiusFactor.full.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixOutlineButton.icon(
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
