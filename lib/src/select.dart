import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'button.dart';
import 'colors.dart';
import 'input_decorator.dart';
import 'radius.dart';
import 'shadow.dart';
import 'space.dart';
import 'text_theme.dart';
import 'theme.dart';
import 'theme_data.dart';

class RadixSelectDecorationVariantFactor {
  RadixSelectDecorationVariantFactor({
    required this.padding,
    this.ghostPadding,
    this.triggerHeight,
    required this.textStyle,
    this.textScaleFactor,
    this.textScaler,
    this.gap = 0.0,
    this.borderRadius,
    required this.iconSize,
    required this.contentPadding,
    required this.contentBorderRadius,
    required this.labelTextStyle,
    required this.itemHeight,
    required this.itemTextStyle,
    required this.itemBorderRadius,
    required this.itemIndicatorWidth,
    required this.itemIndicatorIconSize,
  });

  final EdgeInsets padding;

  /// The padding that is only applied to ghost select variant.
  final EdgeInsets? ghostPadding;

  /// The height applied to the button, used for all types 
  /// except ghost buttons that are specifically designed for
  /// use with a single icon (Icon Button).
  final double? triggerHeight;

  final TextStyle textStyle;

  @Deprecated(
    'Use textScaler instead. '
    'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
    'This feature was deprecated after v3.12.0-2.0.pre.',
  )
  final double? textScaleFactor;

  final TextScaler? textScaler;

  final double gap;

  final BorderRadius? borderRadius;

  final double iconSize;

  final EdgeInsets contentPadding;
  final BorderRadius contentBorderRadius;

  final TextStyle labelTextStyle;

  final double itemHeight;

  final TextStyle itemTextStyle;

  final BorderRadius itemBorderRadius;

  final double itemIndicatorWidth;
  final Size itemIndicatorIconSize;

