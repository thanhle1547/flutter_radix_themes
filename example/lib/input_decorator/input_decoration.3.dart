import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixInputDecoration].

void main() => runApp(const RadixInputDecorationExampleApp());

class RadixInputDecorationExampleApp extends StatelessWidget {
  const RadixInputDecorationExampleApp({super.key});

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
          body: const InputDecorationExample(),
        ),
      ),
    );
  }
}

class InputDecorationExample extends StatelessWidget {
  const InputDecorationExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixInputDecorationVariantTheme inputDecorationVariantTheme = RadixInputDecorationVariantTheme.of(context)!;

    return RadixTextFormField(
      initialValue: 'abc',
      decoration: RadixInputDecoration.from(
        variant: inputDecorationVariantTheme.surface,
        size: inputDecorationVariantTheme.sizeSwatch.s2,
        prefixText: 'Prefix',
        suffixText: 'Suffix',
        affixColor: RadixColors.green.light.scale_8,
        enabledBorder: OutlineInputBorder(),
      ),
    );
  }
}