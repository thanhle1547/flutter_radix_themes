import 'dart:ui';

import 'package:css_filter/css_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'colors.dart';
import 'radius.dart';
import 'space.dart';
import 'spinner.dart';
import 'state.dart';
import 'text_theme.dart';
import 'theme.dart';
import 'theme_data.dart';

class RadixButtonVariantStyle extends RadixButtonSizeSwatch {
  RadixButtonVariantStyle({
    this.debugVariant,
    required this.backgroundColor,
    required this.textColor,
    this.shapeBorder,
    this.boxShadow,
    this.filter,
    required super.s1,
    required super.s2,
    required super.s3,
    required super.s4,
  }) : assert(s1.borderRadius == null || shapeBorder == null),
       assert(s2.borderRadius == null || shapeBorder == null),
       assert(s3.borderRadius == null || shapeBorder == null),
       assert(s4.borderRadius == null || shapeBorder == null);

  RadixButtonVariantStyle.from({
    this.debugVariant,
    required this.backgroundColor,
    required this.textColor,
    this.shapeBorder,
    this.boxShadow,
    this.filter,
    required RadixButtonSizeSwatch sizeSwatch,
  }) : super(
         s1: sizeSwatch.s1,
         s2: sizeSwatch.s2,
         s3: sizeSwatch.s3,
         s4: sizeSwatch.s4,
       );

  final RadixButtonVariant? debugVariant;

  final WidgetStateColor backgroundColor;
  final WidgetStateColor textColor;
  final WidgetStateProperty<ShapeBorder?>? shapeBorder;
  final List<BoxShadow>? boxShadow;
  final WidgetStateProperty<CSSFilterMatrix?>? filter;

  /// Linearly interpolate between two [RadixButtonVariantStyle]s.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixButtonVariantStyle lerp(RadixButtonVariantStyle a, RadixButtonVariantStyle b, double t) {
    return RadixButtonVariantStyle(
      backgroundColor: EffectiveWidgetStateColor.lerp(a.backgroundColor, b.backgroundColor, t, Color.lerp),
      textColor: EffectiveWidgetStateColor.lerp(a.textColor, b.textColor, t, Color.lerp),
      shapeBorder: WidgetStateProperty.lerp<ShapeBorder?>(a.shapeBorder, b.shapeBorder, t, ShapeBorder.lerp),
      boxShadow: BoxShadow.lerpList(a.boxShadow, b.boxShadow, t),
      filter: t < 0.5 ? a.filter : b.filter,
      s1: a.s1.lerp(b.s1, t),
      s2: a.s2.lerp(b.s2, t),
      s3: a.s3.lerp(b.s3, t),
      s4: a.s4.lerp(b.s4, t),
    );
  }
}

class RadixButtonSizeSwatch {
  const RadixButtonSizeSwatch({
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
  });

  final RadixButtonStyleFactor s1;
  final RadixButtonStyleFactor s2;
  final RadixButtonStyleFactor s3;
  final RadixButtonStyleFactor s4;

  RadixButtonStyleFactor operator [](RadixButtonSize size) {
    return switch (size) {
      RadixButtonSize.$1 => s1,
      RadixButtonSize.$2 => s2,
      RadixButtonSize.$3 => s3,
      RadixButtonSize.$4 => s4,
    };
  }

  static final RadixButtonSizeSwatch kChrome = RadixButtonSizeSwatch(
    s1: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_2,
      ),
      height: RadixSpace.kDefault.scale_5,
      uniformDimension: RadixSpace.kDefault.scale_5,
      textStyle: RadixTextTheme.kDefault.scale_1,
      gap: RadixSpace.kDefault.scale_1,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_1,
      ),
    ),
    s2: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_3,
      ),
      height: RadixSpace.kDefault.scale_6,
      uniformDimension: RadixSpace.kDefault.scale_6,
      textStyle: RadixTextTheme.kDefault.scale_2,
      gap: RadixSpace.kDefault.scale_2,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_2,
      ),
    ),
    s3: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_4,
      ),
      height: RadixSpace.kDefault.scale_7,
      uniformDimension: RadixSpace.kDefault.scale_7,
      textStyle: RadixTextTheme.kDefault.scale_3,
      gap: RadixSpace.kDefault.scale_3,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_3,
      ),
    ),
    s4: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_5,
      ),
      height: RadixSpace.kDefault.scale_8,
      uniformDimension: RadixSpace.kDefault.scale_8,
      textStyle: RadixTextTheme.kDefault.scale_4,
      gap: RadixSpace.kDefault.scale_4,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_4,
      ),
    ),
  );

  static final RadixButtonSizeSwatch kGhost = RadixButtonSizeSwatch(
    s1: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_2,
        vertical: RadixSpace.kDefault.scale_1,
      ),
      uniformPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_1,
      ),
      textStyle: RadixTextTheme.kDefault.scale_1,
      gap: RadixSpace.kDefault.scale_1,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_1,
      ),
    ),
    s2: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_2,
        vertical: RadixSpace.kDefault.scale_1,
      ),
      uniformPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_1 * 1.5,
      ),
      textStyle: RadixTextTheme.kDefault.scale_2,
      gap: RadixSpace.kDefault.scale_1,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_2,
      ),
    ),
    s3: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_3,
        vertical: RadixSpace.kDefault.scale_1 * 1.5,
      ),
      uniformPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_2,
      ),
      textStyle: RadixTextTheme.kDefault.scale_3,
      gap: RadixSpace.kDefault.scale_2,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_3,
      ),
    ),
    s4: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_4,
        vertical: RadixSpace.kDefault.scale_2,
      ),
      uniformPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_3,
      ),
      textStyle: RadixTextTheme.kDefault.scale_4,
      gap: RadixSpace.kDefault.scale_2,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_4,
      ),
    ),
  );

  static final RadixButtonSizeSwatch kFigma = RadixButtonSizeSwatch(
    s1: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_2,
      ),
      uniformPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_1,
      ),
      height: RadixSpace.kDefault.scale_5,
      uniformDimension: RadixSpace.kDefault.scale_5,
      textStyle: RadixTextTheme.kDefault.scale_1.copyWith(
        fontVariations: RadixFigmaTextFontVariations.medium_510
      ),
      gap: RadixSpace.kDefault.scale_1,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_1,
      ),
    ),
    s2: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_3,
      ),
      uniformPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_2,
      ),
      height: RadixSpace.kDefault.scale_6,
      uniformDimension: RadixSpace.kDefault.scale_6,
      textStyle: RadixTextTheme.kDefault.scale_2.copyWith(
        fontVariations: RadixFigmaTextFontVariations.medium_510
      ),
      gap: RadixSpace.kDefault.scale_2,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_2,
      ),
    ),
    s3: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_4,
      ),
      // The Figma design does not specify padding for icon button
      uniformPadding: EdgeInsets.all(11),
      height: RadixSpace.kDefault.scale_7,
      uniformDimension: RadixSpace.kDefault.scale_7,
      textStyle: RadixTextTheme.kDefault.scale_3.copyWith(
        fontVariations: RadixFigmaTextFontVariations.medium_510
      ),
      gap: RadixSpace.kDefault.scale_3,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_3,
      ),
    ),
    s4: RadixButtonStyleFactor(
      padding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_5,
      ),
      // The Figma design does not specify padding for icon button
      uniformPadding: EdgeInsets.all(14),
      height: RadixSpace.kDefault.scale_8,
      uniformDimension: RadixSpace.kDefault.scale_8,
      textStyle: RadixTextTheme.kDefault.scale_4.copyWith(
        fontVariations: RadixFigmaTextFontVariations.medium_510
      ),
      gap: RadixSpace.kDefault.scale_3,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_4,
      ),
    ),
  );

  /// Linearly interpolate between two [RadixButtonSizeSwatch]es.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixButtonSizeSwatch lerp(RadixButtonSizeSwatch a, RadixButtonSizeSwatch b, double t) {
    return RadixButtonSizeSwatch(
      s1: a.s1.lerp(b.s1, t),
      s2: a.s2.lerp(b.s2, t),
      s3: a.s3.lerp(b.s3, t),
      s4: a.s4.lerp(b.s4, t),
    );
  }
}

/// Radix uses inner shadow for classic variant,
/// but Flutter doesn't support inner shadow, so the classic variant
/// isn't defined.
class RadixButtonThemeData {
  const RadixButtonThemeData({
    required this.solid,
    required this.soft,
    required this.surface,
    required this.outline,
    required this.ghost,
  });

  final RadixButtonVariantStyle solid;
  final RadixButtonVariantStyle soft;
  final RadixButtonVariantStyle surface;
  final RadixButtonVariantStyle outline;
  final RadixButtonVariantStyle ghost;

