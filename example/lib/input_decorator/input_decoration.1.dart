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
    return const RadixTextField(
      decoration: RadixInputDecoration(
        hintText: 'Hint Text',
        errorText: 'Error Text',
        enabledBorder: OutlineInputBorder(
          gapPadding: 0.0,
        ),
      ),
    );
  }
}