  /// Linearly interpolate between two [RadixSelectDecorationVariantFactor]s.
  ///
  /// {@macro dart.ui.shadow.lerp}
  RadixSelectDecorationVariantFactor lerp(RadixSelectDecorationVariantFactor other, double t) {
    return RadixSelectDecorationVariantFactor(
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      ghostPadding: EdgeInsets.lerp(ghostPadding, other.ghostPadding, t),
      itemHeight: lerpDouble(itemHeight, other.itemHeight, t)!,
      triggerHeight: lerpDouble(triggerHeight, other.triggerHeight, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      textScaleFactor: lerpDouble(textScaleFactor, other.textScaleFactor, t),
      textScaler: t < 0.5 ? textScaler : other.textScaler,
      gap: lerpDouble(gap, other.gap, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      iconSize: lerpDouble(iconSize, other.iconSize, t)!,
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t)!,
      contentBorderRadius: BorderRadius.lerp(contentBorderRadius, other.contentBorderRadius, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      itemTextStyle: TextStyle.lerp(itemTextStyle, other.itemTextStyle, t)!,
      itemBorderRadius: BorderRadius.lerp(itemBorderRadius, other.itemBorderRadius, t)!,
      itemIndicatorWidth: lerpDouble(itemIndicatorWidth, other.itemIndicatorWidth, t)!,
      itemIndicatorIconSize: Size.lerp(itemIndicatorIconSize, other.itemIndicatorIconSize, t)!,
    );
  }
}

class RadixSelectDecorationVariant {
  RadixSelectDecorationVariant({
    this.debugVariant,
    this.debugSize,
    required this.backgroundColor,
    Color? filledBackgroundColor,
    Color? hoveredBackgroundColor,
    Color? focusedBackgroundColor,
    required this.disabledBackgroundColor,
    Color? readOnlyBackgroundColor,
    required this.textColor,
    required this.disabledTextColor,
    this.readOnlyTextColor,
    required this.hintColor,
    Color? disabledHintColor,
    this.side,
    BorderSide? filledSide,
    BorderSide? hoveredSide,
    this.focusedSide,
    this.disabledSide,
    this.readOnlySide,
    Color? iconColor,
    Color? filledIconColor,
    Color? disabledIconColor,
    Color? readOnlyIconColor,
    required this.hoveredItemBackgroundColor,
  }) : filledBackgroundColor = filledBackgroundColor ?? backgroundColor,
       hoveredBackgroundColor = hoveredBackgroundColor ?? backgroundColor,
       focusedBackgroundColor = focusedBackgroundColor ?? backgroundColor,
       readOnlyBackgroundColor = readOnlyBackgroundColor ?? disabledBackgroundColor,
       disabledHintColor = disabledHintColor ?? disabledTextColor,
       hoveredSide = hoveredSide ?? side,
       filledSide = filledSide ?? side,
       iconColor = iconColor ?? textColor,
       filledIconColor = filledIconColor ?? iconColor ?? textColor,
       disabledIconColor = disabledIconColor ?? disabledTextColor,
       readOnlyIconColor = readOnlyIconColor ?? disabledIconColor ?? readOnlyTextColor ?? disabledTextColor;

  final RadixSelectVariant? debugVariant;
  final RadixSelectSize? debugSize;

  final Color backgroundColor;
  final Color filledBackgroundColor;
  final Color hoveredBackgroundColor;
  final Color focusedBackgroundColor;
  final Color disabledBackgroundColor;
  final Color readOnlyBackgroundColor;
  final Color textColor;
  final Color disabledTextColor;
  final Color? readOnlyTextColor;
  final Color hintColor;
  final Color disabledHintColor;
  final BorderSide? side;

  /// The state of a form field that is not empty.
  final BorderSide? filledSide;

  final BorderSide? hoveredSide;
  final BorderSide? focusedSide;
  final BorderSide? disabledSide;
  final BorderSide? readOnlySide;

  final Color iconColor;
  final Color filledIconColor;
  final Color disabledIconColor;
  final Color readOnlyIconColor;

  final Color hoveredItemBackgroundColor;
}

class RadixSelectDecorationSurfaceVariant extends RadixSelectDecorationVariant {
  RadixSelectDecorationSurfaceVariant({
    super.debugSize,
    required super.backgroundColor,
    super.filledBackgroundColor,
    super.focusedBackgroundColor,
    required super.disabledBackgroundColor,
    super.readOnlyBackgroundColor,
    required super.textColor,
    required super.disabledTextColor,
    super.readOnlyTextColor,
    required super.hintColor,
    super.disabledHintColor,
    super.side,
    super.filledSide,
    super.hoveredSide,
    super.focusedSide,
    super.disabledSide,
    super.readOnlySide,
    super.iconColor,
    super.filledIconColor,
    super.disabledIconColor,
    super.readOnlyIconColor,
    required super.hoveredItemBackgroundColor,
  }) : super(debugVariant: RadixSelectVariant.surface);

  factory RadixSelectDecorationSurfaceVariant.from({
    required RadixColorsSwatch graySwatch,
    required Color surfaceColor,
    required RadixColorsSwatch accentSwatch,
  }) {
    return RadixSelectDecorationSurfaceVariant(
      backgroundColor: surfaceColor,
      disabledBackgroundColor: graySwatch.radixScale_2.alphaVariant,
      textColor: graySwatch.scale_12,
      disabledTextColor: graySwatch.radixScale_11.alphaVariant,
      hintColor: graySwatch.radixScale_10.alphaVariant,
      side: BorderSide(
        width: 1,
        color: graySwatch.radixScale_7.alphaVariant,
      ),
      hoveredSide: BorderSide(
        width: 1,
        color: graySwatch.radixScale_8.alphaVariant,
      ),
      focusedSide: BorderSide(
        width: 1,
        color: graySwatch.radixScale_8.alphaVariant,
      ),
      disabledSide: BorderSide(
        width: 1,
        color: graySwatch.radixScale_6.alphaVariant,
      ),
      iconColor: graySwatch.radixScale_10.alphaVariant,
      filledIconColor: graySwatch.scale_12,
      disabledIconColor: graySwatch.radixScale_9.alphaVariant,
      hoveredItemBackgroundColor: accentSwatch.scale_9,
    );
  }

  factory RadixSelectDecorationSurfaceVariant.figmaDesign({
    required RadixColorsSwatch neutralSwatch,
    required Color surfaceColor,
    required RadixColorsSwatch accentSwatch,
  }) {
    return RadixSelectDecorationSurfaceVariant(
      backgroundColor: surfaceColor,
      focusedBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      disabledBackgroundColor: neutralSwatch.radixScale_2.alphaVariant,
      readOnlyBackgroundColor: neutralSwatch.radixScale_2.alphaVariant,
      textColor: neutralSwatch.scale_12,
      disabledTextColor: neutralSwatch.radixScale_8.alphaVariant,
      readOnlyTextColor: neutralSwatch.radixScale_8.alphaVariant,
      hintColor: neutralSwatch.radixScale_10.alphaVariant,
      disabledHintColor: neutralSwatch.radixScale_8.alphaVariant,
      side: BorderSide(
        width: 1,
        color: neutralSwatch.radixScale_7.alphaVariant,
      ),
      hoveredSide: BorderSide(
        width: 1,
        color: neutralSwatch.radixScale_8.alphaVariant,
      ),
      focusedSide: BorderSide(
        width: 1,
        color: neutralSwatch.radixScale_8.alphaVariant,
      ),
      disabledSide: BorderSide(
        width: 1,
        color: neutralSwatch.radixScale_6.alphaVariant,
      ),
      readOnlySide: BorderSide(
        width: 1,
        color: neutralSwatch.radixScale_6.alphaVariant,
      ),
      iconColor: neutralSwatch.scale_12,
      disabledIconColor: neutralSwatch.radixScale_8.alphaVariant,
      readOnlyIconColor: neutralSwatch.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: accentSwatch.scale_9,
    );
  }
}

class RadixSelectDecorationSoftVariant extends RadixSelectDecorationVariant {
  RadixSelectDecorationSoftVariant({
    super.debugSize,
    required super.backgroundColor,
    super.filledBackgroundColor,
    super.hoveredBackgroundColor,
    super.focusedBackgroundColor,
    required super.disabledBackgroundColor,
    super.readOnlyBackgroundColor,
    required super.textColor,
    required super.disabledTextColor,
    super.readOnlyTextColor,
    required super.hintColor,
    super.disabledHintColor,
    super.side,
    super.filledSide,
    super.hoveredSide,
    super.focusedSide,
    super.disabledSide,
    super.readOnlySide,
    super.iconColor,
    super.filledIconColor,
    super.disabledIconColor,
    super.readOnlyIconColor,
    required super.hoveredItemBackgroundColor,
  }) : super(debugVariant: RadixSelectVariant.soft);

  factory RadixSelectDecorationSoftVariant.from({
    required RadixColorsSwatch graySwatch,
    required RadixColorsSwatch accentColorSwatch,
  }) {
    return RadixSelectDecorationSoftVariant(
      backgroundColor: accentColorSwatch.radixScale_3.alphaVariant,
      hoveredBackgroundColor: accentColorSwatch.radixScale_4.alphaVariant,
      focusedBackgroundColor: accentColorSwatch.radixScale_4.alphaVariant,
      disabledBackgroundColor: graySwatch.radixScale_3.alphaVariant,
      textColor: accentColorSwatch.scale_12,
      disabledTextColor: graySwatch.radixScale_11.alphaVariant,
      hintColor: accentColorSwatch.scale_12.withOpacity(0.6),
      iconColor: accentColorSwatch.scale_12.withOpacity(0.6),
      filledIconColor: RadixColorScheme.kLight.neutral.scale_12,
      disabledIconColor: graySwatch.radixScale_9.alphaVariant,
      hoveredItemBackgroundColor: accentColorSwatch.scale_9,
    );
  }

  factory RadixSelectDecorationSoftVariant.figmaDecorationFromAccentColorSwatch({
    required RadixColorsSwatch neutralSwatch,
    required RadixColorsSwatch accentColorSwatch,
  }) {
    return RadixSelectDecorationSoftVariant(
      backgroundColor: accentColorSwatch.radixScale_3.alphaVariant,
      filledBackgroundColor: accentColorSwatch.radixScale_3.alphaVariant,
      hoveredBackgroundColor: accentColorSwatch.radixScale_4.alphaVariant,
      focusedBackgroundColor: accentColorSwatch.radixScale_5.alphaVariant,
      disabledBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      textColor: accentColorSwatch.scale_12,
      disabledTextColor: neutralSwatch.radixScale_8.alphaVariant,
      hintColor: accentColorSwatch.scale_12.withOpacity(0.5),
      disabledHintColor: neutralSwatch.radixScale_8.alphaVariant,
      iconColor: accentColorSwatch.scale_12,
      filledIconColor: neutralSwatch.scale_12,
      disabledIconColor: neutralSwatch.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: accentColorSwatch.scale_9,
    );
  }

  factory RadixSelectDecorationSoftVariant.figmaDecorationFromNeutralColorSwatch({
    required RadixColorsSwatch neutralSwatch,
    required RadixColorsSwatch accentSwatch,
  }) {
    return RadixSelectDecorationSoftVariant(
      backgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      filledBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      hoveredBackgroundColor: neutralSwatch.radixScale_4.alphaVariant,
      focusedBackgroundColor: neutralSwatch.radixScale_5.alphaVariant,
      disabledBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      textColor: neutralSwatch.scale_12,
      disabledTextColor: neutralSwatch.radixScale_8.alphaVariant,
      hintColor: neutralSwatch.scale_12.withOpacity(0.5),
      disabledHintColor: neutralSwatch.radixScale_8.alphaVariant,
      iconColor: neutralSwatch.scale_12,
      filledIconColor: neutralSwatch.scale_12,
      disabledIconColor: neutralSwatch.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: accentSwatch.scale_9,
    );
  }

  factory RadixSelectDecorationSoftVariant.figmaDecorationFromErrorColorSwatch({
    required RadixColorsSwatch errorColorSwatch,
    required RadixColorsSwatch neutralSwatch,
    required RadixColorsSwatch accentSwatch,
  }) {
    return RadixSelectDecorationSoftVariant(
      backgroundColor: errorColorSwatch.radixScale_3.alphaVariant,
      filledBackgroundColor: errorColorSwatch.radixScale_3.alphaVariant,
      hoveredBackgroundColor: errorColorSwatch.radixScale_4.alphaVariant,
      focusedBackgroundColor: errorColorSwatch.radixScale_5.alphaVariant,
      disabledBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      textColor: errorColorSwatch.scale_12,
      disabledTextColor: neutralSwatch.radixScale_8.alphaVariant,
      hintColor: errorColorSwatch.scale_12.withOpacity(0.5),
      disabledHintColor: neutralSwatch.radixScale_8.alphaVariant,
      iconColor: errorColorSwatch.scale_12,
      filledIconColor: errorColorSwatch.scale_12,
      disabledIconColor: neutralSwatch.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: accentSwatch.scale_9,
    );
  }
}

class RadixSelectDecorationGhostVariant extends RadixSelectDecorationVariant {
  RadixSelectDecorationGhostVariant({
    super.debugSize,
    required super.backgroundColor,
    super.filledBackgroundColor,
    super.hoveredBackgroundColor,
    super.focusedBackgroundColor,
    required super.disabledBackgroundColor,
    super.readOnlyBackgroundColor,
    required super.textColor,
    required super.disabledTextColor,
    super.readOnlyTextColor,
    required super.hintColor,
    super.disabledHintColor,
    super.side,
    super.filledSide,
    super.hoveredSide,
    super.focusedSide,
    super.disabledSide,
    super.readOnlySide,
    super.iconColor,
    super.filledIconColor,
    super.disabledIconColor,
    super.readOnlyIconColor,
    required super.hoveredItemBackgroundColor,
  }) : super(debugVariant: RadixSelectVariant.ghost);

  factory RadixSelectDecorationGhostVariant.from({
    required RadixColorsSwatch graySwatch,
    required RadixColorsSwatch accentColorSwatch,
  }) {
    return RadixSelectDecorationGhostVariant(
      backgroundColor: RadixColors.transparent,
      hoveredBackgroundColor: accentColorSwatch.radixScale_3.alphaVariant,
      focusedBackgroundColor: accentColorSwatch.radixScale_3.alphaVariant,
      disabledBackgroundColor: RadixColors.transparent,
      textColor: accentColorSwatch.scale_12,
      disabledTextColor: graySwatch.radixScale_11.alphaVariant,
      hintColor: accentColorSwatch.scale_12.withOpacity(0.6),
      iconColor: accentColorSwatch.scale_12.withOpacity(0.6),
      filledIconColor: RadixColorScheme.kLight.neutral.scale_12,
      disabledIconColor: graySwatch.radixScale_9.alphaVariant,
      hoveredItemBackgroundColor: accentColorSwatch.scale_9,
    );
  }

  factory RadixSelectDecorationGhostVariant.figmaDecorationFromAccentColorSwatch({
    required RadixColorsSwatch neutralSwatch,
    required RadixColorsSwatch accentColorSwatch,
  }) {
    return RadixSelectDecorationGhostVariant(
      backgroundColor: RadixColors.transparent,
      filledBackgroundColor: RadixColors.transparent,
      hoveredBackgroundColor: accentColorSwatch.radixScale_3.alphaVariant,
      focusedBackgroundColor: accentColorSwatch.radixScale_4.alphaVariant,
      disabledBackgroundColor: RadixColors.transparent,
      readOnlyBackgroundColor: RadixColors.transparent,
      textColor: accentColorSwatch.scale_12,
      disabledTextColor: neutralSwatch.radixScale_8.alphaVariant,
      hintColor: accentColorSwatch.scale_12.withOpacity(0.5),
      disabledHintColor: neutralSwatch.radixScale_8.alphaVariant,
      iconColor: accentColorSwatch.scale_12,
      filledIconColor: neutralSwatch.scale_12,
      disabledIconColor: neutralSwatch.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: accentColorSwatch.scale_9,
    );
  }

  factory RadixSelectDecorationGhostVariant.figmaDecorationFromNeutralColorSwatch({
    required RadixColorsSwatch neutralSwatch,
    required RadixColorsSwatch accentSwatch,
  }) {
    return RadixSelectDecorationGhostVariant(
      backgroundColor: RadixColors.transparent,
      filledBackgroundColor: RadixColors.transparent,
      hoveredBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      focusedBackgroundColor: neutralSwatch.radixScale_4.alphaVariant,
      disabledBackgroundColor: RadixColors.transparent,
      readOnlyBackgroundColor: RadixColors.transparent,
      textColor: neutralSwatch.scale_12,
      disabledTextColor: neutralSwatch.radixScale_8.alphaVariant,
      hintColor: neutralSwatch.scale_12.withOpacity(0.5),
      disabledHintColor: neutralSwatch.radixScale_8.alphaVariant,
      iconColor: neutralSwatch.scale_12,
      filledIconColor: neutralSwatch.scale_12,
      disabledIconColor: neutralSwatch.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: accentSwatch.scale_9,
    );
  }

  factory RadixSelectDecorationGhostVariant.figmaDecorationFromErrorColorSwatch({
    required RadixColorsSwatch errorColorSwatch,
    required RadixColorsSwatch neutralSwatch,
    required RadixColorsSwatch accentSwatch,
  }) {
    return RadixSelectDecorationGhostVariant(
      backgroundColor: RadixColors.transparent,
      filledBackgroundColor: RadixColors.transparent,
      hoveredBackgroundColor: errorColorSwatch.radixScale_3.alphaVariant,
      focusedBackgroundColor: errorColorSwatch.radixScale_4.alphaVariant,
      disabledBackgroundColor: RadixColors.transparent,
      readOnlyBackgroundColor: RadixColors.transparent,
      textColor: errorColorSwatch.scale_12,
      disabledTextColor: neutralSwatch.radixScale_8.alphaVariant,
      hintColor: errorColorSwatch.scale_12.withOpacity(0.5),
      disabledHintColor: neutralSwatch.radixScale_8.alphaVariant,
      iconColor: errorColorSwatch.scale_12,
      filledIconColor: errorColorSwatch.scale_12,
      disabledIconColor: neutralSwatch.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: accentSwatch.scale_9,
    );
  }
}

class RadixSelectSizeSwatch {
  const RadixSelectSizeSwatch({
    required this.s1,
    required this.s2,
    required this.s3,
  });

  final RadixSelectDecorationVariantFactor s1;
  final RadixSelectDecorationVariantFactor s2;
  final RadixSelectDecorationVariantFactor s3;

  static final RadixSelectSizeSwatch kWebCss = RadixSelectSizeSwatch(
    s1: RadixSelectDecorationVariantFactor(
      padding: EdgeInsets.symmetric(horizontal: RadixSpace.kDefault.scale_2),
      ghostPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_2,
        vertical: RadixSpace.kDefault.scale_1,
      ),
      triggerHeight: RadixSpace.kDefault.scale_5,
      textStyle: RadixTextTheme.kDefault.scale_1,
      gap: RadixSpace.kDefault.scale_1,
      borderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_1,
      ),
      iconSize: 9,
      contentPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_1,
      ),
      contentBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_3,
      ),
      labelTextStyle: RadixTextTheme.kDefault.scale_1,
      itemHeight: RadixSpace.kDefault.scale_5,
      itemTextStyle: RadixTextTheme.kDefault.scale_1,
      itemBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_1,
      ),
      itemIndicatorWidth: RadixSpace.kDefault.scale_5 / 1.2,
      itemIndicatorIconSize: Size.square(8.0),
    ),
    s2: RadixSelectDecorationVariantFactor(
      padding: EdgeInsets.symmetric(horizontal: RadixSpace.kDefault.scale_3),
      ghostPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_2,
        vertical: RadixSpace.kDefault.scale_1,
      ),
      triggerHeight: RadixSpace.kDefault.scale_6,
      textStyle: RadixTextTheme.kDefault.scale_2,
      gap: RadixSpace.kDefault.scale_1 * 1.5,
      borderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_2,
      ),
      iconSize: 9,
      contentPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_2,
      ),
      contentBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_4,
      ),
      labelTextStyle: RadixTextTheme.kDefault.scale_2,
      itemHeight: RadixSpace.kDefault.scale_6,
      itemTextStyle: RadixTextTheme.kDefault.scale_2,
      itemBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_2,
      ),
      itemIndicatorWidth: RadixSpace.kDefault.scale_5,
      itemIndicatorIconSize: Size.square(10.0),
    ),
    s3: RadixSelectDecorationVariantFactor(
      padding: EdgeInsets.symmetric(horizontal: RadixSpace.kDefault.scale_4),
      ghostPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_3,
        vertical: RadixSpace.kDefault.scale_1 * 1.5,
      ),
      triggerHeight: RadixSpace.kDefault.scale_7,
      textStyle: RadixTextTheme.kDefault.scale_3,
      gap: RadixSpace.kDefault.scale_2,
      borderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_3,
      ),
      iconSize: 9,
      contentPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_2,
      ),
      contentBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_4,
      ),
      labelTextStyle: RadixTextTheme.kDefault.scale_2,
      itemHeight: RadixSpace.kDefault.scale_6,
      itemTextStyle: RadixTextTheme.kDefault.scale_3.copyWith(
        height: RadixTextTheme.kDefault.scale_2.height,
      ),
      itemBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_2,
      ),
      itemIndicatorWidth: RadixSpace.kDefault.scale_5,
      itemIndicatorIconSize: Size.square(10.0),
    ),
  );

  static final RadixSelectSizeSwatch kFigma = RadixSelectSizeSwatch(
    s1: RadixSelectDecorationVariantFactor(
      padding: EdgeInsets.symmetric(horizontal: RadixSpace.kDefault.scale_2),
      ghostPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_2,
        vertical: RadixSpace.kDefault.scale_1,
      ),
      triggerHeight: RadixSpace.kDefault.scale_5,
      textStyle: RadixTextTheme.kDefault.scale_1,
      gap: RadixSpace.kDefault.scale_1,
      borderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_1,
      ),
      iconSize: RadixSpace.kDefault.scale_4,
      contentPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_1,
      ),
      contentBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_3,
      ),
      labelTextStyle: RadixTextTheme.kDefault.scale_1,
      itemHeight: RadixSpace.kDefault.scale_5,
      itemTextStyle: RadixTextTheme.kDefault.scale_1,
      itemBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_1,
      ),
      itemIndicatorWidth: RadixSpace.kDefault.scale_5 / 1.2,
      // The Figma design does not specify the size of the indicator
      itemIndicatorIconSize: Size.square(
        RadixSpace.kDefault.scale_4,
      ),
    ),
    s2: RadixSelectDecorationVariantFactor(
      padding: EdgeInsets.symmetric(horizontal: RadixSpace.kDefault.scale_3),
      ghostPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_2,
        vertical: RadixSpace.kDefault.scale_1,
      ),
      triggerHeight: RadixSpace.kDefault.scale_6,
      textStyle: RadixTextTheme.kDefault.scale_2,
      gap: RadixSpace.kDefault.scale_2,
      borderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_2,
      ),
      iconSize: RadixSpace.kDefault.scale_4,
      contentPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_2,
      ),
      contentBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_4,
      ),
      labelTextStyle: RadixTextTheme.kDefault.scale_2,
      itemHeight: RadixSpace.kDefault.scale_6,
      itemTextStyle: RadixTextTheme.kDefault.scale_2,
      itemBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_2,
      ),
      itemIndicatorWidth: RadixSpace.kDefault.scale_5,
      // The Figma design does not specify the size of the indicator
      itemIndicatorIconSize: Size.square(
        RadixSpace.kDefault.scale_4,
      ),
    ),
    s3: RadixSelectDecorationVariantFactor(
      padding: EdgeInsets.symmetric(horizontal: RadixSpace.kDefault.scale_4),
      ghostPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_3,
        vertical: RadixSpace.kDefault.scale_1 * 1.5,
      ),
      triggerHeight: RadixSpace.kDefault.scale_7,
      textStyle: RadixTextTheme.kDefault.scale_3,
      gap: RadixSpace.kDefault.scale_3,
      borderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_3,
      ),
      iconSize: 18,
      contentPadding: EdgeInsets.all(
        RadixSpace.kDefault.scale_2,
      ),
      contentBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_4,
      ),
      labelTextStyle: RadixTextTheme.kDefault.scale_2,
      itemHeight: RadixSpace.kDefault.scale_6,
      itemTextStyle: RadixTextTheme.kDefault.scale_3.copyWith(
        height: RadixTextTheme.kDefault.scale_2.height,
      ),
      itemBorderRadius: BorderRadius.all(
        RadixRadiusSwatch.kBase.scale_2,
      ),
      itemIndicatorWidth: RadixSpace.kDefault.scale_5,
      // The Figma design does not specify the size of the indicator
      itemIndicatorIconSize: Size.square(18.0),
    ),
  );

  RadixSelectDecorationVariantFactor operator [](RadixSelectSize size) {
    return switch (size) {
      RadixSelectSize.$1 => s1,
      RadixSelectSize.$2 => s2,
      RadixSelectSize.$3 => s3,
    };
  }
}