  static final RadixButtonThemeData kLight = RadixButtonThemeData(
    solid: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.solid,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kLight.accent.scale_10,
        WidgetState.pressed: RadixColorScheme.kLight.accent.scale_10,
        WidgetState.disabled: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.scale_9,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kLight.gray.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.contrast!,
      }),
      filter: WidgetStateProperty.fromMap({
        WidgetState.pressed: CSSFilterMatrix().brightness(0.92).saturate(1.1),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kChrome,
    ),
    soft: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.soft,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kLight.accent.radixScale_4.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kLight.accent.radixScale_5.alphaVariant,
        WidgetState.disabled: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kLight.gray.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.radixScale_11.alphaVariant,
      }),
      sizeSwatch: RadixButtonSizeSwatch.kChrome,
    ),
    surface: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.surface,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.pressed: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
        WidgetState.disabled: RadixColorScheme.kLight.gray.radixScale_2.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.surface!,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kLight.gray.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.radixScale_11.alphaVariant,
      }),
      shapeBorder: WidgetStateProperty.fromMap({
        WidgetState.hovered: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.pressed: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.disabled: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.gray.radixScale_6.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.any: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.accent.radixScale_7.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kChrome,
    ),
    outline: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.outline,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kLight.accent.radixScale_2.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
        WidgetState.any: RadixColors.transparent,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kLight.gray.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.radixScale_11.alphaVariant,
      }),
      shapeBorder: WidgetStateProperty.fromMap({
        WidgetState.disabled: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.gray.radixScale_7.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.any: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kChrome,
    ),
    ghost: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.ghost,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kLight.accent.radixScale_4.alphaVariant,
        WidgetState.disabled: RadixColors.transparent,
        WidgetState.any: RadixColors.transparent,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kLight.gray.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.radixScale_11.alphaVariant,
      }),
      sizeSwatch: RadixButtonSizeSwatch.kGhost,
    ),
  );

  /// The visual styles are derived by reconciling the Figma design.
  /// They use a neutral color instead of gray for disabled state,
  /// when widgets cannot be interacted with.
  static final RadixButtonThemeData kFigmaLight = RadixButtonThemeData(
    solid: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.solid,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kLight.accent.scale_10,
        WidgetState.pressed: RadixColorScheme.kLight.accent.scale_10,
        WidgetState.disabled: RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.scale_9,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.contrast!,
      }),
      filter: WidgetStateProperty.fromMap({
        WidgetState.pressed: CSSFilterMatrix().brightness(1.08),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kFigma,
    ),
    soft: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.soft,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kLight.accent.radixScale_4.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kLight.accent.radixScale_5.alphaVariant,
        WidgetState.disabled: RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.radixScale_11.alphaVariant,
      }),
      sizeSwatch: RadixButtonSizeSwatch.kFigma,
    ),
    surface: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.surface,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.pressed: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
        WidgetState.disabled: RadixColorScheme.kLight.neutral.radixScale_2.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.surface!,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.radixScale_11.alphaVariant,
      }),
      shapeBorder: WidgetStateProperty.fromMap({
        WidgetState.hovered: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.pressed: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.disabled: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.neutral.radixScale_6.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.any: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.accent.radixScale_7.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kFigma,
    ),
    outline: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.outline,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kLight.accent.radixScale_2.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
        WidgetState.any: RadixColors.transparent,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.radixScale_11.alphaVariant,
      }),
      shapeBorder: WidgetStateProperty.fromMap({
        WidgetState.disabled: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.neutral.radixScale_7.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.any: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kLight.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kFigma,
    ),
    ghost: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.ghost,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kLight.accent.radixScale_4.alphaVariant,
        WidgetState.disabled: RadixColors.transparent,
        WidgetState.any: RadixColors.transparent,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kLight.accent.radixScale_11.alphaVariant,
      }),
      sizeSwatch: RadixButtonSizeSwatch.kFigma,
    ),
  );

  static final RadixButtonThemeData kDark = RadixButtonThemeData(
    solid: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.solid,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kDark.accent.scale_10,
        WidgetState.pressed: RadixColorScheme.kDark.accent.scale_10,
        WidgetState.disabled: RadixColorScheme.kDark.gray.radixScale_3.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.scale_9,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kDark.gray.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.contrast!,
      }),
      filter: WidgetStateProperty.fromMap({
        WidgetState.pressed: CSSFilterMatrix().brightness(1.08),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kChrome,
    ),
    soft: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.soft,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kDark.accent.radixScale_4.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kDark.accent.radixScale_5.alphaVariant,
        WidgetState.disabled: RadixColorScheme.kDark.gray.radixScale_3.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kDark.gray.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.radixScale_11.alphaVariant,
      }),
      sizeSwatch: RadixButtonSizeSwatch.kChrome,
    ),
    surface: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.surface,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.pressed: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
        WidgetState.disabled: RadixColorScheme.kDark.gray.radixScale_2.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.surface!,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kDark.gray.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.radixScale_11.alphaVariant,
      }),
      shapeBorder: WidgetStateProperty.fromMap({
        WidgetState.hovered: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.pressed: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.disabled: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.gray.radixScale_6.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.any: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.accent.radixScale_7.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kChrome,
    ),
    outline: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.outline,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kDark.accent.radixScale_2.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
        WidgetState.any: RadixColors.transparent,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kDark.gray.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.radixScale_11.alphaVariant,
      }),
      shapeBorder: WidgetStateProperty.fromMap({
        WidgetState.disabled: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.gray.radixScale_7.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.any: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kChrome,
    ),
    ghost: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.ghost,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kDark.accent.radixScale_4.alphaVariant,
        WidgetState.disabled: RadixColors.transparent,
        WidgetState.any: RadixColors.transparent,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kDark.gray.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.radixScale_11.alphaVariant,
      }),
      sizeSwatch: RadixButtonSizeSwatch.kGhost,
    ),
  );

  /// The visual styles are derived by reconciling the Figma design.
  /// They use a neutral color instead of gray for disabled state,
  /// when widgets cannot be interacted with.
  static final RadixButtonThemeData kFigmaDark = RadixButtonThemeData(
    solid: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.solid,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kDark.accent.scale_10,
        WidgetState.pressed: RadixColorScheme.kDark.accent.scale_10,
        WidgetState.disabled: RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.scale_9,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.contrast!,
      }),
      filter: WidgetStateProperty.fromMap({
        WidgetState.pressed: CSSFilterMatrix().brightness(1.08),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kFigma,
    ),
    soft: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.soft,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kDark.accent.radixScale_4.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kDark.accent.radixScale_5.alphaVariant,
        WidgetState.disabled: RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.radixScale_11.alphaVariant,
      }),
      sizeSwatch: RadixButtonSizeSwatch.kFigma,
    ),
    surface: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.surface,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.pressed: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
        WidgetState.disabled: RadixColorScheme.kDark.neutral.radixScale_2.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.surface!,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.radixScale_11.alphaVariant,
      }),
      shapeBorder: WidgetStateProperty.fromMap({
        WidgetState.hovered: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.pressed: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.disabled: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.neutral.radixScale_6.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.any: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.accent.radixScale_7.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kFigma,
    ),
    outline: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.outline,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kDark.accent.radixScale_2.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
        WidgetState.any: RadixColors.transparent,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.radixScale_11.alphaVariant,
      }),
      shapeBorder: WidgetStateProperty.fromMap({
        WidgetState.disabled: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.neutral.radixScale_7.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        WidgetState.any: BoxBorder.fromBorderSide(
          BorderSide(
            width: 1.0,
            color: RadixColorScheme.kDark.accent.radixScale_8.alphaVariant,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      }),
      sizeSwatch: RadixButtonSizeSwatch.kFigma,
    ),
    ghost: RadixButtonVariantStyle.from(
      debugVariant: RadixButtonVariant.ghost,
      backgroundColor: WidgetStateColor.fromMap({
        WidgetState.hovered: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
        WidgetState.pressed: RadixColorScheme.kDark.accent.radixScale_4.alphaVariant,
        WidgetState.disabled: RadixColors.transparent,
        WidgetState.any: RadixColors.transparent,
      }),
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
        WidgetState.any: RadixColorScheme.kDark.accent.radixScale_11.alphaVariant,
      }),
      sizeSwatch: RadixButtonSizeSwatch.kFigma,
    ),
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return super == other &&
           other is RadixButtonThemeData &&
           other.solid == solid &&
           other.soft == soft &&
           other.surface == surface &&
           other.outline == outline &&
           other.ghost == ghost;
  }

  @override
  int get hashCode => Object.hash(runtimeType, solid, soft, surface, outline, ghost);

  /// Linearly interpolate between two [RadixButtonThemeData]s.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixButtonThemeData? lerp(RadixButtonThemeData? a, RadixButtonThemeData? b, double t) {
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

    return RadixButtonThemeData(
      solid: RadixButtonVariantStyle.lerp(a!.solid, b!.solid, t),
      soft: RadixButtonVariantStyle.lerp(a.soft, b.soft, t),
      surface: RadixButtonVariantStyle.lerp(a.surface, b.surface, t),
      outline: RadixButtonVariantStyle.lerp(a.outline, b.outline, t),
      ghost: RadixButtonVariantStyle.lerp(a.ghost, b.ghost, t),
    );
  }

  /// The [RadixThemeData.buttonTheme] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).buttonTheme`.
  static RadixButtonThemeData? of(BuildContext context) => RadixTheme.of(context).buttonTheme;

  /// The [RadixThemeExtension.buttonTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).buttonTheme`.
  static RadixButtonThemeData? fromTheme(BuildContext context) => RadixTheme.fromTheme(context).buttonTheme;

  /// The [RadixThemeExtension.buttonTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).buttonTheme`.
  static RadixButtonThemeData? extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).buttonTheme;
}

/// To use, subclass [RadixButtonCustomThemeData],
/// define a number of fields (e.g. [Color]s), and implement the [copyWith] and
/// [lerp] methods. The latter will ensure smooth transitions of properties when
/// switching themes.
abstract class RadixButtonCustomThemeData extends ThemeExtension<RadixButtonCustomThemeData> {
  RadixButtonStyle getStyle(RadixButtonVariant variant, RadixButtonSize size);

  RadixButtonStyle getIconButtonStyle(RadixButtonVariant variant, RadixButtonSize size);

  /// The [RadixThemeData.buttonCustomTheme] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).buttonCustomTheme`.
  static RadixButtonCustomThemeData? of(BuildContext context) => RadixTheme.of(context).buttonCustomTheme;

  /// The [RadixThemeExtension.buttonCustomTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).buttonCustomTheme`.
  static RadixButtonCustomThemeData? fromTheme(BuildContext context) => RadixTheme.fromTheme(context).buttonCustomTheme;

  /// The [RadixThemeExtension.buttonCustomTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).buttonCustomTheme`.
  static RadixButtonCustomThemeData? extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).buttonCustomTheme;
}

class RadixButtonStyleFactor {
  RadixButtonStyleFactor({
    required this.padding,
    this.uniformPadding,
    this.height,
    this.uniformDimension,
    required this.textStyle,
    this.textScaleFactor,
    this.textScaler,
    this.gap = 0.0,
    this.borderRadius,
  });

  final EdgeInsets padding;

  /// The padding that is only applied to ghost icon buttons.
  final EdgeInsets? uniformPadding;

  /// The height applied to the button, used for all types 
  /// except buttons that are specifically designed for
  /// use with a single icon (Icon Button).
  final double? height;

  /// The dimension applied to buttons designed specifically for
  /// use with a single icon (Icon Buttons). This property sets a uniform value
  /// for both the button's width and height, ensuring they are equal.
  ///
  /// This dimension is used for most Icon Button variants, except for
  /// the `ghost` variant. The `ghost` variant is sized to fit its icon and
  /// applies the [uniformPadding] property instead.
  ///
  /// See also:
  ///
  ///  * <https://www.radix-ui.com/themes/docs/components/icon-button>
  final double? uniformDimension;

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

