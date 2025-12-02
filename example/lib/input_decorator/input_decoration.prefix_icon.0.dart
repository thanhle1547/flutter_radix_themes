import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixInputDecorator].

void main() => runApp(const PrefixIconExampleApp());

class PrefixIconExampleApp extends StatelessWidget {
  const PrefixIconExampleApp({super.key});

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
          body: RadixInputDecoratorExample(),
        ),
      ),
    );
  }
}

class RadixInputDecoratorExample extends StatelessWidget {
  const RadixInputDecoratorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const RadixTextField(
      decoration: RadixInputDecoration(
        enabledBorder: InputBorder.none,
        hintText: 'Enter name',
        prefixIconConstraints: BoxConstraints.tightFor(width: 80),
        prefixIcon: Align(
          alignment: Alignment.centerRight,
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(Icons.person),
        ),
      ),
    );
  }
}