/// Radix uses inner shadow for classic variant,
/// but Flutter doesn't support inner shadow, so the classic variant
/// isn't defined.
class RadixSelectDecorationVariantTheme {
  const RadixSelectDecorationVariantTheme({
    required this.surface,
    required this.soft,
    required this.ghost,
    required this.contentBackgroundColor,
    required this.contentBoxShadow,
    required this.sizeSwatch,
  });

  final RadixSelectDecorationVariant surface;
  final RadixSelectDecorationVariant soft;
  final RadixSelectDecorationVariant ghost;

  /// The background color of the content.
  final Color contentBackgroundColor;

  final List<BoxShadow> contentBoxShadow;

  final RadixSelectSizeSwatch sizeSwatch;

  RadixSelectDecorationVariant operator [](RadixSelectVariant variant) {
    return switch (variant) {
      RadixSelectVariant.surface => surface,
      RadixSelectVariant.soft => soft,
      RadixSelectVariant.ghost => ghost,
    };
  }

  static final RadixSelectDecorationVariantTheme kLight = RadixSelectDecorationVariantTheme(
    surface: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.surface,
      backgroundColor: RadixColorScheme.kLight.surfaceColor,
      disabledBackgroundColor: RadixColorScheme.kLight.gray.radixScale_2.alphaVariant,
      textColor: RadixColorScheme.kLight.gray.scale_12,
      disabledTextColor: RadixColorScheme.kLight.gray.radixScale_11.alphaVariant,
      hintColor: RadixColorScheme.kLight.gray.radixScale_10.alphaVariant,
      side: BorderSide(
        width: 1,
        color: RadixColorScheme.kLight.gray.radixScale_7.alphaVariant,
      ),
      hoveredSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kLight.gray.radixScale_8.alphaVariant,
      ),
      focusedSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kLight.gray.radixScale_8.alphaVariant,
      ),
      disabledSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kLight.gray.radixScale_6.alphaVariant,
      ),
      iconColor: RadixColorScheme.kLight.gray.radixScale_10.alphaVariant,
      filledIconColor: RadixColorScheme.kLight.gray.scale_12,
      disabledIconColor: RadixColorScheme.kLight.gray.radixScale_9.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kLight.accent.scale_9,
    ),
    soft: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.soft,
      backgroundColor: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
      hoveredBackgroundColor: RadixColorScheme.kLight.accent.radixScale_4.alphaVariant,
      focusedBackgroundColor: RadixColorScheme.kLight.accent.radixScale_4.alphaVariant,
      disabledBackgroundColor: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kLight.accent.scale_12,
      disabledTextColor: RadixColorScheme.kLight.gray.radixScale_11.alphaVariant,
      hintColor: RadixColorScheme.kLight.accent.scale_12.withOpacity(0.6),
      iconColor: RadixColorScheme.kLight.accent.scale_12.withOpacity(0.6),
      filledIconColor: RadixColorScheme.kLight.neutral.scale_12,
      disabledIconColor: RadixColorScheme.kLight.gray.radixScale_9.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kLight.accent.scale_9,
    ),
    ghost: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.ghost,
      backgroundColor: RadixColors.transparent,
      hoveredBackgroundColor: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
      focusedBackgroundColor: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
      disabledBackgroundColor: RadixColors.transparent,
      textColor: RadixColorScheme.kLight.accent.scale_12,
      disabledTextColor: RadixColorScheme.kLight.gray.radixScale_11.alphaVariant,
      hintColor: RadixColorScheme.kLight.accent.scale_12.withOpacity(0.6),
      iconColor: RadixColorScheme.kLight.accent.scale_12.withOpacity(0.6),
      filledIconColor: RadixColorScheme.kLight.neutral.scale_12,
      disabledIconColor: RadixColorScheme.kLight.gray.radixScale_9.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kLight.accent.scale_9,
    ),
    contentBackgroundColor: RadixColorScheme.kLight.panelSolidColor,
    contentBoxShadow: RadixShadowSwatch.kLight.scale_5,
    sizeSwatch: RadixSelectSizeSwatch.kWebCss,
  );

  static final RadixSelectDecorationVariantTheme kFigmaLight = RadixSelectDecorationVariantTheme(
    surface: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.surface,
      backgroundColor: RadixColorScheme.kLight.surfaceColor,
      focusedBackgroundColor: RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
      disabledBackgroundColor: RadixColorScheme.kLight.neutral.radixScale_2.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kLight.neutral.radixScale_2.alphaVariant,
      textColor: RadixColorScheme.kLight.neutral.scale_12,
      disabledTextColor: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      readOnlyTextColor: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      hintColor: RadixColorScheme.kLight.neutral.radixScale_10.alphaVariant,
      disabledHintColor: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      side: BorderSide(
        width: 1,
        color: RadixColorScheme.kLight.neutral.radixScale_7.alphaVariant,
      ),
      hoveredSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      ),
      focusedSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      ),
      disabledSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kLight.neutral.radixScale_6.alphaVariant,
      ),
      readOnlySide: BorderSide(
        width: 1,
        color: RadixColorScheme.kLight.neutral.radixScale_6.alphaVariant,
      ),
      iconColor: RadixColorScheme.kLight.neutral.scale_12,
      disabledIconColor: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      readOnlyIconColor: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kLight.accent.scale_9,
    ),
    soft: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.soft,
      backgroundColor: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
      filledBackgroundColor: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
      hoveredBackgroundColor: RadixColorScheme.kLight.accent.radixScale_4.alphaVariant,
      focusedBackgroundColor: RadixColorScheme.kLight.accent.radixScale_5.alphaVariant,
      disabledBackgroundColor: RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kLight.accent.scale_12,
      disabledTextColor: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      hintColor: RadixColorScheme.kLight.accent.scale_12.withOpacity(0.5),
      disabledHintColor: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      iconColor: RadixColorScheme.kLight.accent.scale_12,
      filledIconColor: RadixColorScheme.kLight.neutral.scale_12,
      disabledIconColor: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kLight.accent.scale_9,
    ),
    ghost: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.ghost,
      backgroundColor: RadixColors.transparent,
      filledBackgroundColor: RadixColors.transparent,
      hoveredBackgroundColor: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
      focusedBackgroundColor: RadixColorScheme.kLight.accent.radixScale_4.alphaVariant,
      disabledBackgroundColor: RadixColors.transparent,
      readOnlyBackgroundColor: RadixColors.transparent,
      textColor: RadixColorScheme.kLight.accent.scale_12,
      disabledTextColor: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      hintColor: RadixColorScheme.kLight.accent.scale_12.withOpacity(0.5),
      disabledHintColor: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      iconColor: RadixColorScheme.kLight.accent.scale_12,
      filledIconColor: RadixColorScheme.kLight.neutral.scale_12,
      disabledIconColor: RadixColorScheme.kLight.neutral.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kLight.accent.scale_9,
    ),
    contentBackgroundColor: RadixColorScheme.kLight.panelSolidColor,
    contentBoxShadow: RadixShadowSwatch.kLight.scale_5,
    sizeSwatch: RadixSelectSizeSwatch.kFigma,
  );

  static final RadixSelectDecorationVariantTheme kDark = RadixSelectDecorationVariantTheme(
    surface: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.surface,
      backgroundColor: RadixColorScheme.kDark.surfaceColor,
      disabledBackgroundColor: RadixColorScheme.kDark.gray.radixScale_2.alphaVariant,
      textColor: RadixColorScheme.kDark.gray.scale_12,
      disabledTextColor: RadixColorScheme.kDark.gray.radixScale_11.alphaVariant,
      hintColor: RadixColorScheme.kDark.gray.radixScale_10.alphaVariant,
      side: BorderSide(
        width: 1,
        color: RadixColorScheme.kDark.gray.radixScale_7.alphaVariant,
      ),
      hoveredSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kDark.gray.radixScale_8.alphaVariant,
      ),
      focusedSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kDark.gray.radixScale_8.alphaVariant,
      ),
      disabledSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kDark.gray.radixScale_6.alphaVariant,
      ),
      iconColor: RadixColorScheme.kDark.gray.radixScale_10.alphaVariant,
      filledIconColor: RadixColorScheme.kDark.gray.scale_12,
      disabledIconColor: RadixColorScheme.kDark.gray.radixScale_9.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kDark.accent.scale_9,
    ),
    soft: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.soft,
      backgroundColor: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
      hoveredBackgroundColor: RadixColorScheme.kDark.accent.radixScale_4.alphaVariant,
      focusedBackgroundColor: RadixColorScheme.kDark.accent.radixScale_4.alphaVariant,
      disabledBackgroundColor: RadixColorScheme.kDark.gray.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kDark.accent.scale_12,
      disabledTextColor: RadixColorScheme.kDark.gray.radixScale_11.alphaVariant,
      hintColor: RadixColorScheme.kDark.accent.scale_12.withOpacity(0.6),
      iconColor: RadixColorScheme.kDark.accent.scale_12.withOpacity(0.6),
      filledIconColor: RadixColorScheme.kDark.neutral.scale_12,
      disabledIconColor: RadixColorScheme.kDark.gray.radixScale_9.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kDark.accent.scale_9,
    ),
    ghost: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.ghost,
      backgroundColor: RadixColors.transparent,
      hoveredBackgroundColor: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
      focusedBackgroundColor: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
      disabledBackgroundColor: RadixColors.transparent,
      textColor: RadixColorScheme.kDark.accent.scale_12,
      disabledTextColor: RadixColorScheme.kDark.gray.radixScale_11.alphaVariant,
      hintColor: RadixColorScheme.kDark.accent.scale_12.withOpacity(0.6),
      iconColor: RadixColorScheme.kDark.accent.scale_12.withOpacity(0.6),
      filledIconColor: RadixColorScheme.kDark.neutral.scale_12,
      disabledIconColor: RadixColorScheme.kDark.gray.radixScale_9.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kDark.accent.scale_9,
    ),
    contentBackgroundColor: RadixColorScheme.kDark.panelSolidColor,
    contentBoxShadow: RadixShadowSwatch.kDark.scale_5,
    sizeSwatch: RadixSelectSizeSwatch.kWebCss,
  );

  static final RadixSelectDecorationVariantTheme kFigmaDark = RadixSelectDecorationVariantTheme(
    surface: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.surface,
      backgroundColor: RadixColorScheme.kDark.surfaceColor,
      focusedBackgroundColor: RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
      disabledBackgroundColor: RadixColorScheme.kDark.neutral.radixScale_2.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kDark.neutral.radixScale_2.alphaVariant,
      textColor: RadixColorScheme.kDark.neutral.scale_12,
      disabledTextColor: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      readOnlyTextColor: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      hintColor: RadixColorScheme.kDark.neutral.radixScale_10.alphaVariant,
      disabledHintColor: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      side: BorderSide(
        width: 1,
        color: RadixColorScheme.kDark.neutral.radixScale_7.alphaVariant,
      ),
      hoveredSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      ),
      focusedSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      ),
      disabledSide: BorderSide(
        width: 1,
        color: RadixColorScheme.kDark.neutral.radixScale_6.alphaVariant,
      ),
      readOnlySide: BorderSide(
        width: 1,
        color: RadixColorScheme.kDark.neutral.radixScale_6.alphaVariant,
      ),
      iconColor: RadixColorScheme.kDark.neutral.scale_12,
      disabledIconColor: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      readOnlyIconColor: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kDark.accent.scale_9,
    ),
    soft: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.soft,
      backgroundColor: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
      filledBackgroundColor: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
      hoveredBackgroundColor: RadixColorScheme.kDark.accent.radixScale_4.alphaVariant,
      focusedBackgroundColor: RadixColorScheme.kDark.accent.radixScale_5.alphaVariant,
      disabledBackgroundColor: RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kDark.accent.scale_12,
      disabledTextColor: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      hintColor: RadixColorScheme.kDark.accent.scale_12.withOpacity(0.5),
      disabledHintColor: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      iconColor: RadixColorScheme.kDark.accent.scale_12,
      filledIconColor: RadixColorScheme.kDark.neutral.scale_12,
      disabledIconColor: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kDark.accent.scale_9,
    ),
    ghost: RadixSelectDecorationVariant(
      debugVariant: RadixSelectVariant.ghost,
      backgroundColor: RadixColors.transparent,
      filledBackgroundColor: RadixColors.transparent,
      hoveredBackgroundColor: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
      focusedBackgroundColor: RadixColorScheme.kDark.accent.radixScale_4.alphaVariant,
      disabledBackgroundColor: RadixColors.transparent,
      readOnlyBackgroundColor: RadixColors.transparent,
      textColor: RadixColorScheme.kDark.accent.scale_12,
      disabledTextColor: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      hintColor: RadixColorScheme.kDark.accent.scale_12.withOpacity(0.5),
      disabledHintColor: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      iconColor: RadixColorScheme.kDark.accent.scale_12,
      filledIconColor: RadixColorScheme.kDark.neutral.scale_12,
      disabledIconColor: RadixColorScheme.kDark.neutral.radixScale_8.alphaVariant,
      hoveredItemBackgroundColor: RadixColorScheme.kDark.accent.scale_9,
    ),
    contentBackgroundColor: RadixColorScheme.kDark.panelSolidColor,
    contentBoxShadow: RadixShadowSwatch.kDark.scale_5,
    sizeSwatch: RadixSelectSizeSwatch.kFigma,
  );

  /// The [RadixThemeData.selectDecorationVariantTheme] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).selectVariantTheme`.
  static RadixSelectDecorationVariantTheme? of(BuildContext context) => RadixTheme.of(context).selectDecorationVariantTheme;

  /// The [RadixThemeExtension.selectDecorationVariantTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).selectVariantTheme`.
  static RadixSelectDecorationVariantTheme? fromTheme(BuildContext context) => RadixTheme.fromTheme(context).selectDecorationVariantTheme;

  /// The [RadixThemeExtension.selectDecorationVariantTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).selectVariantTheme`.
  static RadixSelectDecorationVariantTheme? extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).selectDecorationVariantTheme;
}

