import 'dart:ui';

import 'package:flutter/material.dart';

import 'theme.dart';
import 'theme_data.dart';

/// To obtain the spacing, call [RadixSpace.of] with the current
/// [BuildContext]. This is equivalent to calling [RadixTheme.of] and reading
/// the [RadixThemeData.space] property.
///
/// Spacing values are derived from a 9-step scale,
/// which is used for props such as margin and padding.
///
/// See also:
///
///  * <https://www.radix-ui.com/themes/docs/theme/spacing>
@immutable
final class RadixSpace {
  /// Creates a Radix spacing that uses the given values.
  const RadixSpace({
    required this.scale_1,
    required this.scale_2,
    required this.scale_3,
    required this.scale_4,
    required this.scale_5,
    required this.scale_6,
    required this.scale_7,
    required this.scale_8,
    required this.scale_9,
  });

  final double scale_1;
  final double scale_2;
  final double scale_3;
  final double scale_4;
  final double scale_5;
  final double scale_6;
  final double scale_7;
  final double scale_8;
  final double scale_9;

  static const RadixSpace kDefault = RadixSpace(
    scale_1: 4,
    scale_2: 8,
    scale_3: 12,
    scale_4: 16,
    scale_5: 24,
    scale_6: 32,
    scale_7: 40,
    scale_8: 48,
    scale_9: 64,
  );

  /// Linearly interpolate between two spacing.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixSpace lerp(RadixSpace? a, RadixSpace? b, double t) {
    if (identical(a, b) && a != null) {
      return a;
    }
    return RadixSpace(
      scale_1: lerpDouble(a?.scale_1, b?.scale_1, t)!,
      scale_2: lerpDouble(a?.scale_2, b?.scale_2, t)!,
      scale_3: lerpDouble(a?.scale_3, b?.scale_3, t)!,
      scale_4: lerpDouble(a?.scale_4, b?.scale_4, t)!,
      scale_5: lerpDouble(a?.scale_5, b?.scale_5, t)!,
      scale_6: lerpDouble(a?.scale_6, b?.scale_6, t)!,
      scale_7: lerpDouble(a?.scale_7, b?.scale_7, t)!,
      scale_8: lerpDouble(a?.scale_8, b?.scale_8, t)!,
      scale_9: lerpDouble(a?.scale_9, b?.scale_9, t)!,
    );
  }

  /// The [RadixThemeData.space] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).space`.
  static RadixSpace of(BuildContext context) => RadixTheme.of(context).space;

  /// The [RadixThemeExtension.space] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).space`.
  static RadixSpace fromTheme(BuildContext context) => RadixTheme.fromTheme(context).space;

  /// The [RadixThemeExtension.space] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).space`.
  static RadixSpace extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).space;
}