  /// Linearly interpolate between two [RadixButtonStyleFactor]s.
  ///
  /// {@macro dart.ui.shadow.lerp}
  RadixButtonStyleFactor lerp(RadixButtonStyleFactor other, double t) {
    return RadixButtonStyleFactor(
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      uniformPadding: EdgeInsets.lerp(uniformPadding, other.uniformPadding, t),
      height: lerpDouble(height, other.height, t),
      uniformDimension: lerpDouble(uniformDimension, other.uniformDimension, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      textScaleFactor: lerpDouble(textScaleFactor, other.textScaleFactor, t),
      textScaler: t < 0.5 ? textScaler : other.textScaler,
      gap: lerpDouble(gap, other.gap, t)!,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t),
    );
  }
}

/// {@tool dartpad}
/// This sample shows how to create each of the Radix button variants with Flutter.
///
/// ** See code in example/lib/button_style/button_style.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This sample shows how to create each of the Radix icon button variants with Flutter.
///
/// ** See code in example/lib/button_style/button_style.1.dart **
/// {@end-tool}
class RadixButtonStyleModifier {
  RadixButtonStyleModifier({
    this.backgroundColor,
    this.padding,
    this.height,
    this.textStyle,
    this.textColor,
    this.textScaleFactor,
    this.textScaler,
    this.gap,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.shape,
    this.shapeBorder,
    this.filter,
  }) : assert(border == null || shapeBorder == null),
       assert(borderRadius == null || shapeBorder == null),
       assert(
         shape != BoxShape.circle || borderRadius == null,
         'A circle cannot have a border radius. Remove either the shape or the borderRadius argument.',
       );

  final WidgetStateProperty<Color?>? backgroundColor;

  final EdgeInsets? padding;

  final double? height;

  final TextStyle? textStyle;

  final WidgetStateProperty<Color?>? textColor;

  @Deprecated(
    'Use textScaler instead. '
    'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
    'This feature was deprecated after v3.12.0-2.0.pre.',
  )
  final double? textScaleFactor;

  final TextScaler? textScaler;

  final double? gap;

  final WidgetStateProperty<BoxBorder>? border;

  final BorderRadiusGeometry? borderRadius;

  final List<BoxShadow>? boxShadow;

  final BoxShape? shape;

  final ShapeBorder? shapeBorder;

  final WidgetStateProperty<CSSFilterMatrix?>? filter;
}

class RadixButtonStyle extends RadixButtonStyleFactor {
  RadixButtonStyle({
    this.debugVariant,
    this.debugSize,
    required this.backgroundColor,
    required super.padding,
    required super.uniformPadding,
    required super.height,
    required super.uniformDimension,
    required super.textStyle,
    required this.textColor,
    super.textScaleFactor,
    super.textScaler,
    super.gap,
    this.shapeBorder,
    super.borderRadius,
    this.boxShadow,
    this.shape,
    this.filter,
  });

  final RadixButtonVariant? debugVariant;
  final RadixButtonSize? debugSize;

  final WidgetStateColor backgroundColor;

  final WidgetStateColor textColor;

  final WidgetStateProperty<ShapeBorder?>? shapeBorder;

  final List<BoxShadow>? boxShadow;

  final BoxShape? shape;

  final WidgetStateProperty<CSSFilterMatrix?>? filter;

  factory RadixButtonStyle.from(
    RadixButtonVariantStyle variantStyle,
    RadixButtonSize size,
  ) {
    final RadixButtonStyleFactor factor = variantStyle[size];

    return RadixButtonStyle(
      debugVariant: variantStyle.debugVariant,
      debugSize: size,
      backgroundColor: variantStyle.backgroundColor,
      padding: factor.padding,
      uniformPadding: factor.uniformPadding,
      height: factor.height,
      uniformDimension: factor.uniformDimension,
      textStyle: factor.textStyle,
      textColor: variantStyle.textColor,
      textScaleFactor: factor.textScaleFactor,
      textScaler: factor.textScaler,
      gap: factor.gap,
      shapeBorder: variantStyle.shapeBorder,
      borderRadius: factor.borderRadius,
      boxShadow: variantStyle.boxShadow,
      shape: BoxShape.rectangle,
      filter: variantStyle.filter,
    );
  }
}

enum RadixButtonSize {
  $1, $2, $3, $4
}

/// Radix uses inner shadow for classic variant,
/// but Flutter doesn't support inner shadow, so the classic variant
/// isn't defined.
enum RadixButtonVariant {
  solid, soft, surface, outline, ghost
}

abstract class RadixButton extends StatefulWidget {
  const RadixButton({
    super.key,
    this.width,
    this.text,
    this.size = RadixButtonSize.$2,
    this.variant = RadixButtonVariant.solid,
    this.styleModifier,
    this.mainAxisSize = MainAxisSize.min,
    this.iconStart,
    this.iconEnd,
    this.disabled = false,
    this.highContrast = false,
    this.loading = false,
    this.cacheLoadingState = false,
    this.mouseCursor,
    this.focusNode,
    this.onFocusChange,
    this.onTap,
  }) : isIconButton = false,
       centeredAlignment = true,
       _child = null;

  const RadixButton.ghost({
    super.key,
    this.width,
    this.text,
    this.size = RadixButtonSize.$2,
    this.styleModifier,
    this.mainAxisSize = MainAxisSize.min,
    this.iconStart,
    this.iconEnd,
    this.disabled = false,
    this.highContrast = false,
    this.loading = false,
    this.cacheLoadingState = false,
    this.mouseCursor,
    this.focusNode,
    this.onFocusChange,
    this.onTap,
  })  : variant = RadixButtonVariant.ghost,
        isIconButton = false,
        centeredAlignment = true,
        _child = null;

  const RadixButton.min({
    super.key,
    this.text,
    this.size = RadixButtonSize.$2,
    this.variant = RadixButtonVariant.solid,
    this.styleModifier,
    this.iconStart,
    this.iconEnd,
    this.disabled = false,
    this.highContrast = false,
    this.loading = false,
    this.cacheLoadingState = false,
    this.mouseCursor,
    this.focusNode,
    this.onFocusChange,
    this.onTap,
  })  : mainAxisSize = MainAxisSize.min,
        width = null,
        isIconButton = false,
        centeredAlignment = true,
        _child = null;

  const RadixButton.icon({
    super.key,
    double? dimension,
    required Widget icon,
    this.size = RadixButtonSize.$2,
    this.variant = RadixButtonVariant.solid,
    this.styleModifier,
    this.disabled = false,
    this.highContrast = false,
    this.loading = false,
    this.cacheLoadingState = false,
    this.mouseCursor,
    this.focusNode,
    this.onFocusChange,
    this.onTap,
  })  : mainAxisSize = MainAxisSize.min,
        width = dimension,
        text = '',
        iconStart = null,
        iconEnd = null,
        isIconButton = true,
        centeredAlignment = true,
        _child = icon;

  const RadixButton.custom({
    super.key,
    this.width,
    required Widget child,
    this.size = RadixButtonSize.$2,
    this.variant = RadixButtonVariant.solid,
    this.centeredAlignment = true,
    this.styleModifier,
    this.disabled = false,
    this.highContrast = false,
    this.loading = false,
    this.cacheLoadingState = false,
    this.mouseCursor,
    this.focusNode,
    this.onFocusChange,
    this.onTap,
  })  : mainAxisSize = MainAxisSize.min,
        text = '',
        iconStart = null,
        iconEnd = null,
        isIconButton = false,
        _child = child;

  final double? width;

  final RadixButtonSize size;

  final RadixButtonVariant variant;

  final RadixButtonStyleModifier? styleModifier;

  final String? text;

  final MainAxisSize mainAxisSize;

  final bool highContrast;

  /// Whether to display a loading spinner in place of the button content.
  ///
  /// If [loading] is true, a [RadixSpinner] will be displayed 
  /// centered within the button. The button's size will be preserved to match
  /// its normal, non-loading state to prevent layout shift.
  ///
  /// Defaults to false.
  final bool loading;

  /// This property is a performance optimization designed for cases where the 
  /// button's [loading] state is frequently toggled. It preserves the state of 
  /// the child subtree, preventing unnecessary widget disposal and recreation 
  /// when switching between the loading spinner and the content.
  ///
  /// Defaults to false.
  final bool cacheLoadingState;

  final Widget? iconStart;

  final Widget? iconEnd;

  final bool isIconButton;

  final bool centeredAlignment;

  final Widget? _child;

  final bool disabled;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  ///
  /// If [mouseCursor] is a [WidgetStateMouseCursor],
  /// [WidgetStateProperty.resolve] is used for the following [WidgetState]:
  ///  * [WidgetState.disabled].
  ///  * [WidgetState.pressed].
  ///  * [WidgetState.focused].
  ///
  /// If null, then [MouseCursor.defer] is used when the button is disabled.
  /// When the button is enabled, [SystemMouseCursors.click] is used on Web
  /// and [MouseCursor.defer] is used on other platforms.
  ///
  /// See also:
  ///
  ///  * [WidgetStateMouseCursor], a [MouseCursor] that implements
  ///    [WidgetStateProperty] which is used in APIs that need to accept
  ///    either a [MouseCursor] or a [WidgetStateProperty].
  final MouseCursor? mouseCursor;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  final VoidCallback? onTap;

  /// Whether the button is enabled or disabled. Buttons are enabled by default. To
  /// disabled a button, set [disabled] to true.
  bool get enabled => disabled == false;

  /// The distance a button needs to be moved after being pressed for its opacity to change.
  ///
  /// The opacity changes when the position moved is this distance away from the button.
  static double tapMoveSlop() {
    return kCupertinoButtonTapMoveSlop;
  }