/// Defines the default appearance of [RadixInputDecorator]s.
///
/// See also:
///
///  * [RadixInputDecorationThemeData], which describes the actual configuration of a
///    select decoration theme.
///  * [RadixThemeData.selectDecorationTheme], which specifies an input decoration theme as
///    part of the overall Radix theme.
class RadixSelectDecorationTheme extends InheritedTheme with Diagnosticable {
  /// Creates a [RadixSelectDecorationTheme] that controls visual parameters for
  /// descendant [RadixInputDecorator]s.
  const RadixSelectDecorationTheme({
    super.key,
    this.data,
    Widget? child,
  }) : super(child: child ?? const SizedBox.shrink());

  final RadixInputDecorationThemeData? data;

  /// Returns the closest [RadixInputDecorationThemeData] instance given the build context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// RadixInputDecorationThemeData theme = RadixInputDecorationTheme.of(context);
  /// ```
  static RadixInputDecorationThemeData? of(BuildContext context) {
    final RadixSelectDecorationTheme? selectDecorationTheme = context
        .dependOnInheritedWidgetOfExactType<RadixSelectDecorationTheme>();
    final RadixInputDecorationThemeData? theme = selectDecorationTheme?.data;
    return theme;
  }

  /// The [RadixThemeData.selectDecorationTheme] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).selectDecorationTheme`.
  static RadixInputDecorationThemeData globalOf(BuildContext context) => RadixTheme.of(context).selectDecorationTheme!;

  /// The [RadixThemeExtension.selectDecorationTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).selectDecorationTheme`.
  static RadixInputDecorationThemeData fromTheme(BuildContext context) => RadixTheme.fromTheme(context).selectDecorationTheme!;

  /// The [RadixThemeExtension.selectDecorationTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).selectDecorationTheme`.
  static RadixInputDecorationThemeData extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).selectDecorationTheme!;

  @override
  bool updateShouldNotify(RadixSelectDecorationTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return RadixSelectDecorationTheme(data: data, child: child);
  }
}

// The widget that is the button wrapping the menu items.
class _RadixSelectItem<T> extends StatelessWidget {
  const _RadixSelectItem({
    super.key,
    required this.route,
    required this.buttonRect,
    required this.constraints,
    required this.itemIndex,
    required this.enableFeedback,
    required this.scrollController,
    this.mouseCursor,
  });

  final RadixSelectContentRoute<T> route;
  final ScrollController scrollController;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final int itemIndex;
  final bool enableFeedback;
  final MouseCursor? mouseCursor;

  void _handleFocusChange(bool focused) {
    final bool inTraditionalMode = switch (FocusManager.instance.highlightMode) {
      FocusHighlightMode.touch => false,
      FocusHighlightMode.traditional => true,
    };

    if (focused && inTraditionalMode) {
      final _MenuLimits menuLimits = route._getMenuLimits(
        buttonRect,
        constraints.maxHeight,
        itemIndex,
      );
      scrollController.animateTo(
        menuLimits.scrollOffset,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 100),
      );
    }
  }

  static const Map<ShortcutActivator, Intent> _webShortcuts = <ShortcutActivator, Intent>{
    // On the web, up/down don't change focus, *except* in a <select>
    // element, which is what a dropdown emulates.
    SingleActivator(LogicalKeyboardKey.arrowDown): DirectionalFocusIntent(TraversalDirection.down),
    SingleActivator(LogicalKeyboardKey.arrowUp): DirectionalFocusIntent(TraversalDirection.up),
  };

  @override
  Widget build(BuildContext context) {
    final RadixColorScheme radixColorScheme = RadixColorScheme.fromTheme(context);
    final TextDirection? textDirection = Directionality.maybeOf(context);

    final Alignment alignment = textDirection == TextDirection.ltr
        ? Alignment.centerLeft
        : Alignment.centerRight;

    final RadixSelectItem<T> selectMenuItem = route.items[itemIndex];
    Widget child = route.items[itemIndex];

    final bool isSelected = itemIndex == route.selectedIndex;
    if (selectMenuItem.enabled) {
      child = RadixGhostButton.custom(
        onTap: () {
          final RadixSelectItem<T> dropdownMenuItem = route.items[itemIndex];

          dropdownMenuItem.onTap?.call();

          (route.popPopupContentRoute ?? Navigator.pop)(
            context,
            RadixSelectRouteResult<T>(dropdownMenuItem.value, itemIndex),
          );
        },
        onFocusChange: _handleFocusChange,
        mouseCursor: mouseCursor,
        centeredAlignment: false,
        styleModifier: RadixButtonStyleModifier(
          backgroundColor: WidgetStateProperty.fromMap({
            WidgetState.hovered: route.hoveredItemBackgroundColor,
            WidgetState.pressed: route.hoveredItemBackgroundColor,
          }),
          padding: isSelected
              ? EdgeInsets.zero
              : EdgeInsets.symmetric(horizontal: route.itemIndicatorWidth),
          textStyle: route.style,
          textColor: WidgetStateColor.fromMap({
            WidgetState.hovered: radixColorScheme.accent.contrast!,
            WidgetState.pressed: radixColorScheme.accent.contrast!,
            WidgetState.any: radixColorScheme.gray.scale_12,
          }),
        ),
        child: isSelected
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: route.itemIndicatorWidth,
                    child: Center(
                      widthFactor: 1,
                      child: Builder(
                        builder: (context) {
                          final IconThemeData iconTheme = IconTheme.of(context);
                      
                          return CustomPaint(
                            painter: _RadixCheckIconPainter(
                              color: iconTheme.color!,
                            ),
                            size: route.indicatorIconSize,
                          );
                        },
                      ),
                    ),
                  ),
                  if (!route.isExpanded)
                    child
                  else
                    Expanded(child: child),
                  SizedBox(width: route.itemIndicatorWidth),
                ],
              )
            : Align(
                alignment: alignment,
                widthFactor: route.isExpanded ? null : 1,
                heightFactor: 1,
                child: child,
              ),
      );
    } else {
      child = Padding(
        padding: EdgeInsets.symmetric(horizontal: route.itemIndicatorWidth),
        child: Align(
          alignment: alignment,
          widthFactor: route.isExpanded ? null : 1,
          heightFactor: 1,
          child: DefaultTextStyle(
            style: route.style.copyWith(
              color: radixColorScheme.gray.scale_12,
            ),
            child: child,
          ),
        ),
      );
    }
    child = ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: route.itemHeight),
      child: child,
    );
    if (kIsWeb && selectMenuItem.enabled) {
      child = Shortcuts(shortcuts: _webShortcuts, child: child);
    }
    return Semantics(role: SemanticsRole.menuItem, child: child);
  }
}

class _SelectContent<T> extends StatelessWidget {
  const _SelectContent({
    super.key,
    required this.route,
    required this.buttonRect,
    required this.constraints,
    required this.enableFeedback,
    required this.scrollController,
    this.menuWidth,
    this.mouseCursor,
    required this.options,
  });

