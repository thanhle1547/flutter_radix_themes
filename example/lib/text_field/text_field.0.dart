import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixTextField].

class ObscuredTextFieldSample extends StatelessWidget {
  const ObscuredTextFieldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: RadixTextField(
        obscureText: true,
        decoration: RadixInputDecoration(
          enabledBorder: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class RadixTextFieldExampleApp extends StatelessWidget {
  const RadixTextFieldExampleApp({super.key});
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
          appBar: AppBar(title: const Text('Obscured RadixTextfield')),
          body: const Center(child: ObscuredTextFieldSample()),
        ),
      ),
    );
  }
}

void main() => runApp(const RadixTextFieldExampleApp());