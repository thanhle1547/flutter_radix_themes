
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'theme.dart';
import 'theme_data.dart';

/// Defines a swatch of shadow based on Radix UI's 6-step scale.
///
/// Radix uses inner shadow for token 1,
/// but Flutter doesn't support inner shadow, so `scale_1` isn't defined.
///
/// To obtain the shadow, call [RadixShadowSwatch.of] with the current
/// [BuildContext]. This is equivalent to calling [RadixTheme.of] and reading
/// the [RadixThemeData.shadows] property.
///
/// See also:
///
///  * <https://www.radix-ui.com/themes/docs/theme/spacing>
///  * <https://github.com/flutter/flutter/issues/18636>
@immutable
final class RadixShadowSwatch {
  const RadixShadowSwatch({
    required this.scale_2,
    required this.scale_3,
    required this.scale_4,
    required this.scale_5,
    required this.scale_6,
  });

  final List<BoxShadow> scale_2;
  final List<BoxShadow> scale_3;
  final List<BoxShadow> scale_4;
  final List<BoxShadow> scale_5;
  final List<BoxShadow> scale_6;

  static final RadixShadowSwatch kWebCss = RadixShadowSwatch(
    scale_2: [
      BoxShadow(
        offset: Offset.zero,
        blurRadius: 0,
        spreadRadius: 1,
        color: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
      ),
      BoxShadow(
        offset: Offset.zero,
        blurRadius: 0,
        spreadRadius: 0.5,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 1,
        spreadRadius: 0,
        color: RadixColorScheme.kLight.gray.radixScale_2.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 2),
        blurRadius: 1,
        spreadRadius: -1,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 3,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
    ],
    scale_3: [
      BoxShadow(
        offset: Offset.zero,
        blurRadius: 0,
        spreadRadius: 1,
        color: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 2),
        blurRadius: 3,
        spreadRadius: -2,
        color: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 3),
        blurRadius: 12,
        spreadRadius: -4,
        color: RadixColors.black.alphaVariantSwatch.scale_2,
      ),
      BoxShadow(
        offset: Offset(0, 4),
        blurRadius: 16,
        spreadRadius: -8,
        color: RadixColors.black.alphaVariantSwatch.scale_2,
      ),
    ],
    scale_4: [
      BoxShadow(
        offset: Offset.zero,
        blurRadius: 0,
        spreadRadius: 1,
        color: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 8),
        blurRadius: 40,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 32,
        spreadRadius: -16,
        color: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
      ),
    ],
    scale_5: [
      BoxShadow(
        offset: Offset.zero,
        blurRadius: 0,
        spreadRadius: 1,
        color: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 60,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 32,
        spreadRadius: -16,
        color: RadixColorScheme.kLight.gray.radixScale_5.alphaVariant,
      ),
    ],
    scale_6: [
      BoxShadow(
        offset: Offset.zero,
        blurRadius: 0,
        spreadRadius: 1,
        color: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 60,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 16),
        blurRadius: 64,
        spreadRadius: 0,
        color: RadixColorScheme.kLight.gray.radixScale_2.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 16),
        blurRadius: 36,
        spreadRadius: -20,
        color: RadixColorScheme.kLight.gray.radixScale_7.alphaVariant,
      ),
    ],
  );

  static final RadixShadowSwatch kLight = RadixShadowSwatch(
    scale_2: [
      BoxShadow(
        offset: Offset.zero,
        blurRadius: 0,
        spreadRadius: 0.5,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 4,
        spreadRadius: 0,
        color: RadixColorScheme.kLight.neutral.radixScale_2.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 2),
        blurRadius: 1,
        spreadRadius: -1,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 3,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
    ],
    scale_3: [
      BoxShadow(
        offset: Offset(0, 2),
        blurRadius: 3,
        spreadRadius: -2,
        color: RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 3),
        blurRadius: 12,
        spreadRadius: -4,
        color: RadixColors.black.alphaVariantSwatch.scale_2,
      ),
      BoxShadow(
        offset: Offset(0, 4),
        blurRadius: 16,
        spreadRadius: -8,
        color: RadixColors.black.alphaVariantSwatch.scale_2,
      ),
    ],
    scale_4: [
      BoxShadow(
        offset: Offset(0, 8),
        blurRadius: 40,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 32,
        spreadRadius: -16,
        color: RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
      ),
    ],
    scale_5: [
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 60,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 32,
        spreadRadius: -16,
        color: RadixColorScheme.kLight.neutral.radixScale_5.alphaVariant,
      ),
    ],
    scale_6: [
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 60,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 16),
        blurRadius: 64,
        spreadRadius: 0,
        color: RadixColorScheme.kLight.neutral.radixScale_2.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 16),
        blurRadius: 36,
        spreadRadius: -20,
        color: RadixColorScheme.kLight.neutral.radixScale_7.alphaVariant,
      ),
    ],
  );

  static final RadixShadowSwatch kDark = RadixShadowSwatch(
    scale_2: [
      BoxShadow(
        offset: Offset.zero,
        blurRadius: 0,
        spreadRadius: 0.5,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 4,
        spreadRadius: 0,
        color: RadixColorScheme.kDark.neutral.radixScale_2.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 2),
        blurRadius: 1,
        spreadRadius: -1,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 3,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
    ],
    scale_3: [
      BoxShadow(
        offset: Offset(0, 2),
        blurRadius: 3,
        spreadRadius: -2,
        color: RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 3),
        blurRadius: 12,
        spreadRadius: -4,
        color: RadixColors.black.alphaVariantSwatch.scale_2,
      ),
      BoxShadow(
        offset: Offset(0, 4),
        blurRadius: 16,
        spreadRadius: -8,
        color: RadixColors.black.alphaVariantSwatch.scale_2,
      ),
    ],
    scale_4: [
      BoxShadow(
        offset: Offset(0, 8),
        blurRadius: 40,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_1,
      ),
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 32,
        spreadRadius: -16,
        color: RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
      ),
    ],
    scale_5: [
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 60,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_3,
      ),
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 32,
        spreadRadius: -16,
        color: RadixColorScheme.kDark.neutral.radixScale_5.alphaVariant,
      ),
    ],
    scale_6: [
      BoxShadow(
        offset: Offset(0, 12),
        blurRadius: 60,
        spreadRadius: 0,
        color: RadixColors.black.alphaVariantSwatch.scale_3,
      ),
      BoxShadow(
        offset: Offset(0, 16),
        blurRadius: 64,
        spreadRadius: 0,
        color: RadixColorScheme.kDark.neutral.radixScale_2.alphaVariant,
      ),
      BoxShadow(
        offset: Offset(0, 16),
        blurRadius: 36,
        spreadRadius: -20,
        color: RadixColorScheme.kDark.neutral.radixScale_7.alphaVariant,
      ),
    ],
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return super == other &&
           other is RadixShadowSwatch &&
           other.scale_2 == scale_2 &&
           other.scale_3 == scale_3 &&
           other.scale_4 == scale_4 &&
           other.scale_5 == scale_5 &&
           other.scale_6 == scale_6;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    scale_2,
    scale_3,
    scale_4,
    scale_5,
    scale_6,
  );

  @override
  String toString() => objectRuntimeType(this, 'RadixShadowSwatch');

  /// Linearly interpolate between two [RadixShadowSwatch]es.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixShadowSwatch lerp(RadixShadowSwatch? a, RadixShadowSwatch? b, double t) {
    if (identical(a, b) && a != null) {
      return a;
    }
    return RadixShadowSwatch(
      scale_2: BoxShadow.lerpList(a?.scale_2, b?.scale_2, t)!,
      scale_3: BoxShadow.lerpList(a?.scale_3, b?.scale_3, t)!,
      scale_4: BoxShadow.lerpList(a?.scale_4, b?.scale_4, t)!,
      scale_5: BoxShadow.lerpList(a?.scale_5, b?.scale_5, t)!,
      scale_6: BoxShadow.lerpList(a?.scale_6, b?.scale_6, t)!,
    );
  }

  /// The [RadixThemeData.shadows] of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).shadows`.
  static RadixShadowSwatch of(BuildContext context) => RadixTheme.of(context).shadows;

  /// The [RadixThemeExtension.shadows] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).shadows`.
  static RadixShadowSwatch fromTheme(BuildContext context) => RadixTheme.fromTheme(context).shadows;

  /// The [RadixThemeExtension.shadows] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).shadows`.
  static RadixShadowSwatch extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).shadows;
}
