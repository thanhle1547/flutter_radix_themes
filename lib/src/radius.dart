import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'badge.dart';
import 'button.dart';
import 'input_decorator.dart';
import 'theme.dart';
import 'theme_data.dart';

const Radius _kMinRadius = Radius.circular(0.5);
const Radius _kMaxRadius = Radius.circular(9999);

/// To obtain the radius, call [RadixRadiusFactor.of] with the current
/// [BuildContext]. This is equivalent to calling [RadixTheme.of] and reading
/// the [RadixThemeData.radius] property.
///
/// See also:
///
///  * <https://www.radix-ui.com/themes/docs/theme/radius>
@immutable
final class RadixRadiusFactor {
  const RadixRadiusFactor({
    required this.none,
    required this.small,
    required this.medium,
    required this.large,
    required this.full,
  });

  final RadixRadius none;
  final RadixRadius small;
  final RadixRadius medium;
  final RadixRadius large;
  final RadixRadius full;

  static final RadixRadiusFactor kDefault = RadixRadiusFactor(
    none: RadixRadius(
      debugLabel: 'none',
      factor: 0.0,
      swatch: RadixRadiusSwatch.kBase,
      full: Radius.zero,
      thumb: _kMinRadius,
    ),
    small: RadixRadius(
      debugLabel: 'small',
      factor: 0.75,
      swatch: RadixRadiusSwatch.kBase,
      full: Radius.zero,
      thumb: _kMinRadius,
    ),
    medium: RadixRadius(
      debugLabel: 'medium',
      factor: 1,
      swatch: RadixRadiusSwatch.kBase,
      full: Radius.zero,
      thumb: _kMaxRadius,
    ),
    large: RadixRadius(
      debugLabel: 'large',
      factor: 1.5,
      swatch: RadixRadiusSwatch.kBase,
      full: Radius.zero,
      thumb: _kMaxRadius,
    ),
    full: RadixRadius(
      debugLabel: 'full',
      factor: 1.5,
      swatch: RadixRadiusSwatch.kBase,
      full: _kMaxRadius,
      max: RadixRadiusSwatch.kMax,
      thumb: _kMaxRadius,
    ),
  );

  /// The [RadixThemeData.radius] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).radius`.
  static RadixRadiusFactor of(BuildContext context) => RadixTheme.of(context).radius;

  /// The [RadixThemeExtension.radius] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).radius`.
  static RadixRadiusFactor fromTheme(BuildContext context) => RadixTheme.fromTheme(context).radius;

  /// The [RadixThemeExtension.radius] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).radius`.
  static RadixRadiusFactor extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).radius;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return super == other &&
           other is RadixRadiusFactor &&
           other.none == none &&
           other.small == small &&
           other.medium == medium &&
           other.large == large &&
           other.full == full;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    none,
    small,
    medium,
    large,
    full,
  );

  @override
  String toString() => objectRuntimeType(this, 'RadixRadiusFactor');

  /// Linearly interpolate between two [RadixRadiusFactor]es.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixRadiusFactor lerp(RadixRadiusFactor? a, RadixRadiusFactor? b, double t) {
    if (identical(a, b) && a != null) {
      return a;
    }
    return RadixRadiusFactor(
      none: RadixRadius.lerp(a?.none, b?.none, t),
      small: RadixRadius.lerp(a?.small, b?.small, t),
      medium: RadixRadius.lerp(a?.medium, b?.medium, t),
      large: RadixRadius.lerp(a?.large, b?.large, t),
      full: RadixRadius.lerp(a?.full, b?.full, t),
    );
  }
}

/// Defines a swatch of radius for circular shapes
/// based on Radix UI's 6-step scale.
///
/// See also:
///
///  * <https://www.radix-ui.com/themes/docs/theme/radius>
@immutable
final class RadixRadiusSwatch {
  /// Creates a Radix spacing that uses the given values.
  const RadixRadiusSwatch({
    required this.scale_1,
    required this.scale_2,
    required this.scale_3,
    required this.scale_4,
    required this.scale_5,
    required this.scale_6,
  });

  final Radius scale_1;
  final Radius scale_2;
  final Radius scale_3;
  final Radius scale_4;
  final Radius scale_5;
  final Radius scale_6;

  static const RadixRadiusSwatch kBase = RadixRadiusSwatch(
    scale_1: Radius.circular(3),
    scale_2: Radius.circular(4),
    scale_3: Radius.circular(6),
    scale_4: Radius.circular(8),
    scale_5: Radius.circular(12),
    scale_6: Radius.circular(16),
  );

