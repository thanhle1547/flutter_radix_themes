import 'dart:ui';

import 'package:flutter/material.dart';

import 'colors.dart';
import 'radius.dart';
import 'space.dart';
import 'text_theme.dart';
import 'theme.dart';
import 'theme_data.dart';

class RadixBadgeVariantStyle {
  RadixBadgeVariantStyle({
    this.debugVariant,
    this.backgroundColor,
    required this.textColor,
    this.side,
  });

  final RadixBadgeVariant? debugVariant;

  final Color? backgroundColor;
  final Color textColor;
  final BorderSide? side;

  /// Linearly interpolate between two [RadixBadgeVariantStyle]s.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixBadgeVariantStyle lerp(RadixBadgeVariantStyle a, RadixBadgeVariantStyle b, double t) {
    return RadixBadgeVariantStyle(
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
      textColor: Color.lerp(a.textColor, b.textColor, t)!,
      side: _lerpSides(a.side, b.side, t),
    );
  }

  // Special case because BorderSide.lerp() doesn't support null arguments.
  static BorderSide? _lerpSides(BorderSide? a, BorderSide? b, double t) {
    if (a == null && b == null) {
      return null;
    }
    if (identical(a, b)) {
      return a;
    }
    if (a == null) {
      return BorderSide.lerp(BorderSide(width: 0, color: b!.color.withAlpha(0)), b, t);
    }
    if (b == null) {
      return BorderSide.lerp(BorderSide(width: 0, color: a.color.withAlpha(0)), a, t);
    }
    return BorderSide.lerp(a, b, t);
  }
}

class RadixBadgeSizeSwatch {
  const RadixBadgeSizeSwatch({
    required this.s1,
    required this.s2,
    required this.s3,
  });

  final RadixBadgeStyleFactor s1;
  final RadixBadgeStyleFactor s2;
  final RadixBadgeStyleFactor s3;

  static final RadixBadgeSizeSwatch kDefault = RadixBadgeSizeSwatch(
    s1: RadixBadgeStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_1 * 1.5,
        vertical: RadixSpace.kDefault.scale_1 * 0.5,
      ),
      textStyle: RadixTextTheme.kDefault.scale_1.copyWith(
        fontVariations: RadixFigmaTextFontVariations.medium_510
      ),
      gap: RadixSpace.kDefault.scale_1 * 1.5,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_1,
      ),
    ),
    s2: RadixBadgeStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_2,
        vertical: RadixSpace.kDefault.scale_1,
      ),
      textStyle: RadixTextTheme.kDefault.scale_1.copyWith(
        fontVariations: RadixFigmaTextFontVariations.medium_510
      ),
      gap: RadixSpace.kDefault.scale_1 * 1.5,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_2,
      ),
    ),
    s3: RadixBadgeStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_2 * 1.25,
        vertical: RadixSpace.kDefault.scale_1,
      ),
      textStyle: RadixTextTheme.kDefault.scale_2.copyWith(
        fontVariations: RadixFigmaTextFontVariations.medium_510
      ),
      gap: RadixSpace.kDefault.scale_2,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_2,
      ),
    ),
  );

  /// Linearly interpolate between two [RadixBadgeSizeSwatch]es.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixBadgeSizeSwatch lerp(RadixBadgeSizeSwatch a, RadixBadgeSizeSwatch b, double t) {
    return RadixBadgeSizeSwatch(
      s1: a.s1.lerp(b.s1, t),
      s2: a.s2.lerp(b.s2, t),
      s3: a.s3.lerp(b.s3, t),
    );
  }
}

class RadixBadgeThemeData {
  const RadixBadgeThemeData({
    required this.solid,
    required this.soft,
    required this.surface,
    required this.outline,
    required this.sizeSwatch,
  });

  final RadixBadgeVariantStyle solid;
  final RadixBadgeVariantStyle soft;
  final RadixBadgeVariantStyle surface;
  final RadixBadgeVariantStyle outline;

  final RadixBadgeSizeSwatch sizeSwatch;

  static final RadixBadgeThemeData kLight = RadixBadgeThemeData(
    solid: RadixBadgeVariantStyle(
      debugVariant: RadixBadgeVariant.solid,
      backgroundColor: RadixColorScheme.kLight.accent.scale_9,
      textColor: RadixColorScheme.kLight.accent.contrast!,
    ),
    soft: RadixBadgeVariantStyle(
      debugVariant: RadixBadgeVariant.soft,
      backgroundColor: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kLight.accent.radixScale_11.alphaVariant,
    ),
    surface: RadixBadgeVariantStyle(
      debugVariant: RadixBadgeVariant.surface,
      backgroundColor: RadixColorScheme.kLight.accent.surface!,
      textColor: RadixColorScheme.kLight.accent.radixScale_11.alphaVariant,
      side: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kLight.accent.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    ),
    outline: RadixBadgeVariantStyle(
      debugVariant: RadixBadgeVariant.outline,
      textColor: RadixColorScheme.kLight.accent.radixScale_11.alphaVariant,
      side: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kLight.accent.radixScale_8.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    ),
    sizeSwatch: RadixBadgeSizeSwatch.kDefault,
  );

