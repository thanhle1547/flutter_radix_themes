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
      home: const Scaffold(
        backgroundColor: RadixColors.white,
        body: RadixSurfaceButtonExample(),
      ),
    );
  }
}

class RadixSurfaceButtonExample extends StatelessWidget {
  const RadixSurfaceButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    return SizedBox(
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          RadixSurfaceButton(
            text: 'Surface',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixSurfaceButton.styleFrom(
              borderRadius: radixRadiusFactor.none.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixSurfaceButton(
            text: 'Surface',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixSurfaceButton.styleFrom(
              borderRadius: radixRadiusFactor.large.resolveForButton(
                buttonSize: RadixButtonSize.$2,
              ),
            ),
          ),
          RadixSurfaceButton(
            text: 'Surface',
            size: RadixButtonSize.$2,
            mainAxisSize: MainAxisSize.min,
            styleModifier: RadixSurfaceButton.styleFrom(
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
