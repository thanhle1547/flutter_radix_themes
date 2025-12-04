import 'package:flutter/material.dart';
import 'package:radix_themes/radix_themes.dart';

/// Flutter code sample for [RadixSkeleton].

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
      title: 'Radix Skeleton',
      home: const Scaffold(body: RadixSkeletonExample()),
    );
  }
}

class RadixSkeletonExample extends StatelessWidget {
  const RadixSkeletonExample({super.key});

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);
    final RadixRadiusFactor radixRadiusFactor = RadixRadiusFactor.fromTheme(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        RadixSkeleton(),
        RadixSkeleton(
          width: 100,
          height: 18,
        ),
        RadixSkeleton(
          width: 48,
          height: 48,
          borderRadius: BorderRadius.all(
            radixRadiusFactor.large.swatch.scale_3,
          ),
        ),
        RadixSkeleton(
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
              color: radixColorScheme.gray.radixScale_3.alphaVariant,
            ),
            RadixFigmaSkeleton(
              width: 100,
              height: 48,
              borderRadius: BorderRadius.zero,
            ),
            Container(
              width: 48,
              height: 48,
              color: radixColorScheme.gray.radixScale_4.alphaVariant,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 100 - 2,
          children: [
            Text('--gray-a3'),
            Text('--gray-a4'),
          ],
        ),
      ],
    );
  }
}
