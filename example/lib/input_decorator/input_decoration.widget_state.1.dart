import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [InputDecoration].

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
    return RadixInputDecorationTheme(
      data: RadixTheme.of(context).inputDecorationTheme.copyWith(
        prefixIconColor: const WidgetStateColor.fromMap(<WidgetStatesConstraint, Color>{
          WidgetState.error: Colors.red,
          WidgetState.focused: Colors.blue,
          WidgetState.any: Colors.grey,
        }),
      ),
      child: RadixTextFormField(
        initialValue: 'example.com',
        decoration: const RadixInputDecoration(prefixIcon: Icon(Icons.web)),
        autovalidateMode: AutovalidateMode.always,
        validator: (String? text) {
          if (text?.endsWith('.com') ?? false) {
            return null;
          }
          return 'No .com tld';
        },
      ),
    );
  }
}