  @override
  State<RadixButton> createState() => _RadixButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('enabled', value: !disabled, ifFalse: 'disabled'));
  }

  /// Returns null if [enabled] and [disabled] are null.
  /// Otherwise, returns a [WidgetStateProperty] that resolves to [disabled]
  /// when [WidgetState.disabled] is active, and [enabled] otherwise.
  ///
  /// A convenience method for subclasses.
  static WidgetStateProperty<Color?>? defaultColor(Color? enabled, Color? disabled) {
    if ((enabled ?? disabled) == null) {
      return null;
    }
    return WidgetStateProperty<Color?>.fromMap(<WidgetStatesConstraint, Color?>{
      WidgetState.disabled: disabled,
      WidgetState.any: enabled,
    });
  }
}

class _RadixButtonState extends State<RadixButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  void _notifyStatesChange() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(microseconds: 1),
      value: 0.0,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _updateStyle();
  }

  @override
  void didUpdateWidget(RadixButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateStyle();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Tracks if the button is currently held down. 
  /// 
  /// Used to determine the animation target and prevent rescheduling 
  /// an animation if it's already at the target value.
  bool _buttonHeldDown = false;

  bool _tapInProgress = false;
  bool _hovering = false;
  bool _isFocused = false;

  void _handleTapDown(TapDownDetails event) {
    _tapInProgress = true;
    _notifyStatesChange();

    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    // _tapInProgress = false;
    // _notifyStatesChange();

    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
    final RenderBox renderObject = context.findRenderObject()! as RenderBox;
    final Offset localPosition = renderObject.globalToLocal(event.globalPosition);
    if (renderObject.paintBounds.inflate(RadixButton.tapMoveSlop()).contains(localPosition)) {
      _handleTap();
    }
  }

  void _handleTapCancel() {
    // _tapInProgress = false;
    // _notifyStatesChange();
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapMove(TapMoveDetails event) {
    final RenderBox renderObject = context.findRenderObject()! as RenderBox;
    final Offset localPosition = renderObject.globalToLocal(event.globalPosition);
    final bool buttonShouldHeldDown = renderObject.paintBounds
        .inflate(RadixButton.tapMoveSlop())
        .contains(localPosition);
    if (_tapInProgress && buttonShouldHeldDown != _buttonHeldDown) {
      _buttonHeldDown = buttonShouldHeldDown;
      _animate();
    }
  }

  void _handleTap([Intent? _]) {
    if (widget.onTap case final VoidCallback onTap) {
      onTap();
      context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
    }
  }

  void _handleHoverEnter(PointerEnterEvent event) {
    switch (event.kind) {
      case PointerDeviceKind.mouse:
      case PointerDeviceKind.trackpad:
        if (widget.enabled) {
          _hovering = true;
          _notifyStatesChange();
        }
      case PointerDeviceKind.stylus:
      case PointerDeviceKind.invertedStylus:
      case PointerDeviceKind.unknown:
      case PointerDeviceKind.touch:
        break;
    }
  }

  void _handleHoverExit(PointerExitEvent event) {
    switch (event.kind) {
      case PointerDeviceKind.mouse:
      case PointerDeviceKind.trackpad:
        _hovering = false;
        _notifyStatesChange();
      case PointerDeviceKind.stylus:
      case PointerDeviceKind.invertedStylus:
      case PointerDeviceKind.unknown:
      case PointerDeviceKind.touch:
        break;
    }
  }

  void _animate() {
    if (_animationController.isAnimating) {
      return;
    }
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _animationController.animateTo(
      _buttonHeldDown ? 1.0 : 0.0,
    );
    ticker.then<void>((void value) {
      if (mounted) {
        if (wasHeldDown != _buttonHeldDown) {
          _animate();
        } else {
          _tapInProgress = false;
          _notifyStatesChange();
        }
      }
    });
  }

  void _onShowFocusHighlight(bool showHighlight) {
    _isFocused = showHighlight;
    _notifyStatesChange();
  }

  late final Map<Type, Action<Intent>> _actionMap = <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: _handleTap),
    ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(onInvoke: _handleTap),
  };

  late RadixButtonStyle _style;
  bool _isStyleOfIconButton = false;
  late RadixButtonStyleModifier? _styleModifier;

  void _updateStyle() {
    final RadixButtonThemeData? buttonTheme;
    final RadixButtonCustomThemeData? buttonCustomTheme;

    final RadixButtonVariantStyle styleFromTheme;

    final RadixThemeData? radixThemeData = RadixTheme.maybeOf(context);
    if (radixThemeData != null) {
      buttonTheme = radixThemeData.buttonTheme;
      buttonCustomTheme = radixThemeData.buttonCustomTheme;
    } else {
      final ThemeData theme = Theme.of(context);
      buttonTheme = RadixButtonThemeData.extensionFrom(theme);
      buttonCustomTheme = RadixButtonCustomThemeData.extensionFrom(theme);
    }

    final RadixButtonStyle style;

    if (buttonTheme != null) {
      switch (widget.variant) {
        case RadixButtonVariant.solid:
          styleFromTheme = buttonTheme.solid;
        case RadixButtonVariant.soft:
          styleFromTheme = buttonTheme.soft;
        case RadixButtonVariant.surface:
          styleFromTheme = buttonTheme.surface;
        case RadixButtonVariant.outline:
          styleFromTheme = buttonTheme.outline;
        case RadixButtonVariant.ghost:
          styleFromTheme = buttonTheme.ghost;
      }

      style = RadixButtonStyle.from(
        styleFromTheme,
        widget.size,
      );
    } else {
      style = widget.isIconButton
          ? buttonCustomTheme!.getIconButtonStyle(widget.variant, widget.size)
          : buttonCustomTheme!.getStyle(widget.variant, widget.size);
      _isStyleOfIconButton = widget.isIconButton;
    }

    _style = style;
    _styleModifier = widget.styleModifier;
  }

  static IconThemeData _getEffectiveIconThemeData(
    BuildContext context, {
    required bool hasIcon,
    required Color withColor,
  }) {
    if (!hasIcon) {
      return const IconThemeData.fallback();
    }

    final IconTheme? iconTheme = context.dependOnInheritedWidgetOfExactType<IconTheme>();
    return (iconTheme?.data ?? const IconThemeData.fallback()).copyWith(color: withColor);
  }

  Widget decorateChild(
    Widget child,
    RadixButtonStyle style,
    RadixButtonStyleModifier? styleModifier,
    Set<WidgetState> states,
  ) {
    Color effectiveBackgroundColor = style.backgroundColor.resolve(states);

    if (styleModifier?.backgroundColor case final backgroundColor?) {
      final Color? modifiedColor = backgroundColor.resolve(states);

      if (modifiedColor != null) {
        effectiveBackgroundColor = modifiedColor;
      }
    }

    final ShapeBorder? shapeBorder = styleModifier?.shapeBorder ?? styleModifier?.border?.resolve(states) ?? style.shapeBorder?.resolve(states);
    final BoxShape? modifiedShape = styleModifier?.shape;
    final BorderRadiusGeometry? borderRadius =  modifiedShape == BoxShape.circle
        ? null
        : styleModifier?.borderRadius ?? style.borderRadius;
    final BoxShape shape = modifiedShape ?? BoxShape.rectangle;
    final List<BoxShadow>? boxShadow = styleModifier?.boxShadow ?? style.boxShadow;
    final WidgetStateProperty<CSSFilterMatrix?>? filter = styleModifier?.filter ?? style.filter;

    if (shapeBorder != null) {
      final Decoration decoration;

      if (shapeBorder is BoxBorder) {
        decoration = BoxDecoration(
          color: effectiveBackgroundColor,
          border: shapeBorder,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          shape: shape,
        );
      } else {
        decoration = ShapeDecoration(
          color: effectiveBackgroundColor,
          shadows: boxShadow,
          shape: shapeBorder,
        );
      }

      child = DecoratedBox(
        decoration: decoration,
        child: child,
      );
    } else if (borderRadius != null || modifiedShape != null || boxShadow != null) {
      child = DecoratedBox(
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: borderRadius,
          shape: shape,
          boxShadow: boxShadow,
        ),
        child: child,
      );
    } else {
      child = ColoredBox(color: effectiveBackgroundColor, child: child);
    }

    final CSSFilterMatrix? effectiveFilter = filter?.resolve(states);

    if (effectiveFilter == null) return child;

    return CSSFilter.apply(
      value: effectiveFilter,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final RadixButton widget = this.widget;

    final bool enabled = widget.enabled;

    final RadixButtonStyle style = _style;
    final RadixButtonStyleModifier? styleModifier = _styleModifier;

    final Set<WidgetState> states = <WidgetState>{
      if (!enabled) WidgetState.disabled,
      if (_hovering && !_tapInProgress) WidgetState.hovered,
      if (_tapInProgress || _buttonHeldDown) WidgetState.pressed,
      if (_isFocused) WidgetState.focused,
    };

    Widget child;

    final Widget? iconStart = widget.iconStart;
    final Widget? iconEnd = widget.iconEnd;

    final Color textColor = styleModifier?.textColor?.resolve(states) ?? style.textColor.resolve(states);

    final TextStyle textStyle = (styleModifier?.textStyle ?? style.textStyle).copyWith(color: textColor);

    final IconThemeData iconThemeData = _getEffectiveIconThemeData(
      context,
      hasIcon: widget._child != null || iconStart != null || iconEnd != null,
      withColor: textColor,
    );

    if (widget._child case final Widget customChild) {
      child = DefaultTextStyle(
        style: textStyle,
        child: IconTheme(
          data: iconThemeData,
          child: customChild,
        ),
      );
    } else {
      final String? text = widget.text;

      if (text != null && text.isNotEmpty) {
        child = Text(text, style: textStyle);
      } else if (widget.loading) {
        // The ghost button's height collapses when the loading spinner replaces the text.
        // To match the button's non-loading state, we use an empty Text widget in the Stack.
        child = Text('', style: textStyle);
      } else {
        child = const SizedBox.shrink();
      }
    }

    if (widget.cacheLoadingState || widget.loading) {
      final RadixSpinnerSize spinnerSize = switch (widget.size) {
        RadixButtonSize.$1                       => RadixSpinnerSize.$1,
        RadixButtonSize.$2 || RadixButtonSize.$3 => RadixSpinnerSize.$2,
        RadixButtonSize.$4                       => RadixSpinnerSize.$3,
      };

      child = Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Visibility(
            visible: !widget.loading,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: child,
          ),
          Offstage(
            offstage: !widget.loading,
            child: RadixSpinner(size: spinnerSize),
          ),
        ],
      );
    }

    if (iconStart == null && iconEnd == null) {
      if (widget.centeredAlignment) {
        child = Center(
          widthFactor: widget.mainAxisSize == MainAxisSize.min ? 1 : null,
          // The ghost button's height is based on its content.
          // When the button is placed inside a Row and only contains
          // the loading spinner or the text (not both),
          // the Center widget normally expands to the Row's full height.
          // Setting `heightFactor: 1` ensures the Center shrinks to the child's actual size,
          // preventing unintended vertical expansion in the Row.
          heightFactor: 1,
          child: child,
        );
      }
    } else {
      final Widget gap = SizedBox(width: styleModifier?.gap ?? style.gap);

      child = IconTheme(
        data: iconThemeData,
        child: Row(
          mainAxisSize: widget.mainAxisSize,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconStart != null) ...[
              iconStart,
              gap,
            ],
            child,
            if (iconEnd != null) ...[
              gap,
              iconEnd,
            ],
          ],
        ),
      );
    }

    EdgeInsets? padding = styleModifier?.padding;

    if (widget.isIconButton) {
      if (widget.variant == RadixButtonVariant.ghost) {
        padding = style.uniformPadding;

        if (_isStyleOfIconButton) {
          padding ??= style.padding;
        }
      } else {
        // No explicit action is taken
        // The padding falls back to the value provided by the RadixButtonStyleModifier
      }
    } else {
      padding ??= style.padding;
    }

    if (padding != null) {
      child = Padding(
        padding: padding,
        child: child,
      );
    }

    child = decorateChild(child, style, styleModifier, states);

    final DeviceGestureSettings? gestureSettings = MediaQuery.maybeGestureSettingsOf(context);

    final MouseCursor effectiveMouseCursor =
        WidgetStateProperty.resolveAs<MouseCursor?>(widget.mouseCursor, states) ??
        MouseCursor.defer;

    double? width = widget.width;
    double? height;

    if (widget.isIconButton) {
      if (widget.variant != RadixButtonVariant.ghost) {
        if (widget.width case final double width) {
          height = width;
        } else {
          height ??= styleModifier?.height ?? style.uniformDimension;
          width = height;
        }
      // Allows setting the dimension of the Ghost Icon Button.
      // Prefer the dimension from the constructor over the RadixButtonStyleModifier.
      } else if (width != null) {
        height = width;
      } else {
        height ??= styleModifier?.height;
        width = height;
      }
    } else if (widget._child == null) {
      height ??= styleModifier?.height ?? style.height;
    }

    return MouseRegion(
      cursor: effectiveMouseCursor,
      onEnter: _handleHoverEnter,
      onExit: _handleHoverExit,
      child: FocusableActionDetector(
        actions: _actionMap,
        focusNode: widget.focusNode,
        onFocusChange: widget.onFocusChange,
        onShowFocusHighlight: _onShowFocusHighlight,
        enabled: enabled,
        child: RawGestureDetector(
          behavior: HitTestBehavior.opaque,
          gestures: <Type, GestureRecognizerFactory>{
            TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
              () => TapGestureRecognizer(postAcceptSlopTolerance: null),
              (TapGestureRecognizer instance) {
                instance.onTapDown = enabled ? _handleTapDown : null;
                instance.onTapUp = enabled ? _handleTapUp : null;
                instance.onTapCancel = enabled ? _handleTapCancel : null;
                instance.onTapMove = enabled ? _handleTapMove : null;
                instance.gestureSettings = gestureSettings;
              },
            ),
          },
          child: Semantics(
            button: true,
            enabled: enabled,
            child: SizedBox(
              width: width,
              height: height,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// The static [styleFrom] method is a convenient way to create a
/// solid button [RadixButtonStyleModifier] from simple values.
///
/// If [disabled] is true, then the button will be disabled.
///
/// {@tool dartpad}
/// This sample produces an enabled and a disabled RadixSolidButton.
///
/// ** See code in example/lib/button_style/button_style.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how changing the [mainAxisSize] value affects
/// the width of the button when placed within a [Column], and also
/// demonstrates how to change the button's accent color.
///
/// ** See code in example/lib/solid_button/radix_solid_button.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [RadixGhostButton], a button with transparent background.
class RadixSolidButton extends RadixButton {
  const RadixSolidButton({
    super.key,
    super.width,
    super.text,
    super.size = RadixButtonSize.$2,
    super.mainAxisSize = MainAxisSize.min,
    super.styleModifier,
    super.iconStart,
    super.iconEnd,
    super.disabled = false,
    super.highContrast = false,
    super.loading = false,
    super.cacheLoadingState = false,
    super.mouseCursor,
    super.focusNode,
    super.onFocusChange,
    super.onTap,
  }) : super(variant: RadixButtonVariant.solid);

  const RadixSolidButton.icon({
    super.key,
    super.dimension,
    required super.icon,
    super.size = RadixButtonSize.$2,
    super.styleModifier,
    super.disabled = false,
    super.highContrast = false,
    super.loading = false,
    super.cacheLoadingState = false,
    super.mouseCursor,
    super.focusNode,
    super.onFocusChange,
    super.onTap,
  }) : super.icon(variant: RadixButtonVariant.solid);

  /// A static convenience method that constructs a solid button
  /// [RadixButtonStyleModifier] given simple values.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier styleFrom({
    RadixColorsSwatch? graySwatch,
    RadixColorsSwatch? accentColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    assert(accentColorSwatch == null || (backgroundColor == null || disabledBackgroundColor == null));
    assert(accentColorSwatch == null || (textColor == null || disabledTextColor == null));

    return RadixButtonStyleModifier(
      backgroundColor: accentColorSwatch == null || graySwatch == null
          ? RadixButton.defaultColor(backgroundColor, disabledBackgroundColor)
          : WidgetStateProperty.fromMap({
              WidgetState.hovered: accentColorSwatch.scale_10,
              WidgetState.pressed: accentColorSwatch.scale_10,
              WidgetState.disabled: graySwatch.radixScale_3.alphaVariant,
              WidgetState.any: accentColorSwatch.scale_9,
            }),
      padding: padding,
      textStyle: textStyle,
      textColor: accentColorSwatch == null || graySwatch == null
          ? RadixButton.defaultColor(textColor, disabledTextColor)
          : WidgetStateColor.fromMap({
              WidgetState.disabled: graySwatch.radixScale_8.alphaVariant,
              WidgetState.any: accentColorSwatch.contrast!,
            }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }

  /// A static convenience method that constructs a solid button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromAccentColorSwatch({
    RadixColorsSwatch? neutralSwatch,
    RadixColorsSwatch? accentColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    assert(accentColorSwatch == null || (backgroundColor == null || disabledBackgroundColor == null));
    assert(accentColorSwatch == null || (textColor == null || disabledTextColor == null));

    return RadixButtonStyleModifier(
      backgroundColor: accentColorSwatch == null || neutralSwatch == null
          ? RadixButton.defaultColor(backgroundColor, disabledBackgroundColor)
          : WidgetStateProperty.fromMap({
              WidgetState.hovered: accentColorSwatch.scale_10,
              WidgetState.pressed: accentColorSwatch.scale_10,
              WidgetState.disabled: neutralSwatch.radixScale_3.alphaVariant,
              WidgetState.any: accentColorSwatch.scale_9,
            }),
      padding: padding,
      textStyle: textStyle,
      textColor: accentColorSwatch == null || neutralSwatch == null
          ? RadixButton.defaultColor(textColor, disabledTextColor)
          : WidgetStateColor.fromMap({
              WidgetState.disabled: neutralSwatch.radixScale_8.alphaVariant,
              WidgetState.any: accentColorSwatch.contrast!,
            }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromNeutralColorSwatch({
    required RadixColorsSwatch neutralColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    return RadixButtonStyleModifier(
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.hovered: neutralColorSwatch.scale_10,
        WidgetState.pressed: neutralColorSwatch.scale_10,
        WidgetState.disabled: disabledBackgroundColor ?? neutralColorSwatch.radixScale_3.alphaVariant,
        WidgetState.any: backgroundColor ?? neutralColorSwatch.scale_9,
      }),
      padding: padding,
      textStyle: textStyle,
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: disabledTextColor ?? neutralColorSwatch.radixScale_8.alphaVariant,
        WidgetState.any: textColor ?? RadixColors.white,
      }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromErrorColorSwatch({
    required RadixColorsSwatch errorColorSwatch,
    required RadixColorsSwatch neutralSwatch,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    return RadixButtonStyleModifier(
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.hovered: errorColorSwatch.radixScale_10.alphaVariant,
        WidgetState.pressed: errorColorSwatch.radixScale_10.alphaVariant,
        WidgetState.disabled: neutralSwatch.radixScale_3.alphaVariant,
        WidgetState.any: errorColorSwatch.radixScale_9.alphaVariant,
      }),
      padding: padding,
      textStyle: textStyle,
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: neutralSwatch.radixScale_8.alphaVariant,
        WidgetState.any: RadixColors.white,
      }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }
}

/// The static [styleFrom] method is a convenient way to create a
/// soft button [RadixButtonStyleModifier] from simple values.
///
/// If [disabled] is true, then the button will be disabled.
///
/// {@tool dartpad}
/// This sample produces an enabled and a disabled RadixSoftButton.
///
/// ** See code in example/lib/button_style/button_style.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how changing the [mainAxisSize] value affects
/// the width of the button when placed within a [Column], and also
/// demonstrates how to change the button's accent color.
///
/// ** See code in example/lib/soft_button/radix_soft_button.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [RadixGhostButton], a button with transparent background.
class RadixSoftButton extends RadixButton {
  const RadixSoftButton({
    super.key,
    super.width,
    super.text,
    super.size = RadixButtonSize.$2,
    super.mainAxisSize = MainAxisSize.min,
    super.styleModifier,
    super.iconStart,
    super.iconEnd,
    super.disabled = false,
    super.highContrast = false,
    super.loading = false,
    super.cacheLoadingState = false,
    super.mouseCursor,
    super.focusNode,
    super.onFocusChange,
    super.onTap,
  }) : super(variant: RadixButtonVariant.soft);

  const RadixSoftButton.icon({
    super.key,
    super.dimension,
    required super.icon,
    super.size = RadixButtonSize.$2,
    super.styleModifier,
    super.disabled = false,
    super.highContrast = false,
    super.loading = false,
    super.cacheLoadingState = false,
    super.mouseCursor,
    super.focusNode,
    super.onFocusChange,
    super.onTap,
  }) : super.icon(variant: RadixButtonVariant.soft);

  /// A static convenience method that constructs a soft button
  /// [RadixButtonStyleModifier] given simple values.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier styleFrom({
    RadixColorsSwatch? graySwatch,
    RadixColorsSwatch? accentColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    assert(accentColorSwatch == null || (backgroundColor == null || disabledBackgroundColor == null));
    assert(accentColorSwatch == null || (textColor == null || disabledTextColor == null));

    return RadixButtonStyleModifier(
      backgroundColor: accentColorSwatch == null || graySwatch == null
          ? RadixButton.defaultColor(backgroundColor, disabledBackgroundColor)
          : WidgetStateProperty.fromMap({
              WidgetState.hovered: accentColorSwatch.radixScale_4.alphaVariant,
              WidgetState.pressed: accentColorSwatch.radixScale_5.alphaVariant,
              WidgetState.disabled: graySwatch.radixScale_3.alphaVariant,
              WidgetState.any: accentColorSwatch.radixScale_3.alphaVariant,
            }),
      padding: padding,
      textStyle: textStyle,
      textColor: accentColorSwatch == null || graySwatch == null
          ? RadixButton.defaultColor(textColor, disabledTextColor)
          : WidgetStateColor.fromMap({
              WidgetState.disabled: graySwatch.radixScale_8.alphaVariant,
              WidgetState.any: accentColorSwatch.scale_11,
            }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }

  /// A static convenience method that constructs a soft button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromAccentColorSwatch({
    RadixColorsSwatch? neutralSwatch,
    RadixColorsSwatch? accentColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    assert(accentColorSwatch == null || (backgroundColor == null || disabledBackgroundColor == null));
    assert(accentColorSwatch == null || (textColor == null || disabledTextColor == null));

    return RadixButtonStyleModifier(
      backgroundColor: accentColorSwatch == null || neutralSwatch == null
          ? RadixButton.defaultColor(backgroundColor, disabledBackgroundColor)
          : WidgetStateProperty.fromMap({
              WidgetState.hovered: accentColorSwatch.radixScale_4.alphaVariant,
              WidgetState.pressed: accentColorSwatch.radixScale_5.alphaVariant,
              WidgetState.disabled: neutralSwatch.radixScale_3.alphaVariant,
              WidgetState.any: accentColorSwatch.radixScale_3.alphaVariant,
            }),
      padding: padding,
      textStyle: textStyle,
      textColor: accentColorSwatch == null || neutralSwatch == null
          ? RadixButton.defaultColor(textColor, disabledTextColor)
          : WidgetStateColor.fromMap({
              WidgetState.disabled: neutralSwatch.radixScale_3.alphaVariant,
              WidgetState.any: accentColorSwatch.radixScale_11.alphaVariant,
            }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromNeutralColorSwatch({
    required RadixColorsSwatch neutralColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    return RadixButtonStyleModifier(
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.hovered: neutralColorSwatch.radixScale_4.alphaVariant,
        WidgetState.pressed: neutralColorSwatch.radixScale_5.alphaVariant,
        WidgetState.disabled: disabledBackgroundColor ?? neutralColorSwatch.radixScale_3.alphaVariant,
        WidgetState.any: backgroundColor ?? neutralColorSwatch.radixScale_3.alphaVariant,
      }),
      padding: padding,
      textStyle: textStyle,
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: disabledTextColor ?? neutralColorSwatch.radixScale_3.alphaVariant,
        WidgetState.any: textColor ?? neutralColorSwatch.scale_11,
      }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromErrorColorSwatch({
    required RadixColorsSwatch errorColorSwatch,
    required RadixColorsSwatch neutralSwatch,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    return RadixButtonStyleModifier(
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.hovered: errorColorSwatch.radixScale_4.alphaVariant,
        WidgetState.pressed: errorColorSwatch.radixScale_5.alphaVariant,
        WidgetState.disabled: neutralSwatch.radixScale_3.alphaVariant,
        WidgetState.any: errorColorSwatch.radixScale_3.alphaVariant,
      }),
      padding: padding,
      textStyle: textStyle,
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: neutralSwatch.radixScale_3.alphaVariant,
        WidgetState.any: errorColorSwatch.scale_11,
      }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }
}

/// The static [styleFrom] method is a convenient way to create a
/// surface button [RadixButtonStyleModifier] from simple values.
///
/// If [disabled] is true, then the button will be disabled.
///
/// {@tool dartpad}
/// This sample produces an enabled and a disabled RadixSurfaceButton.
///
/// ** See code in example/lib/button_style/button_style.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how changing the [mainAxisSize] value affects
/// the width of the button when placed within a [Column], and also
/// demonstrates how to change the button's accent color.
///
/// ** See code in example/lib/surface_button/radix_surface_button.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [RadixGhostButton], a button with transparent background.
class RadixSurfaceButton extends RadixButton {
  const RadixSurfaceButton({
    super.key,
    super.width,
    super.text,
    super.size = RadixButtonSize.$2,
    super.mainAxisSize = MainAxisSize.min,
    super.styleModifier,
    super.iconStart,
    super.iconEnd,
    super.disabled = false,
    super.highContrast = false,
    super.loading = false,
    super.cacheLoadingState = false,
    super.mouseCursor,
    super.focusNode,
    super.onFocusChange,
    super.onTap,
  }) : super(variant: RadixButtonVariant.surface);

  const RadixSurfaceButton.icon({
    super.key,
    super.dimension,
    required super.icon,
    super.size = RadixButtonSize.$2,
    super.styleModifier,
    super.disabled = false,
    super.highContrast = false,
    super.loading = false,
    super.cacheLoadingState = false,
    super.mouseCursor,
    super.focusNode,
    super.onFocusChange,
    super.onTap,
  }) : super.icon(variant: RadixButtonVariant.surface);

  /// A static convenience method that constructs a surface button
  /// [RadixButtonStyleModifier] given simple values.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier styleFrom({
    RadixColorsSwatch? graySwatch,
    RadixColorsSwatch? accentColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderSide? side,
    BorderRadiusGeometry? borderRadius,
    ShapeBorder? shapeBorder,
  }) {
    assert(accentColorSwatch == null || (backgroundColor == null || disabledBackgroundColor == null));
    assert(accentColorSwatch == null || (textColor == null || disabledTextColor == null));

    assert(side == null || shapeBorder == null);
    assert(borderRadius == null || shapeBorder == null);

    return RadixButtonStyleModifier(
      backgroundColor: accentColorSwatch == null || graySwatch == null
          ? RadixButton.defaultColor(backgroundColor, disabledBackgroundColor)
          : WidgetStateProperty.fromMap({
              WidgetState.pressed: accentColorSwatch.radixScale_3.alphaVariant,
              WidgetState.disabled: graySwatch.radixScale_2.alphaVariant,
              WidgetState.any: accentColorSwatch.surface!,
            }),
      padding: padding,
      textStyle: textStyle,
      textColor: accentColorSwatch == null || graySwatch == null
          ? RadixButton.defaultColor(textColor, disabledTextColor)
          : WidgetStateColor.fromMap({
              WidgetState.disabled: graySwatch.radixScale_8.alphaVariant,
              WidgetState.any: accentColorSwatch.radixScale_11.alphaVariant,
            }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      border: side == null
          ? shapeBorder != null
              ? null
              : accentColorSwatch == null || graySwatch == null
                  ? null
                  : WidgetStateProperty.fromMap({
                      WidgetState.hovered: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      WidgetState.pressed: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      WidgetState.disabled: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: graySwatch.radixScale_6.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      WidgetState.any: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: accentColorSwatch.radixScale_7.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                    })
          : shapeBorder != null
              ? null
              : accentColorSwatch == null || graySwatch == null
                  ? WidgetStatePropertyAll(BoxBorder.fromBorderSide(side))
                  : WidgetStateProperty.fromMap({
                      WidgetState.hovered: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                        ),
                      ),
                      WidgetState.pressed: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                        ),
                      ),
                      WidgetState.disabled: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: graySwatch.radixScale_6.alphaVariant,
                        ),
                      ),
                      WidgetState.any: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: accentColorSwatch.radixScale_7.alphaVariant,
                        ),
                      ),
                    }),
      borderRadius: borderRadius,
      shapeBorder: shapeBorder,
    );
  }

  /// A static convenience method that constructs a surface button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromAccentColorSwatch({
    RadixColorsSwatch? neutralSwatch,
    RadixColorsSwatch? accentColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderSide? side,
    BorderRadiusGeometry? borderRadius,
    ShapeBorder? shapeBorder,
  }) {
    assert(accentColorSwatch == null || (backgroundColor == null || disabledBackgroundColor == null));
    assert(accentColorSwatch == null || (textColor == null || disabledTextColor == null));

    assert(side == null || shapeBorder == null);
    assert(borderRadius == null || shapeBorder == null);

    return RadixButtonStyleModifier(
      backgroundColor: accentColorSwatch == null || neutralSwatch == null
          ? RadixButton.defaultColor(backgroundColor, disabledBackgroundColor)
          : WidgetStateProperty.fromMap({
              WidgetState.pressed: accentColorSwatch.radixScale_3.alphaVariant,
              WidgetState.disabled: neutralSwatch.radixScale_2.alphaVariant,
              WidgetState.any: accentColorSwatch.surface!,
            }),
      padding: padding,
      textStyle: textStyle,
      textColor: accentColorSwatch == null || neutralSwatch == null
          ? RadixButton.defaultColor(textColor, disabledTextColor)
          : WidgetStateColor.fromMap({
              WidgetState.disabled: neutralSwatch.radixScale_8.alphaVariant,
              WidgetState.any: accentColorSwatch.radixScale_11.alphaVariant,
            }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      border: side == null
          ? shapeBorder != null
              ? null
              : accentColorSwatch == null || neutralSwatch == null
                  ? null
                  : WidgetStateProperty.fromMap({
                      WidgetState.hovered: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      WidgetState.pressed: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      WidgetState.disabled: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: neutralSwatch.radixScale_6.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      WidgetState.any: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: accentColorSwatch.radixScale_7.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                    })
          : shapeBorder != null
              ? null
              : accentColorSwatch == null || neutralSwatch == null
                  ? WidgetStatePropertyAll(BoxBorder.fromBorderSide(side))
                  : WidgetStateProperty.fromMap({
                      WidgetState.hovered: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                        ),
                      ),
                      WidgetState.pressed: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                        ),
                      ),
                      WidgetState.disabled: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: neutralSwatch.radixScale_6.alphaVariant,
                        ),
                      ),
                      WidgetState.any: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: accentColorSwatch.radixScale_7.alphaVariant,
                        ),
                      ),
                    }),
      borderRadius: borderRadius,
      shapeBorder: shapeBorder,
    );
  }

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromNeutralColorSwatch({
    required RadixColorsSwatch neutralColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderSide? side,
    BorderRadiusGeometry? borderRadius,
    ShapeBorder? shapeBorder,
  }) {
    assert(side == null || shapeBorder == null);
    assert(borderRadius == null || shapeBorder == null);

    return RadixButtonStyleModifier(
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.pressed: neutralColorSwatch.radixScale_3.alphaVariant,
        WidgetState.disabled: disabledBackgroundColor ?? neutralColorSwatch.radixScale_2.alphaVariant,
        WidgetState.any: backgroundColor ?? RadixColors.transparent,
      }),
      padding: padding,
      textStyle: textStyle,
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: disabledTextColor ?? neutralColorSwatch.radixScale_8.alphaVariant,
        WidgetState.any: textColor ?? neutralColorSwatch.scale_11,
      }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      border: side == null
          ? shapeBorder != null
              ? null
              : WidgetStateProperty.fromMap({
                  WidgetState.hovered: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: neutralColorSwatch.radixScale_8.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  WidgetState.pressed: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: neutralColorSwatch.radixScale_8.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  WidgetState.disabled: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: neutralColorSwatch.radixScale_6.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  WidgetState.any: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: neutralColorSwatch.radixScale_7.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                })
          : shapeBorder != null
              ? null
              : WidgetStateProperty.fromMap({
                  WidgetState.hovered: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: neutralColorSwatch.radixScale_8.alphaVariant,
                    ),
                  ),
                  WidgetState.pressed: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: neutralColorSwatch.radixScale_8.alphaVariant,
                    ),
                  ),
                  WidgetState.disabled: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: neutralColorSwatch.radixScale_6.alphaVariant,
                    ),
                  ),
                  WidgetState.any: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: neutralColorSwatch.radixScale_7.alphaVariant,
                    ),
                  ),
                }),
      borderRadius: borderRadius,
      shapeBorder: shapeBorder,
    );
  }

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromErrorColorSwatch({
    required RadixColorsSwatch errorColorSwatch,
    required RadixColorsSwatch neutralSwatch,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderSide? side,
    BorderRadiusGeometry? borderRadius,
    ShapeBorder? shapeBorder,
  }) {
    return RadixButtonStyleModifier(
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.pressed: errorColorSwatch.radixScale_3.alphaVariant,
        WidgetState.disabled: neutralSwatch.radixScale_2.alphaVariant,
        WidgetState.any: RadixColors.transparent,
      }),
      padding: padding,
      textStyle: textStyle,
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: neutralSwatch.radixScale_8.alphaVariant,
        WidgetState.any: errorColorSwatch.scale_11,
      }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      border: side == null
          ? shapeBorder != null
              ? null
              : WidgetStateProperty.fromMap({
                  WidgetState.hovered: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: errorColorSwatch.radixScale_8.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  WidgetState.pressed: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: errorColorSwatch.radixScale_8.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  WidgetState.disabled: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: neutralSwatch.radixScale_6.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  WidgetState.any: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: errorColorSwatch.radixScale_7.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                })
          : shapeBorder != null
              ? null
              : WidgetStateProperty.fromMap({
                  WidgetState.hovered: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: errorColorSwatch.radixScale_8.alphaVariant,
                    ),
                  ),
                  WidgetState.pressed: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: errorColorSwatch.radixScale_8.alphaVariant,
                    ),
                  ),
                  WidgetState.disabled: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: neutralSwatch.radixScale_6.alphaVariant,
                    ),
                  ),
                  WidgetState.any: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: errorColorSwatch.radixScale_7.alphaVariant,
                    ),
                  ),
                }),
      borderRadius: borderRadius,
      shapeBorder: shapeBorder,
    );
  }
}