  final RadixSelectContentRoute<T> route;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final bool enableFeedback;
  final ScrollController scrollController;
  final double? menuWidth;
  final MouseCursor? mouseCursor;
  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    return DecoratedBox(
      decoration: route.contentDecoration ?? BoxDecoration(
        color: route.backgroundColor,
        borderRadius: route.borderRadius,
        boxShadow: route.boxShadow,
      ),
      child: Semantics(
        role: SemanticsRole.menu,
        scopesRoute: true,
        namesRoute: true,
        explicitChildNodes: true,
        label: localizations.popupMenuLabel,
        child: ClipRRect(
          borderRadius: route.borderRadius ?? BorderRadius.zero,
          clipBehavior: route.borderRadius != null ? Clip.antiAlias : Clip.none,
          child: Material(
            type: MaterialType.transparency,
            textStyle: route.style,
            child: ScrollConfiguration(
              // Dropdown menus should never overscroll or display an overscroll indicator.
              // Scrollbars are built-in below.
              // Platform must use Theme and ScrollPhysics must be Clamping.
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
                overscroll: false,
                physics: const ClampingScrollPhysics(),
                platform: Theme.of(context).platform,
              ),
              child: PrimaryScrollController(
                controller: scrollController,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    // Ensure this always inherits the PrimaryScrollController
                    primary: true,
                    padding: route.padding,
                    shrinkWrap: true,
                    children: options,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectContentRouteLayout<T> extends MultiChildRenderObjectWidget {
  _SelectContentRouteLayout({
    super.key,
    required this.buttonRect,
    required this.route,
    required this.textDirection,
    this.width,
    required this.padding,
    required this.itemIndicatorWidth,
    required Widget child,
    required List<Widget> options,
  }) : super(children: [child, ...options]);

  final Rect buttonRect;
  final RadixSelectContentRoute<T> route;
  final TextDirection? textDirection;
  final double? width;
  final EdgeInsets padding;
  final double itemIndicatorWidth;

  @override
  _RenderSelectContentRouteLayout createRenderObject(BuildContext context) {
    return _RenderSelectContentRouteLayout<T>(
      buttonRect: buttonRect,
      route: route,
      textDirection: textDirection,
      width: width,
      padding: padding,
      itemIndicatorWidth: itemIndicatorWidth,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSelectContentRouteLayout renderObject) {
    renderObject
      ..buttonRect = buttonRect
      ..textDirection = textDirection
      ..width = width
      ..padding = padding
      ..itemIndicatorWidth = itemIndicatorWidth;
  }
}

class _RenderSelectContentRouteLayout<T> extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, StackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, StackParentData> {
  _RenderSelectContentRouteLayout({
    List<RenderBox>? children,
    required Rect buttonRect,
    required this.route,
    TextDirection? textDirection,
    double? width,
    required EdgeInsets padding,
    required double itemIndicatorWidth,
  }) : _buttonRect = buttonRect,
       _textDirection = textDirection,
       _width = width,
       _padding = padding,
       _itemIndicatorWidth = itemIndicatorWidth {
    addAll(children);
  }

  final RadixSelectContentRoute<T> route;

  Rect get buttonRect => _buttonRect;
  Rect _buttonRect;
  set buttonRect(Rect value) {
    if (value == _buttonRect) return;
    _buttonRect = value;
    markNeedsLayout();
  }

  TextDirection? get textDirection => _textDirection;
  TextDirection? _textDirection;
  set textDirection(TextDirection? value) {
    if (value == _textDirection) return;
    _textDirection = value;
    markNeedsLayout();
  }

  double? get width => _width;
  double? _width;
  set width(double? value) {
    if (value == _width) return;
    _width = value;
    markNeedsLayout();
  }

  EdgeInsets get padding => _padding;
  EdgeInsets _padding;
  set padding(EdgeInsets value) {
    if (value == _padding) return;
    _padding = value;
    markNeedsLayout();
  }

  double get itemIndicatorWidth => _itemIndicatorWidth;
  double _itemIndicatorWidth;
  set itemIndicatorWidth(double value) {
    if (value == _itemIndicatorWidth) return;
    _itemIndicatorWidth = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! StackParentData) {
      child.parentData = StackParentData();
    }
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    final RenderBox displayedChild = firstChild!;
    visitor(displayedChild);
  }

  /// Helper function for calculating the intrinsics metrics of a Stack.
  static double getIntrinsicDimension(
    RenderBox? firstChild,
    double Function(RenderBox child) mainChildSizeGetter,
  ) {
    double extent = 0.0;
    final RenderBox displayedChild = firstChild!;
    extent = math.max(extent, mainChildSizeGetter(displayedChild));
    return extent;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return getIntrinsicDimension(
      firstChild,
      (RenderBox child) => child.getMinIntrinsicWidth(height),
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return getIntrinsicDimension(
      firstChild,
      (RenderBox child) => child.getMaxIntrinsicWidth(height),
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return getIntrinsicDimension(
      firstChild,
      (RenderBox child) => child.getMinIntrinsicHeight(width),
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return getIntrinsicDimension(
      firstChild,
      (RenderBox child) => child.getMaxIntrinsicHeight(width),
    );
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    final RenderBox displayedChild = firstChild!;
    final StackParentData childParentData = displayedChild.parentData! as StackParentData;
    final BaselineOffset offset =
        BaselineOffset(displayedChild.getDistanceToActualBaseline(baseline)) +
        childParentData.offset.dy;
    return offset.offset;
  }

  static double? _baselineForChild(
    RenderBox child,
    Size stackSize,
    BoxConstraints nonPositionedChildConstraints,
    TextBaseline baseline,
  ) {
    final StackParentData childParentData = child.parentData! as StackParentData;
    final BoxConstraints childConstraints = childParentData.isPositioned
        ? childParentData.positionedChildConstraints(stackSize)
        : nonPositionedChildConstraints;
    final double? baselineOffset = child.getDryBaseline(childConstraints, baseline);
    if (baselineOffset == null) {
      return null;
    }
    final double y = Alignment.topLeft.alongOffset(
      stackSize - child.getDryLayout(childConstraints) as Offset,
    ).dy;
    return baselineOffset + y;
  }

  @override
  double? computeDryBaseline(BoxConstraints constraints, TextBaseline baseline) {
    final BoxConstraints nonPositionedChildConstraints = constraints.loosen();

    final Size size = getDryLayout(constraints);

    final RenderBox displayedChild = firstChild!;
    final BaselineOffset baselineOffset = BaselineOffset.noBaseline.minOf(
      BaselineOffset(
        _baselineForChild(displayedChild, size, nonPositionedChildConstraints, baseline),
      ),
    );
    return baselineOffset.offset;
  }

  @override
  @protected
  Size computeDryLayout(covariant BoxConstraints constraints) {
    return _computeSize(constraints: constraints, layoutChild: ChildLayoutHelper.dryLayoutChild);
  }

  RenderBox _getEffectiveFirstChild() {
    final RenderBox child = firstChild!;
    final StackParentData childParentData = child.parentData! as StackParentData;
    return childParentData.nextSibling!;
  }

  Size _computeSize({required BoxConstraints constraints, required ChildLayouter layoutChild}) {
    double width = 0.0;
    double height = 0.0;

    final BoxConstraints nonPositionedConstraints = BoxConstraints(
      maxWidth: constraints.maxWidth,
      minHeight: route.itemHeight,
      maxHeight: route.itemHeight,
    );

    RenderBox? child = _getEffectiveFirstChild();
    int index = 0;
    while (child != null) {
      final StackParentData childParentData = child.parentData! as StackParentData;

      final Size childSize = layoutChild(child, nonPositionedConstraints);

      route.itemHeights[index] = childSize.height;

      width = math.max(width, childSize.width);
      height = math.max(height, childSize.height);

      child = childParentData.nextSibling;
      index++;
    }

    final Size size = Size(width, height);

    assert(size.isFinite);
    return size;
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    size = constraints.biggest;

    final RenderBox displayedChild = firstChild!;

    final Size maxSize = _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
    );

    // The maximum height of a simple menu should be one or more rows less than
    // the view height. This ensures a tappable area outside of the simple menu
    // with which to dismiss the menu.
    //   -- https://material.io/design/components/menus.html#usage
    double maxHeight = math.max(0.0, constraints.maxHeight - 2 * route.itemHeight);
    if (route.menuMaxHeight != null && route.menuMaxHeight! <= maxHeight) {
      maxHeight = route.menuMaxHeight!;
    }

    final double maxWidth = clampDouble(width ?? (maxSize.width + padding.horizontal), 0.0, size.width);

    final BoxConstraints displayedChildConstraints = BoxConstraints(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );

    displayedChild.layout(displayedChildConstraints, parentUsesSize: true);

    final _MenuLimits menuLimits = route._getMenuLimits(
      buttonRect,
      size.height,
      route.initialScrollIndex,
    );

    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect) == buttonRect) {
        // If the button was entirely on-screen, then verify
        // that the menu is also on-screen.
        // If the button was a bit off-screen, then, oh well.
        assert(menuLimits.top >= 0.0);
        assert(menuLimits.top + menuLimits.height <= size.height);
      }
      return true;
    }());
    assert(textDirection != null);
    final double left = switch (textDirection!) {
      TextDirection.rtl => clampDouble(buttonRect.right + padding.right + (itemIndicatorWidth / 2.0), 0.0, size.width) - displayedChild.size.width,
      TextDirection.ltr => clampDouble(buttonRect.left - padding.left - (itemIndicatorWidth / 2.0), 0.0, size.width - displayedChild.size.width),
    };

    final StackParentData childParentData = displayedChild.parentData! as StackParentData;
    childParentData.offset = Offset(left, menuLimits.top);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final RenderBox displayedChild = firstChild!;
    final StackParentData childParentData = displayedChild.parentData! as StackParentData;
    return result.addWithPaintOffset(
      offset: childParentData.offset,
      position: position,
      hitTest: (BoxHitTestResult result, Offset transformed) {
        assert(transformed == position - childParentData.offset);
        return displayedChild.hitTest(result, position: transformed);
      },
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final RenderBox displayedChild = firstChild!;
    final StackParentData childParentData = displayedChild.parentData! as StackParentData;
    context.paintChild(displayedChild, childParentData.offset + offset);
  }
}

// We box the return value so that the return value can be null. Otherwise,
// canceling the route (which returns null) would get confused with actually
// returning a real null value.
@immutable
class RadixSelectRouteResult<T> {
  const RadixSelectRouteResult(this.result, this.itemIndex);

  final T? result;
  final int itemIndex;

  @override
  bool operator ==(Object other) {
    return other is RadixSelectRouteResult<T> && other.result == result && other.itemIndex == itemIndex;
  }

  @override
  int get hashCode => Object.hash(result, itemIndex);
}

class _MenuLimits {
  const _MenuLimits(this.top, this.bottom, this.height, this.scrollOffset);
  final double top;
  final double bottom;
  final double height;
  final double scrollOffset;
}

class RadixSelectContentRoute<T> extends PopupRoute<RadixSelectRouteResult<T>> {
  RadixSelectContentRoute({
    required this.items,
    required this.padding,
    required this.buttonRect,
    required this.selectedIndex,
    required this.initialScrollIndex,
    required this.capturedThemes,
    this.barrierLabel,
    this.barrierDismissible = true,
    required this.itemHeight,
    required this.hoveredItemBackgroundColor,
    required this.itemIndicatorWidth,
    required this.style,
    this.menuWidth,
    required this.isExpanded,
    this.menuMaxHeight,
    required this.indicatorIconSize,
    required this.enableFeedback,
    this.contentDecoration,
    required this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.contentItemMouseCursor,
    this.popPopupContentRoute,
    required this.textDirection,
  }) : itemHeights = List<double>.filled(items.length, itemHeight);

  final List<RadixSelectItem<T>> items;
  final EdgeInsets padding;
  final Rect buttonRect;
  final int? selectedIndex;
  final int initialScrollIndex;
  final CapturedThemes capturedThemes;
  final double itemHeight;
  final Color hoveredItemBackgroundColor;
  final double itemIndicatorWidth;
  final TextStyle style;
  final double? menuWidth;
  final bool isExpanded;
  final double? menuMaxHeight;
  final Size indicatorIconSize;
  final bool enableFeedback;
  final Decoration? contentDecoration;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final MouseCursor? contentItemMouseCursor;
  final TextDirection textDirection;

  final PopRadixSelectPopupContentRouteCallback<T>? popPopupContentRoute;

  final List<double> itemHeights;

  @override
  Duration get transitionDuration => Duration.zero;

  @override
  final bool barrierDismissible;

  @override
  Color? get barrierColor => null;

  @override
  final String? barrierLabel;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Directionality(
          textDirection: textDirection,
          child: _SelectContentRoutePage<T>(
            route: this,
            constraints: constraints,
            buttonRect: buttonRect,
            initialScrollIndex: initialScrollIndex,
            capturedThemes: capturedThemes,
            style: style,
            enableFeedback: enableFeedback,
            menuWidth: menuWidth,
            mouseCursor: contentItemMouseCursor,
          ),
        );
      },
    );
  }

  void _dismiss() {
    if (isActive && popPopupContentRoute == null) {
      navigator?.removeRoute(this);
    }
  }

  double getItemOffset(int index) {
    double offset = padding.top;
    if (items.isNotEmpty && index > 0) {
      assert(items.length == itemHeights.length);
      offset += itemHeights
          .sublist(0, index)
          .reduce((double total, double height) => total + height);
    }
    return offset;
  }

  double getItemHeight(int index) {
    if (index < itemHeights.length) return itemHeight;

    return itemHeights[index];
  }

  // Returns the vertical extent of the menu and the initial scrollOffset
  // for the ListView that contains the menu items. The vertical center of the
  // selected item is aligned with the button's vertical center, as far as
  // that's possible given availableHeight.
  _MenuLimits _getMenuLimits(Rect buttonRect, double availableHeight, int index) {
    double computedMaxHeight = availableHeight - 2.0 * itemHeight;
    if (menuMaxHeight != null) {
      computedMaxHeight = math.min(computedMaxHeight, menuMaxHeight!);
    }
    final double buttonTop = buttonRect.top;
    final double buttonBottom = math.min(buttonRect.bottom, availableHeight);
    final double selectedItemOffset = getItemOffset(index);

    // If the button is placed on the bottom or top of the screen, its top or
    // bottom may be less than [itemHeight] from the edge of the screen.
    // In this case, we want to change the menu limits to align with the top
    // or bottom edge of the button.
    final double topLimit = math.min(itemHeight, buttonTop);
    final double bottomLimit = math.max(availableHeight - itemHeight, buttonBottom);

    double menuTop =
        (buttonTop - selectedItemOffset) - (itemHeights[initialScrollIndex] - buttonRect.height) / 2.0;
    double preferredMenuHeight = kMaterialListPadding.vertical;
    if (items.isNotEmpty) {
      preferredMenuHeight += itemHeights.reduce((double total, double height) => total + height);
    }

    // If there are too many elements in the menu, we need to shrink it down
    // so it is at most the computedMaxHeight.
    final double menuHeight = math.min(computedMaxHeight, preferredMenuHeight);
    double menuBottom = menuTop + menuHeight;

    // If the computed top or bottom of the menu are outside of the range
    // specified, we need to bring them into range. If the item height is larger
    // than the button height and the button is at the very bottom or top of the
    // screen, the menu will be aligned with the bottom or top of the button
    // respectively.
    if (menuTop < topLimit) {
      menuTop = math.min(buttonTop, topLimit);
      menuBottom = menuTop + menuHeight;
    }

    if (menuBottom > bottomLimit) {
      menuBottom = math.max(buttonBottom, bottomLimit);
      menuTop = menuBottom - menuHeight;
    }

    if (menuBottom - itemHeights[initialScrollIndex] / 2.0 < buttonBottom - buttonRect.height / 2.0) {
      menuBottom = buttonBottom - buttonRect.height / 2.0 + itemHeights[initialScrollIndex] / 2.0;
      menuTop = menuBottom - menuHeight;
    }

    double scrollOffset = 0;
    // If all of the menu items will not fit within availableHeight then
    // compute the scroll offset that will line the selected menu item up
    // with the select item. This is only done when the menu is first
    // shown - subsequently we leave the scroll offset where the user left
    // it. This scroll offset is only accurate for fixed height menu items
    // (the default).
    if (preferredMenuHeight > computedMaxHeight) {
      // The offset should be zero if the selected item is in view at the beginning
      // of the menu. Otherwise, the scroll offset should center the item if possible.
      scrollOffset = math.max(0.0, selectedItemOffset - (buttonTop - menuTop));
      // If the selected item's scroll offset is greater than the maximum scroll offset,
      // set it instead to the maximum allowed scroll offset.
      scrollOffset = math.min(scrollOffset, preferredMenuHeight - menuHeight);
    }

    assert((menuBottom - menuTop - menuHeight).abs() < precisionErrorTolerance);
    return _MenuLimits(menuTop, menuBottom, menuHeight, scrollOffset);
  }
}

class _SelectContentRoutePage<T> extends StatefulWidget {
  const _SelectContentRoutePage({
    super.key,
    required this.route,
    required this.constraints,
    required this.buttonRect,
    required this.initialScrollIndex,
    required this.capturedThemes,
    this.style,
    required this.enableFeedback,
    this.menuWidth,
    this.mouseCursor,
  });

  final RadixSelectContentRoute<T> route;
  final BoxConstraints constraints;
  final Rect buttonRect;
  final int initialScrollIndex;
  final CapturedThemes capturedThemes;
  final TextStyle? style;
  final bool enableFeedback;
  final double? menuWidth;
  final MouseCursor? mouseCursor;

  @override
  State<_SelectContentRoutePage<T>> createState() => _SelectContentRoutePageState<T>();
}

class _SelectContentRoutePageState<T> extends State<_SelectContentRoutePage<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    // Computing the initialScrollOffset now, before the items have been laid
    // out. This only works if the item heights are effectively fixed.
    // Otherwise the initialScrollOffset is just a rough approximation based on
    // treating the items as if their heights were all equal to
    // RadixSelectContentRoute.itemHeight.
    final _MenuLimits menuLimits = widget.route._getMenuLimits(
      widget.buttonRect,
      widget.constraints.maxHeight,
      widget.initialScrollIndex,
    );
    _scrollController = ScrollController(initialScrollOffset: menuLimits.scrollOffset);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));

    final TextDirection? textDirection = Directionality.maybeOf(context);

    final List<Widget> children = List.generate(
      widget.route.items.length,
      (index) {
        return _RadixSelectItem<T>(
          route: widget.route,
          buttonRect: widget.buttonRect,
          constraints: widget.constraints,
          itemIndex: index,
          enableFeedback: widget.enableFeedback,
          scrollController: _scrollController,
          mouseCursor: widget.mouseCursor,
        );
      },
      growable: false,
    );

    final Widget content = _SelectContent<T>(
      route: widget.route,
      buttonRect: widget.buttonRect,
      constraints: widget.constraints,
      enableFeedback: widget.enableFeedback,
      scrollController: _scrollController,
      mouseCursor: widget.mouseCursor,
      options: children,
    );

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return _SelectContentRouteLayout(
            buttonRect: widget.buttonRect,
            route: widget.route,
            textDirection: textDirection,
            width: widget.menuWidth,
            padding: widget.route.padding,
            itemIndicatorWidth: widget.route.itemIndicatorWidth,
            options: children,
            child: widget.capturedThemes.wrap(content),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

/// The container widget for a menu item created by a [RadixSelect]. It
/// provides the default configuration for [RadixSelectItem]s.
class _DropdownMenuItemContainer extends StatelessWidget {
  /// Creates an item for a dropdown menu.
  ///
  /// The [child] argument is required.
  const _DropdownMenuItemContainer({
    super.key,
    required this.child,
  });

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: child,
    );
  }
}

