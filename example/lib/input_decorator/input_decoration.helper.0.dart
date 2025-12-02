import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixInputDecoration.helper].

void main() => runApp(const HelperExampleApp());

class HelperExampleApp extends StatelessWidget {
  const HelperExampleApp({super.key});

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
          appBar: AppBar(title: const Text('RadixInputDecoration.helper Sample')),
          body: const HelperExample(),
        ),
      ),
    );
  }
}

class HelperExample extends StatelessWidget {
  const HelperExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RadixTextField(
        decoration: RadixInputDecoration(
          helper: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                WidgetSpan(child: Text('Helper Text ')),
                WidgetSpan(child: Icon(Icons.help_outline, color: Colors.blue, size: 20.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}