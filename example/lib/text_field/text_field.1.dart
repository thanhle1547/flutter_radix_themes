import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixTextField].

void main() => runApp(const TextFieldExampleApp());

class TextFieldExampleApp extends StatelessWidget {
  const TextFieldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [
          RadixTheme.kExtensionFallbackLight,
        ],
      ),
      home: RadixTextFieldExample(),
    );
  }
}

class RadixTextFieldExample extends StatefulWidget {
  const RadixTextFieldExample({super.key});

  @override
  State<RadixTextFieldExample> createState() => _RadixTextFieldExampleState();
}

class _RadixTextFieldExampleState extends State<RadixTextFieldExample> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: RadixTextField(
              controller: _controller,
              onSubmitted: (String value) async {
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thanks!'),
                      content: Text('You typed "$value", which has length ${value.characters.length}.'),
                      actions: <Widget>[
                        RadixSoftButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          text: 'OK',
                          styleModifier: RadixSoftButton.styleFrom(
                            graySwatch: radixColorScheme.gray,
                            accentColorSwatch: radixColorScheme.gray,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}