/// An option in a menu created by a [RadixSelect].
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class RadixSelectItem<T> extends _DropdownMenuItemContainer {
  /// Creates an item for a select menu.
  ///
  /// The [child] argument is required.
  const RadixSelectItem({
    super.key,
    this.onTap,
    required this.value,
    this.enabled = true,
    required super.child,
  });

  /// Called when the select menu item is tapped.
  final VoidCallback? onTap;

  /// The value to return if the user selects this menu item.
  ///
  /// Eventually returned in a call to [RadixSelect.onChanged].
  final T value;

  /// Whether or not a user can select this menu item.
  ///
  /// Defaults to `true`.
  final bool enabled;
}

enum RadixSelectSize {
  $1, $2, $3
}

/// Radix uses inner shadow for classic variant,
/// but Flutter doesn't support inner shadow, so the classic variant
/// isn't defined.
enum RadixSelectVariant {
  surface, soft, ghost
}

typedef PushRadixSelectPopupContentRouteCallback<T extends Object?> = Future<T?> Function(RadixSelectContentRoute<T> route);

typedef PopRadixSelectPopupContentRouteCallback<T> = void Function(BuildContext context, [RadixSelectRouteResult<T>? result]);

/// A Radix button for selecting from a list of options.
///
/// A select lets the user pick from a number of items. The button
/// shows the currently selected item as well as an arrow that opens a menu
/// for selecting another item.
///
/// The type `T` is the type of the [initialValue] that each item represents.
/// All the entries in a given menu must represent values with consistent types.
/// Typically, an enum is used. Each [RadixSelectItem] in [options] must be
/// specialized with that same type argument.
///
/// The [onChanged] callback should update a state variable that defines the
/// select's item. It should also call [State.setState] to rebuild the
/// select with the new value.
///
///
/// {@tool dartpad}
/// This sample shows a [RadixSelect] with a large arrow icon,
/// purple text style, and bold purple underline, whose value is one of "One",
/// "Two", "Three", or "Four".
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/dropdown_button.png)
///
/// ** See code in examples/api/lib/material/dropdown/dropdown_button.0.dart **
/// {@end-tool}
///
/// If the [onChanged] callback is null or the list of [options] is null
/// then the dropdown button will be disabled, i.e. its arrow will be
/// displayed in grey and it will not respond to input. A disabled button
/// will display the [disabledHint] widget if it is non-null. However, if
/// [disabledHint] is null and [hint] is non-null, the [hint] widget will
/// instead be displayed.
///
/// {@tool dartpad}
/// This sample shows how you would rewrite the above [RadixSelect]
/// to use the [DropdownMenu].
///
/// ** See code in examples/api/lib/material/dropdown_menu/dropdown_menu.1.dart **
/// {@end-tool}
///
///
/// See also:
///
///  * [RadixSelectFormField], which integrates with the [Form] widget.
///  * [RadixSelectItem], the class used to represent the [options].
class RadixSelect<T> extends StatefulWidget {
  /// Creates a select button.
  ///
  /// The [options] must have distinct values. If [initialValue] isn't null then it
  /// must be equal to one of the [RadixSelectItem] values. If [options] or
  /// [onChanged] is null, the button will be disabled, the down arrow
  /// will be greyed out.
  ///
  /// If [initialValue] is null and the button is enabled,
  /// [RadixInputDecoration.hint] will be displayed if it is non-null.
  ///
  /// If [initialValue] is null and the button is disabled,
  /// [RadixInputDecoration.disabledHint] will be displayed if it is non-null.
  /// If [RadixInputDecoration.disabledHint] is null, then
  /// [RadixInputDecoration.hint] will be displayed if it is non-null.
  RadixSelect({
    super.key,
    required this.options,
    this.initialValue,
    this.size = RadixSelectSize.$2,
    this.variant = RadixSelectVariant.surface,
    this.inputDecoration,
    this.contentDecoration,
    required this.onChanged,
    this.onTap,
    this.iconSize = 24.0,
    this.isExpanded = false,
    this.menuWidth,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.menuMaxHeight,
    this.enableFeedback,
    this.barrierDismissible = true,
    this.mouseCursor,
    this.contentItemMouseCursor,
    this.pushPopupContentRoute,
    this.popPopupContentRoute,
    // When adding new arguments, consider adding similar arguments to
    // DropdownButtonFormField.
  }) : assert(
         options == null ||
             options.isEmpty ||
             initialValue == null ||
             options.where((RadixSelectItem<T> item) {
                   return item.value == initialValue;
                 }).length ==
                 1,
         "There should be exactly one item with [DropdownButton]'s value: "
         '$initialValue. \n'
         'Either zero or 2 or more [DropdownMenuItem]s were detected '
         'with the same value',
       );

  RadixSelect._formField({
    super.key,
    required this.options,
    this.initialValue,
    this.size = RadixSelectSize.$2,
    this.variant = RadixSelectVariant.surface,
    this.inputDecoration,
    this.contentDecoration,
    required this.onChanged,
    this.onTap,
    this.iconSize = 24.0,
    this.isExpanded = false,
    this.menuWidth,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.menuMaxHeight,
    this.enableFeedback,
    this.barrierDismissible = true,
    this.mouseCursor,
    this.contentItemMouseCursor,
    this.pushPopupContentRoute,
    this.popPopupContentRoute,
  }) : assert(
         options == null ||
             options.isEmpty ||
             initialValue == null ||
             options.where((RadixSelectItem<T> item) {
                   return item.value == initialValue;
                 }).length ==
                 1,
         "There should be exactly one item with [RadixSelectButtonFormField]'s value: "
         '$initialValue. \n'
         'Either zero or 2 or more [RadixSelectMenuItem]s were detected '
         'with the same value',
       );

  /// The list of items the user can pick.
  ///
  /// If the [onChanged] callback is null or the list of items is null
  /// then the select button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input.
  final List<RadixSelectItem<T>>? options;