/// The static [styleFrom] method is a convenient way to create a
/// outline button [RadixButtonStyleModifier] from simple values.
///
/// If [disabled] is true, then the button will be disabled.
///
/// {@tool dartpad}
/// This sample produces an enabled and a disabled RadixOutlineButton.
///
/// ** See code in example/lib/button_style/button_style.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how changing the [mainAxisSize] value affects
/// the width of the button when placed within a [Column], and also
/// demonstrates how to change the button's accent color.
///
/// ** See code in example/lib/outline_button/radix_outline_button.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [RadixGhostButton], a button with transparent background.
class RadixOutlineButton extends RadixButton {
  const RadixOutlineButton({
    super.key,
    super.width,
    super.text,
    super.size = RadixButtonSize.$2,
    super.mainAxisSize = MainAxisSize.min,
    super.styleModifier,
    super.iconStart,
    super.iconEnd,
    super.disabled = false,
    super.highContrast = false,
    super.loading = false,
    super.cacheLoadingState = false,
    super.mouseCursor,
    super.focusNode,
    super.onFocusChange,
    super.onTap,
  }) : super(variant: RadixButtonVariant.outline);

  const RadixOutlineButton.icon({
    super.key,
    super.dimension,
    required super.icon,
    super.size = RadixButtonSize.$2,
    super.styleModifier,
    super.disabled = false,
    super.highContrast = false,
    super.loading = false,
    super.cacheLoadingState = false,
    super.mouseCursor,
    super.focusNode,
    super.onFocusChange,
    super.onTap,
  }) : super.icon(variant: RadixButtonVariant.outline);