  static const RadixRadiusSwatch kMax = RadixRadiusSwatch(
    scale_1: Radius.circular(9999),
    scale_2: Radius.circular(9999),
    scale_3: Radius.circular(9999),
    scale_4: Radius.circular(9999),
    scale_5: Radius.circular(9999),
    scale_6: Radius.circular(9999),
  );

  /// Multiplication operator.
  RadixRadiusSwatch operator *(double factor) {
    return RadixRadiusSwatch(
      scale_1: scale_1 * factor,
      scale_2: scale_2 * factor,
      scale_3: scale_3 * factor,
      scale_4: scale_4 * factor,
      scale_5: scale_5 * factor,
      scale_6: scale_6 * factor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return super == other &&
           other is RadixRadiusSwatch &&
           other.scale_1 == scale_1 &&
           other.scale_2 == scale_2 &&
           other.scale_3 == scale_3 &&
           other.scale_4 == scale_4 &&
           other.scale_5 == scale_5 &&
           other.scale_6 == scale_6;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    scale_1,
    scale_2,
    scale_3,
    scale_4,
    scale_5,
    scale_6,
  );

  @override
  String toString() => objectRuntimeType(this, 'RadixRadiusSwatch');

  /// Linearly interpolate between two [RadixRadiusSwatch]es.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixRadiusSwatch? lerp(RadixRadiusSwatch? a, RadixRadiusSwatch? b, double t) {
    if (identical(a, b)) {
      if (a != null) {
        return a;
      } else if (b == null) {
        return null;
      }
    }
    return RadixRadiusSwatch(
      scale_1: Radius.lerp(a?.scale_1, b?.scale_1, t)!,
      scale_2: Radius.lerp(a?.scale_2, b?.scale_2, t)!,
      scale_3: Radius.lerp(a?.scale_3, b?.scale_3, t)!,
      scale_4: Radius.lerp(a?.scale_4, b?.scale_4, t)!,
      scale_5: Radius.lerp(a?.scale_5, b?.scale_5, t)!,
      scale_6: Radius.lerp(a?.scale_6, b?.scale_6, t)!,
    );
  }
}

/// A radius for circular shapes.
final class RadixRadius {
  RadixRadius({
    /// A multiplier that controls the radius.
    String? debugLabel,
    required double factor,
    required RadixRadiusSwatch swatch,
    required this.full,
    RadixRadiusSwatch? max,
    required this.thumb,
  }) : _debugLabel = debugLabel,
       swatch = swatch * factor,
       _max = max;

  RadixRadius._({
    String? debugLabel,
    required this.swatch,
    required this.full,
    required RadixRadiusSwatch? max,
    required this.thumb,
  }) : _debugLabel = debugLabel,
       _max = max;

  final String? _debugLabel;

  final RadixRadiusSwatch swatch;

  /// Used to calculate a fully rounded radius.
  ///
  /// Usually used within a `max()` function.
  final Radius full;

  final RadixRadiusSwatch? _max;

  RadixRadiusSwatch get max => _max ?? swatch;

  /// Used to calculate radius of a thumb element.
  ///
  /// Usually used within a `max()` function.
  final Radius thumb;

  static RadixRadius lerp(RadixRadius? a, RadixRadius? b, double t) {
    return RadixRadius._(
      debugLabel: t > 0.5 ? a?._debugLabel : b?._debugLabel,
      swatch: RadixRadiusSwatch.lerp(a?.swatch, b?.swatch, t)!,
      full: Radius.lerp(a?.full, b?.full, t)!,
      max: RadixRadiusSwatch.lerp(a?.max, b?.max, t),
      thumb: Radius.lerp(a?.thumb, b?.thumb, t)!,
    );
  }
}

extension RadixRadiusExtension on RadixRadius {
  BorderRadius resolveForButton({
    required RadixButtonSize buttonSize,
  }) {
    final Radius radius = switch (buttonSize) {
      RadixButtonSize.$1 => max.scale_1,
      RadixButtonSize.$2 => max.scale_2,
      RadixButtonSize.$3 => max.scale_3,
      RadixButtonSize.$4 => max.scale_4,
    };

    return BorderRadius.all(radius);
  }

  BorderRadius resolveForBadge({
    required RadixBadgeSize badgeSize,
  }) {
    final Radius radius = switch (badgeSize) {
      RadixBadgeSize.$1 => max.scale_1,
      RadixBadgeSize.$2 => max.scale_2,
      RadixBadgeSize.$3 => max.scale_3,
    };

    return BorderRadius.all(radius);
  }

  BorderRadius resolveForInput({
    required RadixInputSize inputSize,
  }) {
    final Radius radius = switch (inputSize) {
      RadixInputSize.$1 => max.scale_1,
      RadixInputSize.$2 => max.scale_2,
      RadixInputSize.$3 => max.scale_3,
    };

    return BorderRadius.all(radius);
  }
}