  /// The initial value of the selected [RadixSelectItem].
  ///
  /// If [initialValue] is null and the button is enabled,
  /// [RadixInputDecoration.hint] will be displayed if it is non-null.
  ///
  /// If [initialValue] is null and the button is disabled,
  /// [RadixInputDecoration.disabledHint] will be displayed if it is non-null.
  /// If [RadixInputDecoration.disabledHint] is null, then
  /// [RadixInputDecoration.hint] will be displayed if it is non-null.
  final T? initialValue;

  final RadixSelectSize size;

  final RadixSelectVariant variant;

  /// The decoration to show around the select.
  final RadixInputDecoration? inputDecoration;

  /// The decoration to show around the popup content.
  final Decoration? contentDecoration;

  /// Called when the user selects an item.
  ///
  /// If the [onChanged] callback is null or the list of [RadixSelect.options]
  /// is null then the select button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input. A disabled button
  /// will display the [RadixSelect.disabledHint] widget if it is non-null.
  /// If [RadixSelect.disabledHint] is also null but [RadixSelect.hint] is
  /// non-null, [RadixSelect.hint] will instead be displayed.
  final ValueChanged<T?>? onChanged;

  /// Called when the select button is tapped.
  ///
  /// This is distinct from [onChanged], which is called when the user
  /// selects an item from the select.
  ///
  /// The callback will not be invoked if the select button is disabled.
  final VoidCallback? onTap;

  /// The size to use for the drop-down button's down arrow icon button.
  ///
  /// Defaults to 24.0.
  final double iconSize;

  /// Set the dropdown's inner contents to horizontally fill its parent.
  ///
  /// By default this button's inner width is the minimum size of its contents.
  /// If [isExpanded] is true, the inner width is expanded to fill its
  /// surrounding container.
  final bool isExpanded;

  /// The width of the menu.
  ///
  /// If it is not provided, the width of the menu is the width of the
  /// select button.
  final double? menuWidth;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  final bool readOnly;

  /// The maximum height of the menu.
  ///
  /// The maximum height of the menu must be at least one row shorter than
  /// the height of the app's view. This ensures that a tappable area
  /// outside of the simple menu is present so the user can dismiss the menu.
  ///
  /// If this property is set above the maximum allowable height threshold
  /// mentioned above, then the menu defaults to being padded at the top
  /// and bottom of the menu by at one menu item's height.
  final double? menuMaxHeight;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// By default, platform-specific feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// Determines whether tapping outside the dropdown will close it.
  ///
  /// Defaults to `true`.
  final bool barrierDismissible;

  /// The cursor for a mouse pointer when it enters or is hovering over this
  /// button.
  ///
  /// {@macro flutter.material.InkWell.mouseCursor}
  ///
  /// If this property is null, [WidgetStateMouseCursor.adaptiveClickable] will be used.
  final MouseCursor? mouseCursor;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// this button's [items].
  ///
  /// {@macro flutter.material.InkWell.mouseCursor}
  ///
  /// If this property is null, [WidgetStateMouseCursor.adaptiveClickable] will be used.
  final MouseCursor? contentItemMouseCursor;

  final PushRadixSelectPopupContentRouteCallback<T>? pushPopupContentRoute;

  final PopRadixSelectPopupContentRouteCallback<T>? popPopupContentRoute;

  @override
  State<RadixSelect<T>> createState() => _RadixSelectState<T>();
}

class _RadixSelectState<T> extends State<RadixSelect<T>> with WidgetsBindingObserver {
  late RadixSelectDecorationVariantTheme decorationVariantTheme;
  late RadixSelectDecorationVariant decorationVariant;
  late RadixSelectDecorationVariantFactor size;

  late RadixInputDecoration effectiveDecoration;

  int? _selectedIndex;
  RadixSelectContentRoute<T>? _selectContentRoute;
  Orientation? _lastOrientation;
  FocusNode? _internalNode;
  FocusNode get focusNode => widget.focusNode ?? _internalNode!;
  late Map<Type, Action<Intent>> _actionMap;
  bool _isHovering = false;
  bool _hasPrimaryFocus = false;
  bool _isMenuExpanded = false;

  // Only used if needed to create _internalNode.
  FocusNode _createFocusNode() {
    return FocusNode(debugLabel: '${widget.runtimeType}');
  }

  ({
    RadixInputDecorationThemeData defaultDecoration,
    RadixSelectDecorationVariantTheme decorationVariantTheme
  }) _getDefaultDecoration() {
    RadixInputDecorationThemeData? defaultDecoration = RadixSelectDecorationTheme.of(context);
    RadixSelectDecorationVariantTheme? decorationVariantTheme;

    if (defaultDecoration == null) {
      final RadixThemeData? radixThemeData = RadixTheme.maybeOf(context);
      defaultDecoration = radixThemeData?.selectDecorationTheme;
      decorationVariantTheme = radixThemeData?.selectDecorationVariantTheme;
    } else {
      final RadixThemeData? radixThemeData = RadixTheme.maybeOf(context);
      decorationVariantTheme = radixThemeData?.selectDecorationVariantTheme;

      if (decorationVariantTheme == null) {
        final RadixThemeExtension radixThemeData = RadixTheme.fromTheme(context);
        decorationVariantTheme = radixThemeData.selectDecorationVariantTheme!;
      }
    }

    if (defaultDecoration == null) {
      final RadixThemeExtension radixThemeData = RadixTheme.fromTheme(context);
      defaultDecoration = radixThemeData.selectDecorationTheme!;
      decorationVariantTheme = radixThemeData.selectDecorationVariantTheme!;
    }

    return (defaultDecoration: defaultDecoration, decorationVariantTheme: decorationVariantTheme!);
  }

  Color? _getInputColor(RadixInputDecorationThemeData defaultDecoration) {
    final RadixInputDecoration? decoration = widget.inputDecoration;

    Color? color;
    if (widget.readOnly) {
      color = decoration?.readOnlyTextColor ?? defaultDecoration.readOnlyTextColor;
    } else if (!_enabled) {
      color = decoration?.disabledTextColor ?? defaultDecoration.disabledTextColor;
    }
    color ??= defaultDecoration.textColor ?? defaultDecoration.textColor;

    return color;
  }

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
    if (widget.focusNode == null) {
      _internalNode ??= _createFocusNode();
    }
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (ActivateIntent intent) => _handleTap(),
      ),
      ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
        onInvoke: (ButtonActivateIntent intent) => _handleTap(),
      ),
    };
    focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _removeDropdownRoute();
    focusNode.removeListener(_handleFocusChanged);
    _internalNode?.dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    if (_hasPrimaryFocus != focusNode.hasPrimaryFocus) {
      setState(() {
        _hasPrimaryFocus = focusNode.hasPrimaryFocus;
      });
    }
  }

  void _removeDropdownRoute() {
    if (widget.pushPopupContentRoute != null) {
      _selectContentRoute?._dismiss();
    }
    focusNode.unfocus();
    _isMenuExpanded = false;
    _selectContentRoute = null;
    _lastOrientation = null;
  }

  @override
  void didUpdateWidget(RadixSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChanged);
      if (_internalNode != null && widget.focusNode != null) {
        _internalNode!.dispose();
        _internalNode = null;
      }

      if (widget.focusNode == null) {
        _internalNode ??= _createFocusNode();
      }
      _hasPrimaryFocus = focusNode.hasPrimaryFocus;
      focusNode.addListener(_handleFocusChanged);
    }
  }

  void _updateSelectedIndex() {
    final List<RadixSelectItem<T>>? options = widget.options;
    final T? initialValue = widget.initialValue;
    if (options == null ||
        options.isEmpty ||
        initialValue == null) {
      _selectedIndex = null;
      return;
    }

    assert(
      options.where((RadixSelectItem<T> item) => item.value == initialValue).length == 1,
    );
    for (int itemIndex = 0; itemIndex < options.length; itemIndex++) {
      if (options[itemIndex].value == initialValue) {
        _selectedIndex = itemIndex;
        return;
      }
    }
  }

  void _handleTap() {
    final TextDirection textDirection = Directionality.of(context);
    /// The menu's width will match the button's width.
    ///
    /// If false (the default), then the dropdown's menu will be wider than
    /// its button. In either case the dropdown button will line up the leading
    /// edge of the menu's value with the leading edge of the values
    /// displayed by the menu items.
    // TODO
    // alignedDropdown;

    final NavigatorState navigator = Navigator.of(context);
    assert(_selectContentRoute == null);
    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect itemRect =
        itemBox.localToGlobal(Offset.zero, ancestor: navigator.context.findRenderObject()) &
        itemBox.size;
    final RadixSelectContentRoute<T> contentRoute = RadixSelectContentRoute<T>(
      items: widget.options!,
      buttonRect: itemRect,
      padding: size.contentPadding.resolve(textDirection),
      selectedIndex: _selectedIndex,
      initialScrollIndex: _selectedIndex ?? 0,
      capturedThemes: InheritedTheme.capture(from: context, to: navigator.context),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierDismissible: widget.barrierDismissible,
      itemHeight: size.itemHeight,
      hoveredItemBackgroundColor: decorationVariant.hoveredItemBackgroundColor,
      itemIndicatorWidth: size.itemIndicatorWidth,
      style: size.itemTextStyle,
      menuWidth: widget.menuWidth,
      isExpanded: widget.isExpanded,
      menuMaxHeight: widget.menuMaxHeight,
      indicatorIconSize: size.itemIndicatorIconSize,
      enableFeedback: widget.enableFeedback ?? true,
      contentDecoration: widget.contentDecoration,
      backgroundColor: decorationVariantTheme.contentBackgroundColor,
      borderRadius: size.contentBorderRadius,
      boxShadow: decorationVariantTheme.contentBoxShadow,
      contentItemMouseCursor: widget.contentItemMouseCursor,
      textDirection: textDirection,
    );
    _selectContentRoute = contentRoute;

    focusNode.requestFocus();
    widget.pushPopupContentRoute?.call(contentRoute) ?? navigator.push(contentRoute).then<void>(
      (RadixSelectRouteResult<T>? newValue) {
        _removeDropdownRoute();
        if (!mounted || newValue == null) {
          return;
        }
        widget.onChanged?.call(newValue.result);
        setState(() {
          _selectedIndex = newValue.itemIndex;
        });
    },
  );

    widget.onTap?.call();
    _isMenuExpanded = true;
  }

  bool get _enabled => widget.options != null && widget.options!.isNotEmpty && widget.onChanged != null;

  Orientation _getOrientation(BuildContext context) {
    Orientation? result = MediaQuery.maybeOrientationOf(context);
    if (result == null) {
      // If there's no MediaQuery, then use the view aspect to determine
      // orientation.
      final Size size = View.of(context).physicalSize;
      result = size.width > size.height ? Orientation.landscape : Orientation.portrait;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));

    final (
      :RadixInputDecorationThemeData defaultDecoration,
      :RadixSelectDecorationVariantTheme decorationVariantTheme
    ) = _getDefaultDecoration();

    late final Widget defaultSuffixIcon = Builder(
      builder: (context) {
        final IconThemeData iconTheme = IconTheme.of(context);

        return CustomPaint(
          painter: _RadixChevronDownIconPainter(
            color: iconTheme.color!,
          ),
          size: Size.square(iconTheme.size!),
        );
      },
    );

    this.decorationVariantTheme = decorationVariantTheme;
    decorationVariant = decorationVariantTheme[widget.variant];
    size = decorationVariantTheme.sizeSwatch[widget.size];

    effectiveDecoration = (
        widget.inputDecoration ??
        RadixInputDecoration.fromSelectVariant(
          variant: decorationVariant,
          size: size,
          suffixIcon: defaultSuffixIcon,
        )
      ).applyDefaults(defaultDecoration);

    if (effectiveDecoration.suffixIcon == null && effectiveDecoration.suffix == null) {
      effectiveDecoration = effectiveDecoration.copyWith(
        suffixIcon: defaultSuffixIcon,
      );
    }

    final Orientation newOrientation = _getOrientation(context);
    _lastOrientation ??= newOrientation;
    if (newOrientation != _lastOrientation) {
      _removeDropdownRoute();
      _lastOrientation = newOrientation;
    }

    final Set<WidgetState> states = <WidgetState>{
      if (!_enabled) WidgetState.disabled,
      if (_isHovering) WidgetState.hovered,
      if (_hasPrimaryFocus) WidgetState.focused,
    };

    final providedStyle = WidgetStateProperty.resolveAs(
      widget.inputDecoration?.textStyle,
      states,
    );
    final TextStyle textStyle = WidgetStateProperty.resolveAs(
      defaultDecoration.textStyle, states
    ).merge(providedStyle).copyWith(
      color: _getInputColor(defaultDecoration),
    );

    // Use a Text widget instead of SizedBox.shrink() so that
    // RadixInputDecorator can align the hint baseline
    // with the input text baseline when the input is empty.
    final Widget emptyWidget = Text('');

    Widget triggerInnerWidget;
    if (_selectedIndex case final int selectedIndex) {
      triggerInnerWidget = widget.options?[selectedIndex] ?? emptyWidget;
    } else {
      triggerInnerWidget = emptyWidget;
    }

    Widget result = DefaultTextStyle(
      style: textStyle,
      child: triggerInnerWidget,
    );

    final MouseCursor effectiveMouseCursor = WidgetStateProperty.resolveAs<MouseCursor>(
      WidgetStateMouseCursor.clickable,
      <WidgetState>{if (!_enabled) WidgetState.disabled},
    );

    result = Focus(
      canRequestFocus: _enabled,
      focusNode: focusNode,
      autofocus: widget.autofocus,
      child: MouseRegion(
        onEnter: (PointerEnterEvent event) {
          if (!_isHovering) {
            setState(() {
              _isHovering = true;
            });
          }
        },
        onExit: (PointerExitEvent event) {
          if (_isHovering) {
            setState(() {
              _isHovering = false;
            });
          }
        },
        cursor: effectiveMouseCursor,
        child: GestureDetector(
          onTap: _enabled ? _handleTap : null,
          behavior: HitTestBehavior.opaque,
          child: RadixInputDecorator(
            decoration: effectiveDecoration,
            affixIconPosition: AffixIconPosition.insideContent,
            expandWidth: widget.isExpanded,
            isEmpty: triggerInnerWidget == emptyWidget,
            enabled: _enabled,
            readOnly: widget.readOnly,
            isFocused: _hasPrimaryFocus,
            isHovering: _isHovering,
            getDefaultDecoration: (context) {
              RadixInputDecorationThemeData? defaultDecoration = RadixSelectDecorationTheme.of(context);

              if (defaultDecoration == null) {
                final RadixThemeData? radixThemeData = RadixTheme.maybeOf(context);
                defaultDecoration = radixThemeData?.selectDecorationTheme;
              }
              if (defaultDecoration == null) {
                final RadixThemeExtension radixThemeData = RadixTheme.fromTheme(context);
                defaultDecoration = radixThemeData.selectDecorationTheme!;
              }

              return defaultDecoration;
            },
            child: result,
          ),
        ),
      ),
    );

    final bool childHasButtonSemantic = _selectedIndex != null;
    return Semantics(
      button: !childHasButtonSemantic,
      expanded: _isMenuExpanded,
      child: Actions(actions: _actionMap, child: result),
    );
  }
}

