import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixFigmaSkeleton].

void main() {
  runApp(const SkeletonApp());
}

class SkeletonApp extends StatelessWidget {
  const SkeletonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [
          RadixTheme.kExtensionFallbackLight,
        ],
      ),
      title: 'Radix Figma Skeleton',
      home: const Scaffold(body: RadixFigmaSkeletonExample()),
    );
  }
}

class RadixFigmaSkeletonExample extends StatelessWidget {
  const RadixFigmaSkeletonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        RadixFigmaSkeleton(),
        RadixFigmaSkeleton(
          width: 100,
          height: 18,
        ),
        RadixFigmaSkeleton(
          width: 48,
          height: 48,
          borderRadius: BorderRadius.all(
            radixRadiusFactor.large.swatch.scale_3,
          ),
        ),
        RadixFigmaSkeleton(
          width: 100,
          height: 100,
          shape: BoxShape.circle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            Container(
              width: 48,
              height: 48,
              color: radixColorScheme.neutral.radixScale_3.alphaVariant,
            ),
            RadixFigmaSkeleton(
              width: 100,
              height: 48,
              borderRadius: BorderRadius.zero,
            ),
            Container(
              width: 48,
              height: 48,
              color: radixColorScheme.neutral.radixScale_4.alphaVariant,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 100 - 18,
          children: [
            Text('--neutral-a3'),
            Text('--neutral-a4'),
          ],
        ),
      ],
    );
  }
}
