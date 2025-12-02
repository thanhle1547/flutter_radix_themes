import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixBadge].

void main() => runApp(const BadgeExampleApp());

class BadgeExampleApp extends StatelessWidget {
  const BadgeExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [
          RadixTheme.kExtensionFallbackLight,
        ],
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Badge Sample')),
        body: const BadgeExample(),
      ),
    );
  }
}

class BadgeExample extends StatelessWidget {
  const BadgeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: RadixColors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: <Widget>[
            RadixBadge(
              text: 'New',
              variant: RadixBadgeVariant.solid,
              styleModifier: RadixBadgeStyleModifier.withAccent(
                accent: RadixColors.crimson.light,
                variant: RadixBadgeVariant.solid,
              ),
            ),
            RadixBadge(
              text: 'New',
              variant: RadixBadgeVariant.soft,
              styleModifier: RadixBadgeStyleModifier.withAccent(
                accent: RadixColors.crimson.light,
                variant: RadixBadgeVariant.soft,
              ),
            ),
            RadixBadge(
              text: 'New',
              variant: RadixBadgeVariant.surface,
              styleModifier: RadixBadgeStyleModifier.withAccent(
                accent: RadixColors.crimson.light,
                variant: RadixBadgeVariant.surface,
              ),
            ),
            RadixBadge(
              text: 'New',
              variant: RadixBadgeVariant.outline,
              styleModifier: RadixBadgeStyleModifier.withAccent(
                accent: RadixColors.crimson.light,
                variant: RadixBadgeVariant.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}