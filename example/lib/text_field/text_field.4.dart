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
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);
    final RadixInputDecorationVariantTheme inputDecorationVariantTheme = RadixInputDecorationVariantTheme.of(context)!;

    return RadixTextField(
      decoration: RadixInputDecoration.from(
        variant: RadixInputDecorationSurfaceVariant.from(
          accentColorSwatch: RadixColors.green.light,
          graySwatch: radixColorScheme.gray,
          surfaceColor: radixColorScheme.surfaceColor,
        ),
        size: inputDecorationVariantTheme.sizeSwatch.s2,
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
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);
    final RadixInputDecorationVariantTheme inputDecorationVariantTheme = RadixInputDecorationVariantTheme.of(context)!;

    return RadixTextField(
      decoration: RadixInputDecoration.from(
        variant: RadixInputDecorationSoftVariant.from(
          accentColorSwatch: RadixColors.green.light,
          graySwatch: radixColorScheme.gray,
        ),
        size: inputDecorationVariantTheme.sizeSwatch.s2,
        hintText: 'hint text',
        helperText: 'supporting text',
      ),
    );
  }
}
