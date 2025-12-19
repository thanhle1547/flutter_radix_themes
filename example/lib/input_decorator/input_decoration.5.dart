import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixInputDecoration].

void main() => runApp(const InputDecorationExampleApp());

class InputDecorationExampleApp extends StatelessWidget {
  const InputDecorationExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [
          RadixTheme.kExtensionFallbackLight,
        ],
      ),
      home: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('RadixInputDecoration Sample')),
          body: const RadixInputDecorationExample(),
        ),
      ),
    );
  }
}

class RadixInputDecorationExample extends StatelessWidget {
  const RadixInputDecorationExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    return RadixTextField(
      decoration: RadixInputDecoration.from(
        variant: RadixInputDecorationVariantTheme.kLight.surface,
        size: RadixInputDecorationVariantTheme.kLight.sizeSwatch.s2,
        icon: Icon(Icons.send),
        hintText: 'Hint Text',
        helperText: 'Helper Text',
        counterText: '0 characters',
        borderRadius: radixRadiusFactor.full.resolveForInput(
          inputSize: RadixInputSize.$2,
        ),
      ),
    );
  }
}