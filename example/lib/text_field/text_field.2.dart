import 'package:flutter/material.dart';

import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixTextField]s.

void main() {
  runApp(const RadixTextFieldExamplesApp());
}

class RadixTextFieldExamplesApp extends StatelessWidget {
  const RadixTextFieldExamplesApp({super.key});

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
          appBar: AppBar(title: const Text('RadixTextField Examples')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20.0,
              children: <Widget>[
                SurfaceTextFieldExample(),
                SoftTextFieldExample(),
                FilledTextFieldExample(),
                OutlinedTextFieldExample(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// An example of the surface text field type.
///
/// A surface [RadixTextField] with default settings matching the spec:
/// https://www.radix-ui.com/themes/docs/components/text-field
class SurfaceTextFieldExample extends StatelessWidget {
  const SurfaceTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixInputDecorationVariantTheme inputDecorationVariantTheme = RadixInputDecorationVariantTheme.of(context)!;

    return RadixTextField(
      decoration: RadixInputDecoration.from(
        variant: inputDecorationVariantTheme.surface,
        size: inputDecorationVariantTheme.sizeSwatch.s2,
        prefixIcon: Icon(Icons.search, size: 16),
        suffixIcon: Icon(Icons.clear, size: 16),
        hintText: 'hint text',
        helperText: 'supporting text',
      ),
    );
  }
}

/// An example of the soft text field type.
///
/// A soft [RadixTextField] with default settings matching the spec:
/// https://www.radix-ui.com/themes/docs/components/text-field
class SoftTextFieldExample extends StatelessWidget {
  const SoftTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixInputDecorationVariantTheme inputDecorationVariantTheme = RadixInputDecorationVariantTheme.of(context)!;

    return RadixTextField(
      decoration: RadixInputDecoration.from(
        variant: inputDecorationVariantTheme.soft,
        size: inputDecorationVariantTheme.sizeSwatch.s2,
        prefixIcon: Icon(Icons.search, size: 16),
        suffixIcon: Icon(Icons.clear, size: 16),
        hintText: 'hint text',
        helperText: 'supporting text',
      ),
    );
  }
}

/// An example of the filled text field type.
///
/// A filled [TextField] with default settings matching the spec:
/// https://m3.material.io/components/text-fields/specs#6d654d1d-262e-4697-858c-9a75e8e7c81d
class FilledTextFieldExample extends StatelessWidget {
  const FilledTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      // expands: true,
      // maxLines: null,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        suffixIcon: Icon(Icons.clear),
        hintText: 'hint text',
        helperText: 'supporting text',
        filled: true,
        enabledBorder: InputBorder.none,
        // contentPadding: EdgeInsets.zero,
        // isDense: true,
        // isCollapsed: true,
      ),
    );
  }
}

/// An example of the outlined text field type.
///
/// A Outlined [TextField] with default settings matching the spec:
/// https://m3.material.io/components/text-fields/specs#68b00bd6-ab40-4b4f-93d9-ed1fbbc5d06e
class OutlinedTextFieldExample extends StatelessWidget {
  const OutlinedTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        suffixIcon: Icon(Icons.clear),
        hintText: 'hint text',
        helperText: 'supporting text',
        border: OutlineInputBorder(),
      ),
    );
  }
}