  static final RadixBadgeThemeData kDark = RadixBadgeThemeData(
    solid: RadixBadgeVariantStyle(
      debugVariant: RadixBadgeVariant.solid,
      backgroundColor: RadixColorScheme.kDark.accent.scale_9,
      textColor: RadixColorScheme.kDark.accent.contrast!,
    ),
    soft: RadixBadgeVariantStyle(
      debugVariant: RadixBadgeVariant.soft,
      backgroundColor: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kDark.accent.radixScale_11.alphaVariant,
    ),
    surface: RadixBadgeVariantStyle(
      debugVariant: RadixBadgeVariant.surface,
      backgroundColor: RadixColorScheme.kDark.accent.surface!,
      textColor: RadixColorScheme.kDark.accent.radixScale_11.alphaVariant,
      side: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kDark.accent.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    ),
    outline: RadixBadgeVariantStyle(
      debugVariant: RadixBadgeVariant.outline,
      textColor: RadixColorScheme.kDark.accent.radixScale_11.alphaVariant,
      side: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kDark.accent.radixScale_8.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    ),
    sizeSwatch: RadixBadgeSizeSwatch.kDefault,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return super == other &&
           other is RadixBadgeThemeData &&
           other.solid == solid &&
           other.soft == soft &&
           other.surface == surface &&
           other.outline == outline &&
           other.sizeSwatch == sizeSwatch;
  }

  @override
  int get hashCode => Object.hash(runtimeType, solid, soft, surface, outline, sizeSwatch);

  /// Linearly interpolate between two [RadixBadgeThemeData]s.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixBadgeThemeData? lerp(RadixBadgeThemeData? a, RadixBadgeThemeData? b, double t) {
    if (identical(a, b)) {
      return a;
    }

    if (a == null && b == null) {
      return null;
    }

    if ((a != null && b == null) || (a == null && b != null)) {
      throw UnsupportedError(
        "Cannot interpolate between a null value and a non-null value. "
        "Both operands ('a' and 'b') must be non-null for linear interpolation to proceed.",
      );
    }

    return RadixBadgeThemeData(
      solid: RadixBadgeVariantStyle.lerp(a!.solid, b!.solid, t),
      soft: RadixBadgeVariantStyle.lerp(a.soft, b.soft, t),
      surface: RadixBadgeVariantStyle.lerp(a.surface, b.surface, t),
      outline: RadixBadgeVariantStyle.lerp(a.outline, b.outline, t),
      sizeSwatch: RadixBadgeSizeSwatch.lerp(a.sizeSwatch, b.sizeSwatch, t),
    );
  }

  /// The [RadixThemeData.badgeTheme] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).badgeTheme`.
  static RadixBadgeThemeData? of(BuildContext context) => RadixTheme.of(context).badgeTheme;

  /// The [RadixThemeExtension.badgeTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).badgeTheme`.
  static RadixBadgeThemeData? fromTheme(BuildContext context) => RadixTheme.fromTheme(context).badgeTheme;

  /// The [RadixThemeExtension.badgeTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).badgeTheme`.
  static RadixBadgeThemeData? extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).badgeTheme;
}

/// To use, subclass [RadixBadgeCustomThemeData],
/// define a number of fields (e.g. [Color]s), and implement the [copyWith] and
/// [lerp] methods. The latter will ensure smooth transitions of properties when
/// switching themes.
abstract class RadixBadgeCustomThemeData extends ThemeExtension<RadixBadgeCustomThemeData> {
  RadixBadgeStyle getStyle(RadixBadgeVariant variant, RadixBadgeSize size);

  /// The [RadixThemeData.badgeCustomTheme] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).badgeCustomTheme`.
  static RadixBadgeCustomThemeData? of(BuildContext context) => RadixTheme.of(context).badgeCustomTheme;

  /// The [RadixThemeExtension.badgeCustomTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).badgeCustomTheme`.
  static RadixBadgeCustomThemeData? fromTheme(BuildContext context) => RadixTheme.fromTheme(context).badgeCustomTheme;

  /// The [RadixThemeExtension.badgeCustomTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).badgeCustomTheme`.
  static RadixBadgeCustomThemeData? extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).badgeCustomTheme;
}

