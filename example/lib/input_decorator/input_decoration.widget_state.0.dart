import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixInputDecoration].

void main() => runApp(const WidgetStateExampleApp());

class WidgetStateExampleApp extends StatelessWidget {
  const WidgetStateExampleApp({super.key});

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
          body: const WidgetStateExample(),
        ),
      ),
    );
  }
}

class WidgetStateExample extends StatelessWidget {
  const WidgetStateExample({super.key});

  @override
  Widget build(BuildContext context) {
    return RadixTextFormField(
      initialValue: 'abc',
      decoration: const RadixInputDecoration(
        prefixIcon: Icon(Icons.person),
        prefixIconColor: WidgetStateColor.fromMap(<WidgetStatesConstraint, Color>{
          WidgetState.focused: Colors.green,
          WidgetState.any: Colors.grey,
        }),
      ),
    );
  }
}