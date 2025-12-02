import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixButton].

void main() => runApp(const RadixSpinnerApp());

class RadixSpinnerApp extends StatelessWidget {
  const RadixSpinnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [
          RadixTheme.kExtensionFallbackLight,
        ],
      ),
      home: RadixSpinnerExample(),
    );
  }
}

class RadixSpinnerExample extends StatelessWidget {
  const RadixSpinnerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: RadixColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              RadixSolidButton(
                text: 'Edit profile',
              ),
              RadixSoftButton(
                text: 'Edit profile',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              RadixSurfaceButton(
                text: 'Edit profile',
              ),
              RadixOutlineButton(
                text: 'Edit profile',
              ),
            ],
          ),
          RadixGhostButton(
            text: 'Edit profile',
          ),
        ],
      ),
    );
  }
}
