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
        backgroundColor: RadixColors.white,
        body: const BadgeExample(),
      ),
    );
  }
}

class BadgeExample extends StatelessWidget {
  const BadgeExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[
          BadgeTypesGroup(
            size: RadixBadgeSize.$1,
            radixRadius: radixRadiusFactor.none,
          ),
          BadgeTypesGroup(
            size: RadixBadgeSize.$1,
            radixRadius: radixRadiusFactor.large,
          ),
          BadgeTypesGroup(
            size: RadixBadgeSize.$1,
            radixRadius: radixRadiusFactor.full,
          ),

          BadgeTypesGroup(
            size: RadixBadgeSize.$2,
            radixRadius: radixRadiusFactor.none,
          ),
          BadgeTypesGroup(
            size: RadixBadgeSize.$2,
            radixRadius: radixRadiusFactor.large,
          ),
          BadgeTypesGroup(
            size: RadixBadgeSize.$2,
            radixRadius: radixRadiusFactor.full,
          ),

          BadgeTypesGroup(
            size: RadixBadgeSize.$3,
            radixRadius: radixRadiusFactor.none,
          ),
          BadgeTypesGroup(
            size: RadixBadgeSize.$3,
            radixRadius: radixRadiusFactor.large,
          ),
          BadgeTypesGroup(
            size: RadixBadgeSize.$3,
            radixRadius: radixRadiusFactor.full,
          ),
        ],
      ),
    );
  }
}

class BadgeTypesGroup extends StatelessWidget {
  const BadgeTypesGroup({super.key, required this.size, required this.radixRadius});

  final RadixBadgeSize size;
  final RadixRadius radixRadius;

  @override
  Widget build(BuildContext context) {
    final RadixBadgeStyleModifier styleModifier = RadixBadgeStyleModifier(
      borderRadius: radixRadius.resolveForBadge(badgeSize: size),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: <Widget>[
        RadixBadge(
          text: 'New',
          variant: RadixBadgeVariant.solid,
          size: size,
          styleModifier: styleModifier,
        ),
        RadixBadge(
          text: 'New',
          variant: RadixBadgeVariant.soft,
          size: size,
          styleModifier: styleModifier,
        ),
        RadixBadge(
          text: 'New',
          variant: RadixBadgeVariant.surface,
          size: size,
          styleModifier: styleModifier,
        ),
        RadixBadge(
          text: 'New',
          variant: RadixBadgeVariant.outline,
          size: size,
          styleModifier: styleModifier,
        ),
      ],
    );
  }
}