  /// A static convenience method that constructs a outline button
  /// [RadixButtonStyleModifier] given simple values.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier styleFrom({
    RadixColorsSwatch? graySwatch,
    RadixColorsSwatch? accentColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderSide? side,
    BorderRadiusGeometry? borderRadius,
    ShapeBorder? shapeBorder,
  }) {
    assert(accentColorSwatch == null || (backgroundColor == null || disabledBackgroundColor == null));
    assert(accentColorSwatch == null || (textColor == null || disabledTextColor == null));

    assert(side == null || shapeBorder == null);
    assert(borderRadius == null || shapeBorder == null);

    return RadixButtonStyleModifier(
      backgroundColor: accentColorSwatch == null || graySwatch == null
          ? RadixButton.defaultColor(backgroundColor, disabledBackgroundColor)
          : WidgetStateColor.fromMap({
              WidgetState.hovered: accentColorSwatch.radixScale_2.alphaVariant,
              WidgetState.pressed: accentColorSwatch.radixScale_3.alphaVariant,
              WidgetState.any: RadixColors.transparent,
            }),
      padding: padding,
      textStyle: textStyle,
      textColor: accentColorSwatch == null || graySwatch == null
          ? RadixButton.defaultColor(textColor, disabledTextColor)
          : WidgetStateColor.fromMap({
              WidgetState.disabled: graySwatch.radixScale_8.alphaVariant,
              WidgetState.any: accentColorSwatch.radixScale_11.alphaVariant,
            }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      border: side == null
          ? shapeBorder != null
              ? null
              : accentColorSwatch == null || graySwatch == null
                  ? null
                  : WidgetStateProperty.fromMap({
                      WidgetState.disabled: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: graySwatch.radixScale_7.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      WidgetState.any: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                    })
          : shapeBorder != null
              ? null
              : accentColorSwatch == null || graySwatch == null
                  ? WidgetStatePropertyAll(BoxBorder.fromBorderSide(side))
                  : WidgetStateProperty.fromMap({
                      WidgetState.disabled: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: graySwatch.radixScale_7.alphaVariant,
                        ),
                      ),
                      WidgetState.any: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                        ),
                      ),
                    }),
      borderRadius: borderRadius,
      shapeBorder: shapeBorder,
    );
  }

  /// A static convenience method that constructs a outline button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromAccentColorSwatch({
    RadixColorsSwatch? neutralSwatch,
    RadixColorsSwatch? accentColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderSide? side,
    BorderRadiusGeometry? borderRadius,
    ShapeBorder? shapeBorder,
  }) {
    assert(accentColorSwatch == null || (backgroundColor == null || disabledBackgroundColor == null));
    assert(accentColorSwatch == null || (textColor == null || disabledTextColor == null));

    assert(side == null || shapeBorder == null);
    assert(borderRadius == null || shapeBorder == null);

    return RadixButtonStyleModifier(
      backgroundColor: accentColorSwatch == null || neutralSwatch == null
          ? RadixButton.defaultColor(backgroundColor, disabledBackgroundColor)
          : WidgetStateColor.fromMap({
              WidgetState.hovered: accentColorSwatch.radixScale_2.alphaVariant,
              WidgetState.pressed: accentColorSwatch.radixScale_3.alphaVariant,
              WidgetState.any: RadixColors.transparent,
            }),
      padding: padding,
      textStyle: textStyle,
      textColor: accentColorSwatch == null || neutralSwatch == null
          ? RadixButton.defaultColor(textColor, disabledTextColor)
          : WidgetStateColor.fromMap({
              WidgetState.disabled: neutralSwatch.radixScale_8.alphaVariant,
              WidgetState.any: accentColorSwatch.radixScale_11.alphaVariant,
            }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      border: side == null
          ? shapeBorder != null
              ? null
              : accentColorSwatch == null || neutralSwatch == null
                  ? null
                  : WidgetStateProperty.fromMap({
                      WidgetState.disabled: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: neutralSwatch.radixScale_7.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      WidgetState.any: BoxBorder.fromBorderSide(
                        BorderSide(
                          width: 1.0,
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                    })
          : shapeBorder != null
              ? null
              : accentColorSwatch == null || neutralSwatch == null
                  ? WidgetStatePropertyAll(BoxBorder.fromBorderSide(side))
                  : WidgetStateProperty.fromMap({
                      WidgetState.disabled: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: neutralSwatch.radixScale_7.alphaVariant,
                        ),
                      ),
                      WidgetState.any: BoxBorder.fromBorderSide(
                        side.copyWith(
                          color: accentColorSwatch.radixScale_8.alphaVariant,
                        ),
                      ),
                    }),
      borderRadius: borderRadius,
      shapeBorder: shapeBorder,
    );
  }

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromNeutralColorSwatch({
    required RadixColorsSwatch neutralColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderSide? side,
    BorderRadiusGeometry? borderRadius,
    ShapeBorder? shapeBorder,
  }) {
    assert(side == null || shapeBorder == null);
    assert(borderRadius == null || shapeBorder == null);

    return RadixButtonStyleModifier(
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.hovered: neutralColorSwatch.radixScale_2.alphaVariant,
        WidgetState.pressed: neutralColorSwatch.radixScale_3.alphaVariant,
        WidgetState.disabled: disabledBackgroundColor ?? RadixColors.transparent,
        WidgetState.any: backgroundColor ?? RadixColors.transparent,
      }),
      padding: padding,
      textStyle: textStyle,
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: disabledTextColor ?? neutralColorSwatch.radixScale_8.alphaVariant,
        WidgetState.any: textColor ?? neutralColorSwatch.scale_11,
      }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      border: side == null
          ? shapeBorder != null
              ? null
              : WidgetStateProperty.fromMap({
                  WidgetState.disabled: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: neutralColorSwatch.radixScale_7.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  WidgetState.any: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: neutralColorSwatch.radixScale_8.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                })
          : shapeBorder != null
              ? null
              : WidgetStateProperty.fromMap({
                  WidgetState.disabled: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: neutralColorSwatch.radixScale_7.alphaVariant,
                    ),
                  ),
                  WidgetState.any: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: neutralColorSwatch.radixScale_8.alphaVariant,
                    ),
                  ),
                }),
      borderRadius: borderRadius,
      shapeBorder: shapeBorder,
    );
  }

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromErrorColorSwatch({
    required RadixColorsSwatch errorColorSwatch,
    required RadixColorsSwatch neutralSwatch,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderSide? side,
    BorderRadiusGeometry? borderRadius,
    ShapeBorder? shapeBorder,
  }) {
    return RadixButtonStyleModifier(
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.hovered: errorColorSwatch.radixScale_2.alphaVariant,
        WidgetState.pressed: errorColorSwatch.radixScale_3.alphaVariant,
        WidgetState.disabled: RadixColors.transparent,
        WidgetState.any: RadixColors.transparent,
      }),
      padding: padding,
      textStyle: textStyle,
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: neutralSwatch.radixScale_8.alphaVariant,
        WidgetState.any: errorColorSwatch.scale_11,
      }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      border: side == null
          ? shapeBorder != null
              ? null
              : WidgetStateProperty.fromMap({
                  WidgetState.disabled: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: neutralSwatch.radixScale_7.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                  WidgetState.any: BoxBorder.fromBorderSide(
                    BorderSide(
                      width: 1.0,
                      color: errorColorSwatch.radixScale_8.alphaVariant,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                })
          : shapeBorder != null
              ? null
              : WidgetStateProperty.fromMap({
                  WidgetState.disabled: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: neutralSwatch.radixScale_7.alphaVariant,
                    ),
                  ),
                  WidgetState.any: BoxBorder.fromBorderSide(
                    side.copyWith(
                      color: errorColorSwatch.radixScale_8.alphaVariant,
                    ),
                  ),
                }),
      borderRadius: borderRadius,
      shapeBorder: shapeBorder,
    );
  }
}