class RadixBadgeStyleFactor {
  RadixBadgeStyleFactor({
    required this.padding,
    required this.textStyle,
    this.textScaleFactor,
    this.textScaler,
    this.gap = 0.0,
    this.borderRadius,
  });

  final EdgeInsets padding;

  final TextStyle textStyle;

  @Deprecated(
    'Use textScaler instead. '
    'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
    'This feature was deprecated after v3.12.0-2.0.pre.',
  )
  final double? textScaleFactor;

  final TextScaler? textScaler;

  final double gap;

  final BorderRadiusGeometry? borderRadius;

  /// Linearly interpolate between two [RadixBadgeStyleFactor]s.
  ///
  /// {@macro dart.ui.shadow.lerp}
  RadixBadgeStyleFactor lerp(RadixBadgeStyleFactor other, double t) {
    return RadixBadgeStyleFactor(
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      textScaleFactor: lerpDouble(textScaleFactor, other.textScaleFactor, t),
      textScaler: t < 0.5 ? textScaler : other.textScaler,
      gap: lerpDouble(gap, other.gap, t)!,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t),
    );
  }
}

/// {@tool dartpad}
/// This sample shows how to create each of the Radix badge variants with Flutter.
///
/// ** See code in example/lib/button_style/button_style.0.dart **
/// {@end-tool}
class RadixBadgeStyleModifier {
  RadixBadgeStyleModifier({
    this.backgroundColor,
    this.padding,
    this.textStyle,
    this.textColor,
    this.textScaleFactor,
    this.textScaler,
    this.side,
    this.borderRadius,
  }) : _border = side == null
            ? null
            : BoxBorder.fromBorderSide(side);

  factory RadixBadgeStyleModifier.withAccent({
    required RadixColorsSwatch accent,
    required RadixBadgeVariant variant,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    BorderSide? side,
    BorderRadiusGeometry? borderRadius,
  }) {
    switch (variant) {
      case RadixBadgeVariant.solid:
        return RadixBadgeStyleModifier(
          backgroundColor: accent.scale_9,
          padding: padding,
          textStyle: textStyle,
          textColor: textColor ?? accent.contrast,
          textScaleFactor: textScaleFactor,
          textScaler: textScaler,
          side: side,
          borderRadius: borderRadius,
        );
      case RadixBadgeVariant.soft:
        return RadixBadgeStyleModifier(
          backgroundColor: accent.radixScale_3.alphaVariant,
          padding: padding,
          textStyle: textStyle,
          textColor: textColor ?? accent.radixScale_11.alphaVariant,
          textScaleFactor: textScaleFactor,
          textScaler: textScaler,
          side: side,
          borderRadius: borderRadius,
        );
      case RadixBadgeVariant.surface:
        return RadixBadgeStyleModifier(
          backgroundColor: accent.surface!,
          padding: padding,
          textStyle: textStyle,
          textColor: textColor ?? accent.radixScale_11.alphaVariant,
          textScaleFactor: textScaleFactor,
          textScaler: textScaler,
          side: side?.copyWith(
            color: accent.radixScale_6.alphaVariant,
          ) ?? BorderSide(
            color: accent.radixScale_6.alphaVariant,
          ),
          borderRadius: borderRadius,
        );
      case RadixBadgeVariant.outline:
        return RadixBadgeStyleModifier(
          padding: padding,
          textStyle: textStyle,
          textColor: textColor ?? accent.radixScale_11.alphaVariant,
          textScaleFactor: textScaleFactor,
          textScaler: textScaler,
          side: side?.copyWith(
            color: accent.radixScale_8.alphaVariant,
          ) ?? BorderSide(
            color: accent.radixScale_8.alphaVariant,
          ),
          borderRadius: borderRadius,
        );
    }
  }

  final Color? backgroundColor;

  final EdgeInsets? padding;

  final TextStyle? textStyle;

  final Color? textColor;

  @Deprecated(
    'Use textScaler instead. '
    'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
    'This feature was deprecated after v3.12.0-2.0.pre.',
  )
  final double? textScaleFactor;

  final TextScaler? textScaler;

  final BorderSide? side;

  final BoxBorder? _border;

  final BorderRadiusGeometry? borderRadius;
}

class RadixBadgeStyle extends RadixBadgeStyleFactor {
  RadixBadgeStyle({
    this.debugVariant,
    this.debugSize,
    this.backgroundColor,
    required super.padding,
    required super.textStyle,
    required this.textColor,
    this.side,
    super.textScaleFactor,
    super.textScaler,
    super.gap,
    super.borderRadius,
  }) : _border = side == null
            ? null
            : BoxBorder.fromBorderSide(side);

  final RadixBadgeVariant? debugVariant;
  final RadixBadgeSize? debugSize;

  final Color? backgroundColor;

  final Color textColor;

  final BorderSide? side;

  final BoxBorder? _border;