/// A [FormField] that contains a [RadixSelect].
///
/// This is a convenience widget that wraps a [RadixSelect] widget in a
/// [FormField].
///
/// A [Form] ancestor is not required. The [Form] allows one to
/// save, reset, or validate multiple fields at once. To use without a [Form],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the form field.
///
/// The `value` parameter maps to [FormField.initialValue].
///
/// See also:
///
///  * [RadixSelect], which is the underlying text field without the [Form]
///    integration.
class RadixSelectFormField<T> extends FormField<T> {
  /// Creates a [RadixSelect] widget that is a [FormField], wrapped in an
  /// [InputDecorator].
  ///
  /// For a description of the `onSaved`, `validator`, or `autovalidateMode`
  /// parameters, see [FormField]. For the rest (other than [decoration]), see
  /// [RadixSelect].
  RadixSelectFormField({
    super.key,
    required List<RadixSelectItem<T>>? options,
    super.initialValue,
    RadixSelectSize size = RadixSelectSize.$2,
    RadixSelectVariant variant = RadixSelectVariant.surface,
    required this.onChanged,
    VoidCallback? onTap,
    double iconSize = 24.0,
    bool isExpanded = false,
    FocusNode? focusNode,
    bool autofocus = false,
    RadixInputDecoration? decoration,
    Decoration? contentDecoration,
    super.onSaved,
    super.validator,
    super.errorBuilder,
    super.forceErrorText,
    AutovalidateMode? autovalidateMode,
    double? menuMaxHeight,
    bool? enableFeedback,
    this.barrierDismissible = true,
    this.mouseCursor,
    this.contentItemMouseCursor,
    this.pushPopupContentRoute,
    this.popPopupContentRoute,
    // When adding new arguments, consider adding similar arguments to
    // DropdownButton.
  })  : assert(
          options == null ||
              options.isEmpty ||
              initialValue == null ||
              options
                      .where((RadixSelectItem<T> item) => item.value == initialValue)
                      .length ==
                  1,
          "There should be exactly one item with [DropdownButton]'s value: "
          '$initialValue. \n'
          'Either zero or 2 or more [DropdownMenuItem]s were detected '
          'with the same value',
        ),
        decoration = decoration ?? const RadixInputDecoration(),
        super(
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<T> field) {
            final _RadixSelectFormFieldState<T> state = field as _RadixSelectFormFieldState<T>;

            RadixInputDecorationThemeData? defaultDecoration = RadixSelectDecorationTheme.of(field.context);
            if (defaultDecoration == null) {
              final RadixThemeData? radixThemeData = RadixTheme.maybeOf(field.context);
              defaultDecoration = radixThemeData?.inputDecorationTheme;
            }
            if (defaultDecoration == null) {
              final ThemeData theme = Theme.of(field.context);
              final RadixInputDecorationThemeData decorationTheme = RadixSelectDecorationTheme.extensionFrom(theme);
              defaultDecoration = decorationTheme;
            }

            RadixInputDecoration effectiveDecoration = (decoration ?? const RadixInputDecoration())
                .applyDefaults(defaultDecoration);

            if (field.errorText != null) {
              final Widget? error = field.errorText != null && errorBuilder != null
                  ? errorBuilder(state.context, field.errorText!)
                  : null;
              final String? errorText = error == null ? field.errorText : null;

              effectiveDecoration = effectiveDecoration.copyWith(
                error: error,
                errorText: errorText,
              );
            }

            // An unfocusable Focus widget so that this widget can detect if its
            // descendants have focus or not.
            return Focus(
              canRequestFocus: false,
              skipTraversal: true,
              child: RadixSelect<T>._formField(
                options: options,
                initialValue: state.value,
                size: size,
                variant: variant,
                onChanged: onChanged == null ? null : state.didChange,
                onTap: onTap,
                iconSize: iconSize,
                isExpanded: isExpanded,
                focusNode: focusNode,
                autofocus: autofocus,
                menuMaxHeight: menuMaxHeight,
                enableFeedback: enableFeedback,
                inputDecoration: effectiveDecoration,
                contentDecoration: contentDecoration,
                barrierDismissible: barrierDismissible,
                mouseCursor: mouseCursor,
                contentItemMouseCursor: contentItemMouseCursor,
                pushPopupContentRoute: pushPopupContentRoute,
                popPopupContentRoute: popPopupContentRoute,
              ),
            );
          },
        );

  /// {@macro flutter.material.dropdownButton.onChanged}
  ///
  /// This callback is invoked after the parent [Form]'s [Form.onChanged] callback.
  /// The field's updated value is available in the [Form.onChanged] callback
  /// via [FormFieldState.value].
  final ValueChanged<T?>? onChanged;

  /// The decoration to show around the dropdown button form field.
  ///
  /// By default, draws a horizontal line under the dropdown button field but
  /// can be configured to show an icon, label, hint text, and error text.
  ///
  /// If not specified, an [InputDecorator] with the `focusColor` set to the
  /// supplied `focusColor` (if any) will be used.
  final RadixInputDecoration decoration;

  /// Determines whether tapping outside the dropdown will close it.
  ///
  /// Defaults to `true`.
  final bool barrierDismissible;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// dropdown button and its [DropdownMenuItem]s.
  ///
  /// {@macro flutter.material.InkWell.mouseCursor}
  ///
  /// If this property is null, [WidgetStateMouseCursor.adaptiveClickable] will be used.
  final MouseCursor? mouseCursor;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// this button's [DropdownMenuItem]s.
  ///
  /// {@macro flutter.material.InkWell.mouseCursor}
  ///
  /// If this property is null, [WidgetStateMouseCursor.adaptiveClickable] will be used.
  final MouseCursor? contentItemMouseCursor;

  final PushRadixSelectPopupContentRouteCallback<T>? pushPopupContentRoute;

  final PopRadixSelectPopupContentRouteCallback<T>? popPopupContentRoute;

  @override
  FormFieldState<T> createState() => _RadixSelectFormFieldState<T>();
}

class _RadixSelectFormFieldState<T> extends FormFieldState<T> {
  RadixSelectFormField<T> get _dropdownButtonFormField => widget as RadixSelectFormField<T>;

  @override
  void didChange(T? value) {
    super.didChange(value);
    _dropdownButtonFormField.onChanged?.call(value);
  }

  @override
  void didUpdateWidget(RadixSelectFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }

  @override
  void reset() {
    super.reset();
    _dropdownButtonFormField.onChanged?.call(value);
  }
}

class _RadixChevronDownIconPainter extends CustomPainter {
  _RadixChevronDownIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    path.moveTo(size.width*0.2090153,size.height*0.4105353);
    path.cubicTo(size.width*0.2216067,size.height*0.3971047,size.width*0.2427013,size.height*0.3964247,size.width*0.2561313,size.height*0.4090153);
    path.lineTo(size.width*0.5000000,size.height*0.6376427);
    path.lineTo(size.width*0.7438667,size.height*0.4090153);
    path.cubicTo(size.width*0.7573000,size.height*0.3964247,size.width*0.7783933,size.height*0.3971047,size.width*0.7909867,size.height*0.4105353);
    path.cubicTo(size.width*0.8035733,size.height*0.4239660,size.width*0.8028933,size.height*0.4450607,size.width*0.7894667,size.height*0.4576513);
    path.lineTo(size.width*0.5227980,size.height*0.7076533);
    path.cubicTo(size.width*0.5099760,size.height*0.7196733,size.width*0.4900240,size.height*0.7196733,size.width*0.4772020,size.height*0.7076533);
    path.lineTo(size.width*0.2105353,size.height*0.4576513);
    path.cubicTo(size.width*0.1971047,size.height*0.4450607,size.width*0.1964247,size.height*0.4239660,size.width*0.2090153,size.height*0.4105353);
    path.close();

    final Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_RadixChevronDownIconPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}

class _RadixCheckIconPainter extends CustomPainter {
  _RadixCheckIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    path.moveTo(size.width*0.7644600,size.height*0.2484560);
    path.cubicTo(size.width*0.7837200,size.height*0.2610493,size.width*0.7891267,size.height*0.2868720,size.width*0.7765333,size.height*0.3061320);
    path.lineTo(size.width*0.4931993,size.height*0.7394667);
    path.cubicTo(size.width*0.4865220,size.height*0.7496800,size.width*0.4757040,size.height*0.7564467,size.width*0.4636013,size.height*0.7579933);
    path.cubicTo(size.width*0.4514980,size.height*0.7595400,size.width*0.4393260,size.height*0.7557000,size.width*0.4302973,size.height*0.7474933);
    path.lineTo(size.width*0.2469640,size.height*0.5808273);
    path.cubicTo(size.width*0.2299367,size.height*0.5653480,size.width*0.2286820,size.height*0.5389960,size.width*0.2441613,size.height*0.5219687);
    path.cubicTo(size.width*0.2596407,size.height*0.5049413,size.width*0.2859927,size.height*0.5036860,size.width*0.3030200,size.height*0.5191660);
    path.lineTo(size.width*0.4501947,size.height*0.6529607);
    path.lineTo(size.width*0.7067867,size.height*0.2605280);
    path.cubicTo(size.width*0.7193800,size.height*0.2412680,size.width*0.7452000,size.height*0.2358633,size.width*0.7644600,size.height*0.2484560);
    path.close();

    final Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_RadixCheckIconPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