/// The ghost variant displays a button without any visible borders or
/// background ("chrome"). This design makes the button behave like text
/// in layout.
///
/// The static [styleFrom] method is a convenient way to create a
/// ghost button [RadixButtonStyleModifier] from simple values.
///
/// If [disabled] is true, then the button will be disabled.
///
/// {@tool dartpad}
/// This sample produces an enabled and a disabled RadixGhostButton.
///
/// ** See code in example/lib/button_style/button_style.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how changing the [mainAxisSize] value affects
/// the width of the button when placed within a [Column], and also
/// demonstrates how to change the button's accent color.
///
/// ** See code in example/lib/ghost_button/radix_ghost_button.0.dart **
/// {@end-tool}
class RadixGhostButton extends RadixButton {
  const RadixGhostButton({
    super.key,
    super.width,
    super.text,
    super.size = RadixButtonSize.$2,
    super.mainAxisSize = MainAxisSize.min,
    super.styleModifier,
    super.iconStart,
    super.iconEnd,
    super.disabled = false,
    super.highContrast = false,
    super.loading = false,
    super.cacheLoadingState = false,
    super.mouseCursor,
    super.focusNode,
    super.onFocusChange,
    super.onTap,
  }) : super(variant: RadixButtonVariant.ghost);

  const RadixGhostButton.icon({
    super.key,
    super.dimension,
    required super.icon,
    super.size = RadixButtonSize.$2,
    super.styleModifier,
    super.disabled = false,
    super.highContrast = false,
    super.loading = false,
    super.cacheLoadingState = false,
    super.mouseCursor,
    super.focusNode,
    super.onFocusChange,
    super.onTap,
  }) : super.icon(variant: RadixButtonVariant.ghost);