  factory RadixBadgeStyle.from(
    RadixBadgeThemeData badgeTheme,
    RadixBadgeVariant variant,
    RadixBadgeSize size,
  ) {
    final RadixBadgeVariantStyle variantStyle;

    switch (variant) {
      case RadixBadgeVariant.solid:
        variantStyle = badgeTheme.solid;
      case RadixBadgeVariant.soft:
        variantStyle = badgeTheme.soft;
      case RadixBadgeVariant.surface:
        variantStyle = badgeTheme.surface;
      case RadixBadgeVariant.outline:
        variantStyle = badgeTheme.outline;
    }

    final RadixBadgeSizeSwatch sizeSwatch = badgeTheme.sizeSwatch;

    final RadixBadgeStyleFactor factor = switch (size) {
      RadixBadgeSize.$1 => sizeSwatch.s1,
      RadixBadgeSize.$2 => sizeSwatch.s2,
      RadixBadgeSize.$3 => sizeSwatch.s3,
    };

    return RadixBadgeStyle(
      debugVariant: variantStyle.debugVariant,
      debugSize: size,
      backgroundColor: variantStyle.backgroundColor,
      padding: factor.padding,
      textStyle: factor.textStyle,
      textColor: variantStyle.textColor,
      side: variantStyle.side,
      borderRadius: factor.borderRadius,
      textScaleFactor: factor.textScaleFactor,
      textScaler: factor.textScaler,
      gap: factor.gap,
    );
  }
}

enum RadixBadgeSize {
  $1, $2, $3
}

enum RadixBadgeVariant {
  solid, soft, surface, outline
}

class RadixBadge extends StatelessWidget {
  const RadixBadge({
    super.key,
    required this.text,
    this.size = RadixBadgeSize.$2,
    this.variant = RadixBadgeVariant.soft,
    this.styleModifier,
  }) : child = null;

  const RadixBadge.child({
    super.key,
    required Widget this.child,
    this.size = RadixBadgeSize.$2,
    this.variant = RadixBadgeVariant.soft,
    this.styleModifier,
  }) : text = '';

  final RadixBadgeSize size;

  final RadixBadgeVariant variant;

  final RadixBadgeStyleModifier? styleModifier;

  final String text;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final RadixBadgeStyle style;

    final RadixBadgeThemeData? badgeTheme;
    final RadixBadgeCustomThemeData? badgeCustomTheme;

    final RadixThemeData? radixThemeData = RadixTheme.maybeOf(context);
    if (radixThemeData != null) {
      badgeTheme = radixThemeData.badgeTheme;
      badgeCustomTheme = radixThemeData.badgeCustomTheme;
    } else {
      final ThemeData theme = Theme.of(context);
      badgeTheme = RadixBadgeThemeData.extensionFrom(theme);
      badgeCustomTheme = RadixBadgeCustomThemeData.extensionFrom(theme);
    }

    if (badgeTheme != null) {
      style = RadixBadgeStyle.from(
        badgeTheme,
        variant,
        size,
      );
    } else {
      style = badgeCustomTheme!.getStyle(variant, size);
    }

    TextStyle textStyle = styleModifier?.textStyle ?? style.textStyle;
    final Color textColor = styleModifier?.textColor ?? style.textColor;

    textStyle = textStyle.copyWith(color: textColor);

    Widget child;

    if (this.child case final Widget customChild) {
      final IconTheme? iconTheme = context.dependOnInheritedWidgetOfExactType<IconTheme>();
      final IconThemeData iconThemeData =
          (iconTheme?.data ?? const IconThemeData.fallback()).copyWith(
            color: textColor,
          );

      child = DefaultTextStyle(
        style: textStyle,
        child: IconTheme(
          data: iconThemeData,
          child: customChild,
        ),
      );
    } else if (text.isNotEmpty) {
      child = Text(text, style: textStyle);
    } else {
      child = const SizedBox.shrink();
    }

    final EdgeInsets padding = styleModifier?.padding ?? style.padding;

    child = Padding(
      padding: padding,
      child: child,
    );

    final Color? backgroundColor = styleModifier?.backgroundColor ?? style.backgroundColor;
    final BoxBorder? border = styleModifier?._border ?? style._border;
    final BorderRadiusGeometry? borderRadius = styleModifier?.borderRadius ?? style.borderRadius;

    if (border != null || borderRadius != null) {
      final Decoration decoration = BoxDecoration(
        color: backgroundColor,
        border: border,
        borderRadius: borderRadius,
        shape: BoxShape.rectangle,
      );

      child = DecoratedBox(
        decoration: decoration,
        child: child,
      );
    } else if (backgroundColor != null) {
      child = ColoredBox(color: backgroundColor, child: child);
    }

    return child;
  }
}