  const RadixGhostButton.custom({
    super.key,
    super.width,
    required super.child,
    super.size = RadixButtonSize.$2,
    super.variant = RadixButtonVariant.ghost,
    super.centeredAlignment,
    super.styleModifier,
    super.disabled = false,
    super.highContrast = false,
    super.loading = false,
    super.cacheLoadingState = false,
    super.mouseCursor,
    super.focusNode,
    super.onFocusChange,
    super.onTap,
  }) : super.custom();

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier styleFrom({
    RadixColorsSwatch? graySwatch,
    RadixColorsSwatch? accentColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    assert(accentColorSwatch == null || (backgroundColor == null || disabledBackgroundColor == null));
    assert(accentColorSwatch == null || (textColor == null || disabledTextColor == null));

    return RadixButtonStyleModifier(
      backgroundColor: accentColorSwatch == null || graySwatch == null
          ? RadixButton.defaultColor(backgroundColor, disabledBackgroundColor)
          : WidgetStateProperty.fromMap({
              WidgetState.hovered: accentColorSwatch.radixScale_3.alphaVariant,
              WidgetState.pressed: accentColorSwatch.radixScale_4.alphaVariant,
              WidgetState.disabled: RadixColors.transparent,
              WidgetState.any: RadixColors.transparent,
            }),
      padding: padding,
      textStyle: textStyle,
      textColor: accentColorSwatch == null || graySwatch == null
          ? RadixButton.defaultColor(textColor, disabledTextColor)
          : WidgetStateColor.fromMap({
              WidgetState.disabled: graySwatch.radixScale_8.alphaVariant,
              WidgetState.any: accentColorSwatch.radixScale_11.alphaVariant,
            }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromAccentColorSwatch({
    RadixColorsSwatch? neutralSwatch,
    RadixColorsSwatch? accentColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    assert(accentColorSwatch == null || (backgroundColor == null || disabledBackgroundColor == null));
    assert(accentColorSwatch == null || (textColor == null || disabledTextColor == null));

    return RadixButtonStyleModifier(
      backgroundColor: accentColorSwatch == null || neutralSwatch == null
          ? RadixButton.defaultColor(backgroundColor, disabledBackgroundColor)
          : WidgetStateProperty.fromMap({
              WidgetState.hovered: accentColorSwatch.radixScale_3.alphaVariant,
              WidgetState.pressed: accentColorSwatch.radixScale_4.alphaVariant,
              WidgetState.disabled: RadixColors.transparent,
              WidgetState.any: RadixColors.transparent,
            }),
      padding: padding,
      textStyle: textStyle,
      textColor: accentColorSwatch == null || neutralSwatch == null
          ? RadixButton.defaultColor(textColor, disabledTextColor)
          : WidgetStateColor.fromMap({
              WidgetState.disabled: neutralSwatch.radixScale_8.alphaVariant,
              WidgetState.any: accentColorSwatch.radixScale_11.alphaVariant,
            }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromNeutralColorSwatch({
    required RadixColorsSwatch neutralColorSwatch,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? textColor,
    Color? disabledTextColor,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    return RadixButtonStyleModifier(
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.hovered: neutralColorSwatch.radixScale_3.alphaVariant,
        WidgetState.pressed: neutralColorSwatch.radixScale_4.alphaVariant,
        WidgetState.disabled: disabledBackgroundColor ?? RadixColors.transparent,
        WidgetState.any: backgroundColor ?? RadixColors.transparent,
      }),
      padding: padding,
      textStyle: textStyle,
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: disabledTextColor ?? neutralColorSwatch.radixScale_8.alphaVariant,
        WidgetState.any: textColor ?? neutralColorSwatch.scale_11,
      }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }

  /// A static convenience method that constructs a ghost button
  /// [RadixButtonStyleModifier] given simple values follow the Figma design.
  ///
  /// All parameters default to null, by default this method returns
  /// a [RadixButtonStyleModifier] that doesn't override anything.
  static RadixButtonStyleModifier figmaStyleFromErrorColorSwatch({
    required RadixColorsSwatch errorColorSwatch,
    required RadixColorsSwatch neutralSwatch,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? textScaleFactor,
    TextScaler? textScaler,
    double? gap,
    BorderRadiusGeometry? borderRadius,
  }) {
    return RadixButtonStyleModifier(
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.hovered: errorColorSwatch.radixScale_3.alphaVariant,
        WidgetState.pressed: errorColorSwatch.radixScale_4.alphaVariant,
        WidgetState.disabled: RadixColors.transparent,
        WidgetState.any: RadixColors.transparent,
      }),
      padding: padding,
      textStyle: textStyle,
      textColor: WidgetStateColor.fromMap({
        WidgetState.disabled: neutralSwatch.radixScale_8.alphaVariant,
        WidgetState.any: errorColorSwatch.scale_11,
      }),
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      gap: gap,
      borderRadius: borderRadius,
    );
  }
}
