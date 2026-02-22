import 'dart:math' as math;
import 'dart:ui';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'colors.dart';
import 'radius.dart';
import 'shadow.dart';
import 'space.dart';
import 'text_theme.dart';
import 'theme.dart';
import 'theme_data.dart';

// The amount of space by which to expand the thumb from the size of the currently
// selected child.
const EdgeInsets _kThumbInsets = EdgeInsets.symmetric(horizontal: 1);

// The amount of space by which to inset each separator.
const EdgeInsets _kSeparatorInset = EdgeInsets.symmetric(vertical: 3);
const double _kSeparatorWidth = 1;

class RadixSegmentedControlSizeSwatch {
  const RadixSegmentedControlSizeSwatch({
    required this.s1,
    required this.s2,
    required this.s3,
  });

  final RadixSegmentedControlStyleFactor s1;
  final RadixSegmentedControlStyleFactor s2;
  final RadixSegmentedControlStyleFactor s3;

  static final RadixSegmentedControlSizeSwatch kDefault = RadixSegmentedControlSizeSwatch(
    s1: RadixSegmentedControlStyleFactor(
      height: RadixSpace.kDefault.scale_5,
      itemPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_3,
      ),
      activeTextStyle: RadixTextTheme.kDefault.scale_1,
      inactiveTextStyle: RadixTextTheme.kDefault.scale_1.copyWith(
        fontVariations: RadixFigmaTextFontVariations.medium_510,
      ),
      gap: RadixSpace.kDefault.scale_1,
      cornerRadius: RadixRadiusFactor.kDefault.medium.swatch.scale_2,
    ),
    s2: RadixSegmentedControlStyleFactor(
      height: RadixSpace.kDefault.scale_6,
      itemPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_4,
      ),
      activeTextStyle: RadixTextTheme.kDefault.scale_2,
      inactiveTextStyle: RadixTextTheme.kDefault.scale_2.copyWith(
        fontVariations: RadixFigmaTextFontVariations.medium_510,
      ),
      gap: RadixSpace.kDefault.scale_2,
      cornerRadius: RadixRadiusFactor.kDefault.medium.swatch.scale_2,
    ),
    s3: RadixSegmentedControlStyleFactor(
      height: RadixSpace.kDefault.scale_7,
      itemPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_4,
      ),
      activeTextStyle: RadixTextTheme.kDefault.scale_3,
      inactiveTextStyle: RadixTextTheme.kDefault.scale_3.copyWith(
        fontVariations: RadixFigmaTextFontVariations.medium_510,
      ),
      gap: RadixSpace.kDefault.scale_3,
      cornerRadius: RadixRadiusFactor.kDefault.medium.swatch.scale_3,
    ),
  );

  /// Linearly interpolate between two [RadixSegmentedControlSizeSwatch]es.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixSegmentedControlSizeSwatch lerp(RadixSegmentedControlSizeSwatch a, RadixSegmentedControlSizeSwatch b, double t) {
    return RadixSegmentedControlSizeSwatch(
      s1: a.s1.lerp(b.s1, t),
      s2: a.s2.lerp(b.s2, t),
      s3: a.s3.lerp(b.s3, t),
    );
  }

  RadixSegmentedControlStyleFactor operator [](RadixSegmentedControlSize size) {
    return switch (size) {
      RadixSegmentedControlSize.$1 => s1,
      RadixSegmentedControlSize.$2 => s2,
      RadixSegmentedControlSize.$3 => s3,
    };
  }
}

class RadixSegmentedControlThemeData {
  const RadixSegmentedControlThemeData({
    required this.textColor,
    this.disabledTextColor,
    required this.separatorColor,
    required this.backgroundColor,
    this.disabledBackgroundColor,
    this.gradient,
    required this.hoveredItemBackgroundColor,
    required this.indicatorBackgroundColor,
    this.indicatorDisabledBackgroundColor,
    this.surfaceIndicatorBorderSide = BorderSide.none,
    this.classicIndicatorBorderSide = BorderSide.none,
    this.indicatorDisabledBorderSide = BorderSide.none,
    this.surfaceIndicatorShadows = const [],
    required this.classicIndicatorShadows,
    this.indicatorTransitionDuration = const Duration(milliseconds: 100),
    Duration? transitionDuration,
    required this.sizeSwatch,
  }) : transitionDuration = transitionDuration ?? (indicatorTransitionDuration * 0.8);

  final Color textColor;
  final Color? disabledTextColor;

  final Color separatorColor;

  /// The color used to paint the rounded rect behind
  /// the [RadixSegmentedControl.children] and the separators.
  final Color backgroundColor;

  final Color? disabledBackgroundColor;

  /// A gradient to use when filling the rounded rect behind
  /// the [RadixSegmentedControl.children] and the separators.
  final Gradient? gradient;

  final Color hoveredItemBackgroundColor;

  final Color indicatorBackgroundColor;
  final Color? indicatorDisabledBackgroundColor;

  final BorderSide surfaceIndicatorBorderSide;
  final BorderSide classicIndicatorBorderSide;
  final BorderSide indicatorDisabledBorderSide;

  final List<BoxShadow> surfaceIndicatorShadows;
  final List<BoxShadow> classicIndicatorShadows;

  final Duration indicatorTransitionDuration;

  final Duration transitionDuration;

  final RadixSegmentedControlSizeSwatch sizeSwatch;

  static final RadixSegmentedControlThemeData kWebCssLight = RadixSegmentedControlThemeData(
    textColor: RadixColorScheme.kWebCssLight.gray.scale_12,
    disabledTextColor: RadixColorScheme.kWebCssLight.gray.radixScale_8.alphaVariant,
    separatorColor: RadixColorScheme.kWebCssLight.gray.radixScale_4.alphaVariant,
    backgroundColor: RadixColorScheme.kWebCssLight.surfaceColor,
    disabledBackgroundColor: RadixColorScheme.kWebCssLight.gray.scale_3,
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        RadixColorScheme.kWebCssLight.gray.radixScale_3.alphaVariant,
        RadixColorScheme.kWebCssLight.gray.radixScale_3.alphaVariant,
      ],
      stops: [0, 1],
    ),
    hoveredItemBackgroundColor: RadixColorScheme.kWebCssLight.gray.radixScale_2.alphaVariant,
    indicatorBackgroundColor: RadixColorScheme.kWebCssLight.backgroundColor,
    indicatorDisabledBackgroundColor: RadixColorScheme.kWebCssLight.gray.radixScale_3.alphaVariant,
    surfaceIndicatorBorderSide: BorderSide(
      width: 1,
      color: RadixColorScheme.kWebCssLight.gray.scale_12, // inherit
    ),
    surfaceIndicatorShadows: [
      BoxShadow(
        offset: Offset.zero,
        blurRadius: 0,
        spreadRadius: 1,
        color: RadixColorScheme.kWebCssLight.gray.radixScale_4.alphaVariant,
      ),
    ],
    classicIndicatorShadows: RadixShadowSwatch.kWebCssLight.scale_2,
    indicatorTransitionDuration: const Duration(milliseconds: 100),
    sizeSwatch: RadixSegmentedControlSizeSwatch.kDefault,
  );

  static final RadixSegmentedControlThemeData kWebCssDark = RadixSegmentedControlThemeData(
    textColor: RadixColorScheme.kWebCssDark.gray.scale_12,
    disabledTextColor: RadixColorScheme.kWebCssDark.gray.radixScale_8.alphaVariant,
    separatorColor: RadixColorScheme.kWebCssDark.gray.radixScale_4.alphaVariant,
    backgroundColor: RadixColorScheme.kWebCssDark.surfaceColor,
    disabledBackgroundColor: RadixColorScheme.kWebCssDark.gray.scale_3,
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        RadixColorScheme.kWebCssDark.gray.radixScale_3.alphaVariant,
        RadixColorScheme.kWebCssDark.gray.radixScale_3.alphaVariant,
      ],
      stops: [0, 1],
    ),
    hoveredItemBackgroundColor: RadixColorScheme.kWebCssDark.gray.radixScale_2.alphaVariant,
    indicatorBackgroundColor: RadixColorScheme.kWebCssDark.gray.radixScale_3.alphaVariant,
    indicatorDisabledBackgroundColor: RadixColorScheme.kWebCssDark.gray.radixScale_3.alphaVariant,
    surfaceIndicatorBorderSide: BorderSide(
      width: 1,
      color: RadixColorScheme.kWebCssDark.gray.scale_12, // inherit
    ),
    surfaceIndicatorShadows: [
      BoxShadow(
        offset: Offset.zero,
        blurRadius: 0,
        spreadRadius: 1,
        color: RadixColorScheme.kWebCssDark.gray.radixScale_4.alphaVariant,
      ),
    ],
    classicIndicatorShadows: RadixShadowSwatch.kWebCssDark.scale_2,
    indicatorTransitionDuration: const Duration(milliseconds: 100),
    sizeSwatch: RadixSegmentedControlSizeSwatch.kDefault,
  );

  static final RadixSegmentedControlThemeData kFigmaLight = RadixSegmentedControlThemeData(
    textColor: RadixColorScheme.kLight.neutral.radixScale_12.alphaVariant,
    backgroundColor: RadixColorScheme.kLight.surfaceColor,
    separatorColor: RadixColorScheme.kLight.neutral.radixScale_4.alphaVariant,
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
        RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
      ],
      stops: [0, 1],
    ),
    // The Figma design does not specify hovered color for item
    hoveredItemBackgroundColor: RadixColorScheme.kLight.neutral.radixScale_2.alphaVariant,
    indicatorBackgroundColor: RadixColorScheme.kLight.pageBackgroundColor,
    surfaceIndicatorBorderSide: BorderSide(
      width: 1,
      color: RadixColorScheme.kLight.neutral.radixScale_4.alphaVariant,
    ),
    classicIndicatorShadows: RadixShadowSwatch.kLight.scale_2,
    indicatorTransitionDuration: const Duration(milliseconds: 100),
    sizeSwatch: RadixSegmentedControlSizeSwatch.kDefault,
  );

  static final RadixSegmentedControlThemeData kFigmaDark = RadixSegmentedControlThemeData(
    textColor: RadixColorScheme.kDark.neutral.radixScale_12.alphaVariant,
    backgroundColor: RadixColorScheme.kDark.surfaceColor,
    separatorColor: RadixColorScheme.kDark.neutral.radixScale_4.alphaVariant,
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
        RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
      ],
      stops: [0, 1],
    ),
    // The Figma design does not specify hovered color for item
    hoveredItemBackgroundColor: RadixColorScheme.kDark.neutral.radixScale_2.alphaVariant,
    indicatorBackgroundColor: RadixColorScheme.kDark.pageBackgroundColor,
    surfaceIndicatorBorderSide: BorderSide(
      width: 1,
      color: RadixColorScheme.kDark.neutral.radixScale_4.alphaVariant,
    ),
    classicIndicatorShadows: RadixShadowSwatch.kDark.scale_2,
    indicatorTransitionDuration: const Duration(milliseconds: 100),
    sizeSwatch: RadixSegmentedControlSizeSwatch.kDefault,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return super == other &&
           other is RadixSegmentedControlThemeData &&
           other.textColor == textColor &&
           other.disabledTextColor == disabledTextColor &&
           other.backgroundColor == backgroundColor &&
           other.disabledBackgroundColor == disabledBackgroundColor &&
           other.gradient == gradient &&
           other.hoveredItemBackgroundColor == hoveredItemBackgroundColor &&
           other.indicatorBackgroundColor == indicatorBackgroundColor &&
           other.indicatorDisabledBackgroundColor == indicatorDisabledBackgroundColor &&
           other.surfaceIndicatorBorderSide == surfaceIndicatorBorderSide &&
           other.classicIndicatorBorderSide == classicIndicatorBorderSide &&
           other.indicatorDisabledBorderSide == indicatorDisabledBorderSide &&
           other.surfaceIndicatorShadows == surfaceIndicatorShadows &&
           other.classicIndicatorShadows == classicIndicatorShadows &&
           other.indicatorTransitionDuration == indicatorTransitionDuration &&
           other.transitionDuration == transitionDuration &&
           other.sizeSwatch == sizeSwatch;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    textColor,
    disabledTextColor,
    backgroundColor,
    disabledBackgroundColor,
    gradient,
    hoveredItemBackgroundColor,
    indicatorBackgroundColor,
    indicatorDisabledBackgroundColor,
    surfaceIndicatorBorderSide,
    classicIndicatorBorderSide,
    indicatorDisabledBorderSide,
    surfaceIndicatorShadows,
    classicIndicatorShadows,
    indicatorTransitionDuration,
    transitionDuration,
    sizeSwatch,
  );

  /// Linearly interpolate between two [RadixSegmentedControlThemeData]s.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixSegmentedControlThemeData? lerp(RadixSegmentedControlThemeData? a, RadixSegmentedControlThemeData? b, double t) {
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

    return RadixSegmentedControlThemeData(
      textColor: Color.lerp(a?.textColor, b?.textColor, t)!,
      disabledTextColor: Color.lerp(a?.disabledTextColor, b?.disabledTextColor, t),
      separatorColor: Color.lerp(a?.separatorColor, b?.separatorColor, t)!,
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t)!,
      disabledBackgroundColor: Color.lerp(a?.disabledBackgroundColor, b?.disabledBackgroundColor, t),
      gradient: Gradient.lerp(a?.gradient, b?.gradient, t),
      hoveredItemBackgroundColor: Color.lerp(a?.hoveredItemBackgroundColor, b?.hoveredItemBackgroundColor, t)!,
      indicatorBackgroundColor: Color.lerp(a?.indicatorBackgroundColor, b?.indicatorBackgroundColor, t)!,
      indicatorDisabledBackgroundColor: Color.lerp(a?.indicatorDisabledBackgroundColor, b?.indicatorDisabledBackgroundColor, t)!,
      surfaceIndicatorBorderSide: BorderSide.lerp(a!.surfaceIndicatorBorderSide, b!.surfaceIndicatorBorderSide, t),
      classicIndicatorBorderSide: BorderSide.lerp(a.classicIndicatorBorderSide, b.classicIndicatorBorderSide, t),
      indicatorDisabledBorderSide: BorderSide.lerp(a.indicatorDisabledBorderSide, b.indicatorDisabledBorderSide, t),
      surfaceIndicatorShadows: BoxShadow.lerpList(a.surfaceIndicatorShadows, b.surfaceIndicatorShadows, t)!,
      classicIndicatorShadows: BoxShadow.lerpList(a.classicIndicatorShadows, b.classicIndicatorShadows, t)!,
      indicatorTransitionDuration: t < 0.5 ? a.indicatorTransitionDuration : b.indicatorTransitionDuration,
      transitionDuration: t < 0.5 ? a.transitionDuration : b.transitionDuration,
      sizeSwatch: RadixSegmentedControlSizeSwatch.lerp(a.sizeSwatch, b.sizeSwatch, t),
    );
  }

  /// The [RadixThemeData.segmentedControlTheme] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).segmentedControlTheme`.
  static RadixSegmentedControlThemeData? of(BuildContext context) => RadixTheme.of(context).segmentedControlTheme;

  /// The [RadixThemeExtension.segmentedControlTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).segmentedControlTheme`.
  static RadixSegmentedControlThemeData? fromTheme(BuildContext context) => RadixTheme.fromTheme(context).segmentedControlTheme;

  /// The [RadixThemeExtension.segmentedControlTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).segmentedControlTheme`.
  static RadixSegmentedControlThemeData? extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).segmentedControlTheme;
}

class RadixSegmentedControlStyleFactor {
  RadixSegmentedControlStyleFactor({
    required this.height,
    required this.itemPadding,
    required this.cornerRadius,
    required this.activeTextStyle,
    required this.inactiveTextStyle,
    this.textScaleFactor,
    this.textScaler,
    this.gap = 0.0,
  });

  final double height;

  final EdgeInsets itemPadding;

  final Radius cornerRadius;

  final TextStyle activeTextStyle;
  final TextStyle inactiveTextStyle;

  @Deprecated(
    'Use textScaler instead. '
    'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
    'This feature was deprecated after v3.12.0-2.0.pre.',
  )
  final double? textScaleFactor;

  final TextScaler? textScaler;

  final double gap;

  /// Linearly interpolate between two [RadixSegmentedControlStyleFactor]s.
  ///
  /// {@macro dart.ui.shadow.lerp}
  RadixSegmentedControlStyleFactor lerp(RadixSegmentedControlStyleFactor other, double t) {
    return RadixSegmentedControlStyleFactor(
      height: lerpDouble(height, other.height, t)!,
      itemPadding: EdgeInsets.lerp(itemPadding, other.itemPadding, t)!,
      cornerRadius: Radius.lerp(cornerRadius, other.cornerRadius, t)!,
      activeTextStyle: TextStyle.lerp(activeTextStyle, other.activeTextStyle, t)!,
      inactiveTextStyle: TextStyle.lerp(inactiveTextStyle, other.inactiveTextStyle, t)!,
      textScaleFactor: lerpDouble(textScaleFactor, other.textScaleFactor, t),
      textScaler: t < 0.5 ? textScaler : other.textScaler,
      gap: lerpDouble(gap, other.gap, t)!,
    );
  }
}

class RadixSegmentedControlStyle extends RadixSegmentedControlStyleFactor {
  RadixSegmentedControlStyle({
    this.debugVariant,
    this.debugSize,
    required super.height,
    required this.separatorColor,
    required this.backgroundColor,
    required this.gradient,
    required super.itemPadding,
    required super.cornerRadius,
    required this.shape,
    required super.activeTextStyle,
    required super.inactiveTextStyle,
    required this.textColor,
    super.textScaleFactor,
    super.textScaler,
    super.gap,
    required this.hoveredItemBackgroundColor,
    required this.indicatorBackgroundColor,
    required this.indicatorSide,
    required this.indicatorShadow,
    required this.seperatorOpacityAnimationDuration,
    required this.highlightAnimationDuration,
  });

  final RadixSegmentedControlVariant? debugVariant;
  final RadixSegmentedControlSize? debugSize;

  final Color separatorColor;

  final WidgetStateProperty<Color?> backgroundColor;

  final Gradient? gradient;

  final ShapeBorder shape;

  final WidgetStateProperty<Color?> textColor;

  final Color hoveredItemBackgroundColor;

  final WidgetStateProperty<Color?> indicatorBackgroundColor;
  final WidgetStateProperty<BorderSide?> indicatorSide;
  final List<BoxShadow> indicatorShadow;

  final Duration seperatorOpacityAnimationDuration;
  final Duration highlightAnimationDuration;

  factory RadixSegmentedControlStyle.from(
    RadixSegmentedControlThemeData segmentedControlTheme,
    RadixSegmentedControlVariant variant,
    RadixSegmentedControlSize size, {
    Radius? cornerRadius,
  }) {
    final RadixSegmentedControlSizeSwatch sizeSwatch = segmentedControlTheme.sizeSwatch;

    final RadixSegmentedControlStyleFactor factor = switch (size) {
      RadixSegmentedControlSize.$1 => sizeSwatch.s1,
      RadixSegmentedControlSize.$2 => sizeSwatch.s2,
      RadixSegmentedControlSize.$3 => sizeSwatch.s3,
    };

    return RadixSegmentedControlStyle(
      debugVariant: variant,
      debugSize: size,
      height: factor.height,
      separatorColor: segmentedControlTheme.separatorColor,
      backgroundColor: WidgetStateProperty.fromMap({
        WidgetState.disabled: segmentedControlTheme.disabledBackgroundColor,
        WidgetState.any: segmentedControlTheme.backgroundColor,
      }),
      gradient: segmentedControlTheme.gradient,
      itemPadding: factor.itemPadding,
      cornerRadius: cornerRadius ?? factor.cornerRadius,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          cornerRadius ?? factor.cornerRadius,
        ),
      ),
      activeTextStyle: factor.activeTextStyle,
      inactiveTextStyle: factor.inactiveTextStyle,
      textColor: WidgetStateProperty.fromMap({
        WidgetState.disabled: segmentedControlTheme.disabledTextColor,
        WidgetState.any: segmentedControlTheme.textColor,
      }),
      hoveredItemBackgroundColor: segmentedControlTheme.hoveredItemBackgroundColor,
      indicatorBackgroundColor: WidgetStateMapper({
        WidgetState.disabled: segmentedControlTheme.indicatorDisabledBackgroundColor,
        WidgetState.any: segmentedControlTheme.indicatorBackgroundColor,
      }),
      indicatorSide: WidgetStateMapper({
        WidgetState.disabled: segmentedControlTheme.indicatorDisabledBorderSide,
        WidgetState.any: switch (variant) {
          RadixSegmentedControlVariant.surface => segmentedControlTheme.surfaceIndicatorBorderSide,
          RadixSegmentedControlVariant.classic => segmentedControlTheme.classicIndicatorBorderSide,
        },
      }),
      indicatorShadow: switch (variant) {
        RadixSegmentedControlVariant.surface => segmentedControlTheme.surfaceIndicatorShadows,
        RadixSegmentedControlVariant.classic => segmentedControlTheme.classicIndicatorShadows,
      },
      textScaleFactor: factor.textScaleFactor,
      textScaler: factor.textScaler,
      gap: factor.gap,
      seperatorOpacityAnimationDuration: segmentedControlTheme.transitionDuration,
      highlightAnimationDuration: segmentedControlTheme.transitionDuration,
    );
  }
}

class _Segment<T> extends StatefulWidget {
  const _Segment({
    required ValueKey<T> key,
    required this.child,
    required this.pressed,
    required this.highlighted,
    required this.enabled,
    required this.segmentLocation,
    required this.padding,
    required this.hoveredBackgroundColor,
    required this.borderRadius,
    required this.activeTextStyle,
    required this.inactiveTextStyle,
    required this.textColor,
    required this.highlightAnimationDuration,
  }) : super(key: key);

  final Widget child;

  final bool pressed;
  final bool highlighted;
  final bool enabled;
  final _SegmentLocation segmentLocation;

  final EdgeInsets padding;
  final Color hoveredBackgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle activeTextStyle;
  final TextStyle inactiveTextStyle;
  final Color? textColor;

  final Duration highlightAnimationDuration;

  bool get shouldFadeoutContent => pressed && !highlighted && enabled;

  @override
  State<_Segment<T>> createState() => _SegmentState<T>();
}

class _SegmentState<T> extends State<_Segment<T>> {
  final ValueNotifier<bool> _hovering = ValueNotifier(false);

  void _handleHoverEnter(PointerEnterEvent event) {
    switch (event.kind) {
      case PointerDeviceKind.mouse:
      case PointerDeviceKind.trackpad:
        if (widget.enabled) {
          _hovering.value = true;
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
        _hovering.value = false;
      case PointerDeviceKind.stylus:
      case PointerDeviceKind.invertedStylus:
      case PointerDeviceKind.unknown:
      case PointerDeviceKind.touch:
        break;
    }
  }

  @override
  void dispose() {
    _hovering.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget child = Padding(
      padding: widget.padding,
      child: IndexedStack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedDefaultTextStyle(
            style: DefaultTextStyle.of(context).style.merge(
              widget.highlighted ? widget.activeTextStyle : widget.inactiveTextStyle,
            ).copyWith(color: widget.textColor),
            duration: widget.highlightAnimationDuration,
            curve: widget.highlighted ? Curves.easeIn : Curves.easeOut,
            child: widget.child,
          ),
          // The entire widget will assume the size of this widget, so when a
          // segment's "highlight" animation plays the size of the parent stays
          // the same and will always be greater than equal to that of the
          // visible child (at index 0), to keep the size of the entire
          // SegmentedControl widget consistent throughout the animation.
          DefaultTextStyle.merge(
            style: widget.activeTextStyle,
            child: widget.child,
          ),
        ],
      ),
    );

    return MouseRegion(
      cursor: kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: widget.enabled ? _handleHoverEnter : null,
      onExit: widget.enabled ? _handleHoverExit : null,
      child: MetaData(
        // Expand the hitTest area of this widget.
        behavior: HitTestBehavior.opaque,
        child: ValueListenableBuilder(
          valueListenable: _hovering,
          builder: (context, hovering, _) {
            if (!hovering && !widget.pressed) return child;

            if (widget.borderRadius case final BorderRadiusGeometry borderRadius) {
              return DecoratedBox(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(borderRadius: borderRadius),
                  color: widget.hoveredBackgroundColor,
                ),
                child: child,
              );
            }

            return ColoredBox(
              color: widget.hoveredBackgroundColor,
              child: child,
            );
          },
        ),
      ),
    );
  }
}

// Fadeout the separator when either adjacent segment is highlighted.
class _SegmentSeparator extends StatefulWidget {
  const _SegmentSeparator({
    required ValueKey<int> key,
    required this.highlighted,
    required this.color,
    required this.opacityAnimationDuration,
  }) : super(key: key);

  final bool highlighted;
  final Color color;
  final Duration opacityAnimationDuration;

  @override
  _SegmentSeparatorState createState() => _SegmentSeparatorState();
}

class _SegmentSeparatorState extends State<_SegmentSeparator>
    with TickerProviderStateMixin<_SegmentSeparator> {
  late final AnimationController separatorOpacityController;
  late final CurvedAnimation separatorOpacityAnimation;

  @override
  void initState() {
    super.initState();

    separatorOpacityController = AnimationController(
      duration: widget.opacityAnimationDuration,
      value: widget.highlighted ? 0 : 1,
      vsync: this,
    );

    separatorOpacityAnimation = CurvedAnimation(
      parent: separatorOpacityController,
      // Make separators slow to disappear and fast to appear,
      // syncing it well with the indicator motion
      curve: Curves.easeOut,
    );
  }

  @override
  void didUpdateWidget(_SegmentSeparator oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(oldWidget.key == widget.key);

    if (oldWidget.highlighted != widget.highlighted) {
      separatorOpacityController.animateTo(
        widget.highlighted ? 0 : 1,
        duration: widget.opacityAnimationDuration,
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void dispose() {
    separatorOpacityAnimation.dispose();
    separatorOpacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: separatorOpacityController,
      child: const SizedBox(width: _kSeparatorWidth),
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: _kSeparatorInset,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: widget.color.withOpacity(
                widget.color.opacity * separatorOpacityController.value,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}

/// A wrapper widget that implements RadioClient for each segment button
/// in sliding segmented control.
class _SlidingSegmentButton<T> extends StatefulWidget {
  const _SlidingSegmentButton({
    super.key,
    required this.value,
    required this.child,
    required this.enabled,
  });

  final T value;
  final Widget child;
  final bool enabled;

  @override
  State<_SlidingSegmentButton<T>> createState() => _SlidingSegmentButtonState<T>();
}

class _SlidingSegmentButtonState<T> extends State<_SlidingSegmentButton<T>> with RadioClient<T> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(debugLabel: 'RadixSegmentedControl<$T>[${widget.value}]');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    registry = widget.enabled ? RadioGroup.maybeOf<T>(context) : null;
  }

  @override
  void didUpdateWidget(_SlidingSegmentButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      registry = widget.enabled ? RadioGroup.maybeOf<T>(context) : null;
    }
  }

  @override
  void dispose() {
    registry = null;
    _focusNode.dispose();
    super.dispose();
  }

  @override
  T get radioValue => widget.value;

  @override
  FocusNode get focusNode => _focusNode;

  @override
  bool get tristate => false;

  void requestFocus() {
    if (widget.enabled) {
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      canRequestFocus: widget.enabled,
      onKeyEvent: (FocusNode node, KeyEvent event) => KeyEventResult.ignored,
      child: widget.child,
    );
  }
}

enum RadixSegmentedControlSize {
  $1, $2, $3
}

enum RadixSegmentedControlVariant {
  surface, classic
}

/// A Radix-style segmented control.
///
/// Toggle buttons for switching between different values or views.
///
/// Displays the widgets provided in the [Map] of [children] in a horizontal list.
/// It allows the user to select between a number of mutually exclusive options,
/// by tapping or dragging within the segmented control.
///
/// A segmented control can feature any [Widget] as one of the values in its
/// [Map] of [children]. The type T is the type of the [Map] keys used to identify
/// each widget and determine which widget is selected. As required by the [Map]
/// class, keys must be of consistent types and must be comparable. The [children]
/// argument must be an ordered [Map] such as a [LinkedHashMap], the ordering of
/// the keys will determine the order of the widgets in the segmented control.
///
/// The widget calls the [onValueChanged] callback *when a valid user gesture
/// completes on an unselected segment*. The map key associated with the newly
/// selected widget is returned in the [onValueChanged] callback. Typically,
/// widgets that use a segmented control will listen for the [onValueChanged]
/// callback and rebuild the segmented control with a new [groupValue] to update
/// which option is currently selected.
///
/// The [children] will be displayed in the order of the keys in the [Map],
/// along the current [TextDirection]. Each child widget will have the same size.
/// The height of the segmented control is determined by the height of the
/// tallest child widget. The width of each child will be the intrinsic width of
/// the widest child, or the available horizontal space divided by the number of
/// [children], which ever is smaller.
///
/// {@tool dartpad}
/// This example shows a [RadixSegmentedControl] with an enum type.
///
/// The callback provided to [onValueChanged] should update the state of
/// the parent [StatefulWidget] using the [State.setState] method, so that
/// the parent gets rebuilt; for example:
///
/// ** See code in example/lib/segmented_control/segmented_control.0.dart **
/// {@end-tool}
/// See also:
///
///  * <https://www.radix-ui.com/themes/docs/components/segmented-control/>
class RadixSegmentedControl<T extends Object> extends StatefulWidget {
  /// Creates a Radix-style segmented control bar.
  ///
  /// The [children] argument must be an ordered [Map] such as a
  /// [LinkedHashMap]. Further, the length of the [children] list must be
  /// greater than one.
  ///
  /// Each widget value in the map of [children] must have an associated key
  /// that uniquely identifies this widget. This key is what will be returned
  /// in the [onValueChanged] callback when a new value from the [children] map
  /// is selected.
  ///
  /// The [groupValue] is the currently selected value for the segmented control.
  /// If no [groupValue] is provided, or the [groupValue] is null, no widget will
  /// appear as selected. The [groupValue] must be either null or one of the keys
  /// in the [children] map.
  RadixSegmentedControl({
    super.key,
    required this.children,
    required this.onValueChanged,
    this.disabledChildren = const <Never>{},
    this.groupValue,
    this.variant = RadixSegmentedControlVariant.surface,
    this.size = RadixSegmentedControlSize.$2,
    this.cornerRadius,
    this.proportionalWidth = false,
  }) : assert(children.length >= 2),
       assert(
         groupValue == null || children.keys.contains(groupValue),
         'The groupValue must be either null or one of the keys in the children map.',
       );

  /// The identifying keys and corresponding widget values in the
  /// segmented control.
  ///
  /// This attribute must be an ordered [Map] such as a [LinkedHashMap]. Each
  /// widget is typically a single-line [Text] widget or an [Icon] widget.
  ///
  /// The map must have more than one entry.
  final Map<T, Widget> children;

  /// The set of identifying keys that correspond to the segments that should be
  /// disabled.
  ///
  /// Disabled children cannot be selected by dragging, but they can be selected
  /// programmatically. For example, if the [groupValue] is set to a disabled
  /// segment, the segment is still selected but the segment content looks disabled.
  ///
  /// If an enabled segment is selected by dragging gesture and becomes disabled
  /// before dragging finishes, [onValueChanged] will be triggered when finger is
  /// released and the disabled segment is selected.
  ///
  /// By default, all segments are selectable.
  final Set<T> disabledChildren;

  /// The identifier of the widget that is currently selected.
  ///
  /// This must be one of the keys in the [Map] of [children].
  /// If this attribute is null, no widget will be initially selected.
  final T? groupValue;

  /// The callback that is called when a new option is tapped.
  ///
  /// The segmented control passes the newly selected widget's associated key
  /// to the callback but does not actually change state until the parent
  /// widget rebuilds the segmented control with the new [groupValue].
  ///
  /// The callback provided to [onValueChanged] should update the state of
  /// the parent [StatefulWidget] using the [State.setState] method, so that
  /// the parent gets rebuilt; for example:
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// class SegmentedControlExample extends StatefulWidget {
  ///   const SegmentedControlExample({super.key});
  ///
  ///   @override
  ///   State createState() => SegmentedControlExampleState();
  /// }
  ///
  /// class SegmentedControlExampleState extends State<SegmentedControlExample> {
  ///   final Map<int, Widget> children = const <int, Widget>{
  ///     0: Text('Child 1'),
  ///     1: Text('Child 2'),
  ///   };
  ///
  ///   int? currentValue;
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return RadixSegmentedControl<int>(
  ///       children: children,
  ///       onValueChanged: (int? newValue) {
  ///         setState(() {
  ///           currentValue = newValue;
  ///         });
  ///       },
  ///       groupValue: currentValue,
  ///     );
  ///   }
  /// }
  /// ```
  /// {@end-tool}
  final ValueChanged<T?> onValueChanged;

  final RadixSegmentedControlVariant variant;

  final RadixSegmentedControlSize size;

  final Radius? cornerRadius;

  /// Determine whether segments have proportional widths based on their content.
  ///
  /// If false, all segments will have the same width, determined by the longest
  /// segment. If true, each segment's width will be determined by its individual
  /// content.
  ///
  /// If the max width of parent constraints is smaller than the width that the
  /// segmented control needs, The segment widths will scale down proportionally
  /// to ensure the segment control fits within the boundaries; similarly, if
  /// the min width of parent constraints is larger, the segment width will scales
  /// up to meet the min width requirement.
  ///
  /// Defaults to false.
  final bool proportionalWidth;

  @override
  State<RadixSegmentedControl<T>> createState() => _RadixSegmentedControlState<T>();
}

class _RadixSegmentedControlState<T extends Object> extends State<RadixSegmentedControl<T>>
    with TickerProviderStateMixin<RadixSegmentedControl<T>> {
  late RadixSegmentedControlStyle _style;

  late final AnimationController thumbController = AnimationController(
    value: 0,
    vsync: this,
  );
  Animatable<Rect?>? thumbAnimatable;

  final TapGestureRecognizer tap = TapGestureRecognizer();
  final LongPressGestureRecognizer longPress = LongPressGestureRecognizer();
  final GlobalKey segmentedControlRenderWidgetKey = GlobalKey();
  final Map<T, GlobalKey<_SlidingSegmentButtonState<T>>> _segmentKeys =
      <T, GlobalKey<_SlidingSegmentButtonState<T>>>{};

  @override
  void initState() {
    super.initState();

    // If the long press or horizontal drag recognizer gets accepted, we know for
    // sure the gesture is meant for the segmented control. Hand everything to
    // the drag gesture recognizer.
    final GestureArenaTeam team = GestureArenaTeam();
    longPress.team = team;

    tap
      ..onTapDown = onTapDown
      ..onTapUp = onTapUp
      ..onTapCancel = onTapCancel;

    // Empty callback to enable the long press recognizer.
    longPress.onLongPress = () {};

    highlighted = widget.groupValue;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final RadixSegmentedControlThemeData segmentedControlTheme;

    final RadixThemeData? radixThemeData = RadixTheme.maybeOf(context);
    if (radixThemeData != null) {
      segmentedControlTheme = radixThemeData.segmentedControlTheme!;
    } else {
      final ThemeData theme = Theme.of(context);
      segmentedControlTheme = RadixSegmentedControlThemeData.extensionFrom(theme)!;
    }

    _style = RadixSegmentedControlStyle.from(
      segmentedControlTheme,
      widget.variant,
      widget.size,
      cornerRadius: widget.cornerRadius,
    );

    thumbController.duration = segmentedControlTheme.indicatorTransitionDuration;
  }

  @override
  void didUpdateWidget(RadixSegmentedControl<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Temporarily ignore highlight changes from the widget when the thumb is
    // being dragged. When the drag gesture finishes the widget will be forced
    // to build (see the onEnd method), and didUpdateWidget will be called again.
    if (highlighted != widget.groupValue) {
      thumbController
        ..stop()
        ..forward(from: 0.0);
      thumbAnimatable = null;
      highlighted = widget.groupValue;
    }
  }

  @override
  void dispose() {
    thumbController.dispose();

    tap.dispose();
    longPress.dispose();

    super.dispose();
  }

  // Converts local coordinate to segments.
  T segmentForXPosition(double dx) {
    final BuildContext currentContext = segmentedControlRenderWidgetKey.currentContext!;
    final _RenderSegmentedControl<T> renderBox =
        currentContext.findRenderObject()! as _RenderSegmentedControl<T>;

    final int numOfChildren = widget.children.length;
    assert(renderBox.hasSize);
    assert(numOfChildren >= 2);

    int segmentIndex = renderBox.getClosestSegmentIndex(dx);

    switch (Directionality.of(context)) {
      case TextDirection.ltr:
        break;
      case TextDirection.rtl:
        segmentIndex = numOfChildren - 1 - segmentIndex;
    }
    return widget.children.keys.elementAt(segmentIndex);
  }

  void onHighlightChangedByGesture(T newValue) {
    if (highlighted == newValue) {
      return;
    }

    setState(() {
      highlighted = newValue;
    });
    // Additionally, start the thumb animation if the highlighted segment
    // changes. If the thumbController is already running, the render object's
    // paint method will create a new tween to drive the animation with.
    // TODO(LongCatIsLooong): https://github.com/flutter/flutter/issues/74356:
    // the current thumb will be painted at the same location twice (before and
    // after the new animation starts).
    thumbController
      ..stop()
      ..forward(from: 0.0);
    thumbAnimatable = null;
  }

  void onPressedChangedByGesture(T? newValue) {
    if (pressed != newValue) {
      setState(() {
        pressed = newValue;
      });
    }
  }

  void onTapDown(TapDownDetails details) {
    final T touchDownSegment = segmentForXPosition(details.localPosition.dx);
    if (widget.disabledChildren.contains(touchDownSegment)) {
      return;
    }
    onPressedChangedByGesture(touchDownSegment);
  }

  void onTapUp(TapUpDetails details) {
    final T segment = segmentForXPosition(details.localPosition.dx);
    onPressedChangedByGesture(null);

    if (!widget.disabledChildren.contains(segment)) {
      _segmentKeys[segment]?.currentState?.requestFocus();

      if (segment != widget.groupValue) {
        widget.onValueChanged(segment);
      }
    }
  }

  void onTapCancel() {
    onPressedChangedByGesture(null);
  }

  // The segment the sliding thumb is currently located at, or animating to. It
  // may have a different value from widget.groupValue, since this widget does
  // not report a selection change via `onValueChanged` until the user stops
  // interacting with the widget (onTapUp). For example, the user can drag the
  // thumb around, and the `onValueChanged` callback will not be invoked until
  // the thumb is let go.
  T? highlighted;

  // The segment the user is currently pressing.
  T? pressed;

  @override
  Widget build(BuildContext context) {
    assert(widget.children.length >= 2);

    final TextDirection textDirection = Directionality.of(context);

    final EdgeInsets segmentPadding = _style.itemPadding.resolve(textDirection);

    List<Widget> children = <Widget>[];
    bool isPreviousSegmentHighlighted = false;

    int index = 0;
    final lastIndex = widget.children.length - 1;
    int? highlightedIndex;
    for (final MapEntry<T, Widget> entry in widget.children.entries) {
      final bool isHighlighted = highlighted == entry.key;
      if (isHighlighted) {
        highlightedIndex = index;
      }

      if (index != 0) {
        children.add(
          _SegmentSeparator(
            // Let separators be TextDirection-invariant. If the TextDirection
            // changes, the separators should mostly stay where they were.
            key: ValueKey<int>(index),
            highlighted: isPreviousSegmentHighlighted || isHighlighted,
            color: _style.separatorColor,
            opacityAnimationDuration: _style.seperatorOpacityAnimationDuration,
          ),
        );
      }

      final _SegmentLocation segmentLocation = switch (textDirection) {
        TextDirection.ltr when index == 0 => _SegmentLocation.leftmost,
        TextDirection.ltr when index == widget.children.length - 1 => _SegmentLocation.rightmost,
        TextDirection.rtl when index == widget.children.length - 1 => _SegmentLocation.leftmost,
        TextDirection.rtl when index == 0 => _SegmentLocation.rightmost,
        TextDirection.ltr || TextDirection.rtl => _SegmentLocation.inbetween,
      };
      final bool enabled = !widget.disabledChildren.contains(entry.key);
      final Color? textColor = _style.textColor.resolve(
        enabled ? const <WidgetState>{} : const <WidgetState>{ WidgetState.disabled },
      );
      final GlobalKey<_SlidingSegmentButtonState<T>> segmentKey = _segmentKeys.putIfAbsent(
        entry.key,
        () => GlobalKey<_SlidingSegmentButtonState<T>>(),
      );

      children.add(
        _SlidingSegmentButton<T>(
          key: segmentKey,
          value: entry.key,
          enabled: !widget.disabledChildren.contains(entry.key),
          child: Semantics(
            button: true,
            onTap: () {
              if (widget.disabledChildren.contains(entry.key)) {
                return;
              }
              segmentKey.currentState?.requestFocus();
              widget.onValueChanged(entry.key);
            },
            inMutuallyExclusiveGroup: true,
            selected: widget.groupValue == entry.key,
            child: _Segment<T>(
              key: ValueKey<T>(entry.key),
              highlighted: isHighlighted,
              pressed: pressed == entry.key,
              enabled: !widget.disabledChildren.contains(entry.key),
              segmentLocation: segmentLocation,
              padding: segmentPadding,
              hoveredBackgroundColor: _style.hoveredItemBackgroundColor,
              borderRadius: index == 0
                  ? BorderRadiusDirectional.horizontal(start: _style.cornerRadius)
                  : index == lastIndex
                      ? BorderRadiusDirectional.horizontal(end: _style.cornerRadius)
                      : null,
              activeTextStyle: _style.activeTextStyle,
              inactiveTextStyle: _style.inactiveTextStyle,
              textColor: textColor,
              highlightAnimationDuration: _style.highlightAnimationDuration,
              child: entry.value,
            ),
          ),
        ),
      );

      index += 1;
      isPreviousSegmentHighlighted = isHighlighted;
    }

    assert((highlightedIndex == null) == (highlighted == null));

    switch (textDirection) {
      case TextDirection.ltr:
        break;
      case TextDirection.rtl:
        children = children.reversed.toList(growable: false);
        if (highlightedIndex != null) {
          highlightedIndex = index - 1 - highlightedIndex;
        }
    }

    const Set<WidgetState> states = <WidgetState>{};

    final Color? backgroundColor = _style.backgroundColor.resolve(states);

    Widget child = _SegmentedControlRenderWidget<T>(
      key: segmentedControlRenderWidgetKey,
      height: _style.height,
      highlightedIndex: highlightedIndex,
      thumbColor: _style.indicatorBackgroundColor.resolve(states)!,
      thumbRadius: _style.cornerRadius,
      thumbSide: _style.indicatorSide.resolve(states)!,
      thumbShadow: _style.indicatorShadow,
      proportionalWidth: widget.proportionalWidth,
      state: this,
      children: children,
    );

    if (backgroundColor != null) {
      child = DecoratedBox(
        decoration: ShapeDecoration(
          shape: _style.shape,
          gradient: _style.gradient,
        ),
        child: child,
      );
    }

    return Actions(
      actions: <Type, Action<Intent>>{
        VoidCallbackIntent: VoidCallbackAction(),
      },
      child: RadioGroup<T>(
        groupValue: widget.groupValue,
        onChanged: (T? value) {
          if (value != null && !widget.disabledChildren.contains(value)) {
            widget.onValueChanged(value);
          }
        },
        child: UnconstrainedBox(
          constrainedAxis: Axis.horizontal,
          child: DecoratedBox(
            decoration: ShapeDecoration(
              shape: _style.shape,
              color: backgroundColor,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _SegmentedControlRenderWidget<T extends Object> extends MultiChildRenderObjectWidget {
  const _SegmentedControlRenderWidget({
    super.key,
    super.children,
    required this.height,
    required this.highlightedIndex,
    required this.thumbColor,
    required this.thumbRadius,
    required this.thumbSide,
    required this.thumbShadow,
    required this.proportionalWidth,
    required this.state,
  });

  final double height;
  final int? highlightedIndex;
  final Color thumbColor;
  final Radius thumbRadius;
  final BorderSide thumbSide;
  final List<BoxShadow> thumbShadow;
  final bool proportionalWidth;
  final _RadixSegmentedControlState<T> state;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSegmentedControl<T>(
      height: height,
      highlightedIndex: highlightedIndex,
      thumbColor: thumbColor,
      thumbRadius: thumbRadius,
      thumbSide: thumbSide,
      thumbShadow: thumbShadow,
      proportionalWidth: proportionalWidth,
      state: state,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSegmentedControl<T> renderObject) {
    assert(renderObject.state == state);
    renderObject
      ..height = height
      ..thumbColor = thumbColor
      ..thumbRadius = thumbRadius
      ..thumbSide = thumbSide
      ..thumbShadow = thumbShadow
      ..highlightedIndex = highlightedIndex
      ..proportionalWidth = proportionalWidth;
  }
}

class _SegmentedControlContainerBoxParentData extends ContainerBoxParentData<RenderBox> {}

enum _SegmentLocation { leftmost, rightmost, inbetween }

class _RenderSegmentedControl<T extends Object> extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData<RenderBox>>,
        RenderBoxContainerDefaultsMixin<RenderBox, ContainerBoxParentData<RenderBox>> {
  _RenderSegmentedControl({
    required double height,
    required int? highlightedIndex,
    required Color thumbColor,
    required Radius thumbRadius,
    required BorderSide thumbSide,
    required List<BoxShadow> thumbShadow,
    required bool proportionalWidth,
    required this.state,
  }) : _height = height,
       _highlightedIndex = highlightedIndex,
       _thumbColor = thumbColor,
       _thumbRadius = thumbRadius,
       _thumbSide = thumbSide,
       _thumbShadow = thumbShadow,
       _proportionalWidth = proportionalWidth;

  final _RadixSegmentedControlState<T> state;

  // The current Thumb Rect in this RenderBox's coordinate space.
  Rect? currentThumbRect;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    state.thumbController.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    state.thumbController.removeListener(markNeedsPaint);
    super.detach();
  }

  double get height => _height;
  double _height;
  set height(double value) {
    if (_height == value) {
      return;
    }

    _height = height;
    markNeedsLayout();
  }

  int? get highlightedIndex => _highlightedIndex;
  int? _highlightedIndex;
  set highlightedIndex(int? value) {
    if (_highlightedIndex == value) {
      return;
    }

    _highlightedIndex = value;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;
  Color _thumbColor;
  set thumbColor(Color value) {
    if (_thumbColor == value) {
      return;
    }
    _thumbColor = value;
    markNeedsPaint();
  }

  Radius get thumbRadius => _thumbRadius;
  Radius _thumbRadius;
  set thumbRadius(Radius value) {
    if (_thumbRadius == value) {
      return;
    }
    _thumbRadius = value;
    markNeedsPaint();
  }

  BorderSide get thumbSide => _thumbSide;
  BorderSide _thumbSide;
  set thumbSide(BorderSide value) {
    if (_thumbSide == value) {
      return;
    }
    _thumbSide = value;
    markNeedsPaint();
  }

  List<BoxShadow> get thumbShadow => _thumbShadow;
  List<BoxShadow> _thumbShadow;
  set thumbShadow(List<BoxShadow> value) {
    if (_thumbShadow == value) {
      return;
    }
    _thumbShadow = value;
    markNeedsPaint();
  }

  bool get proportionalWidth => _proportionalWidth;
  bool _proportionalWidth;
  set proportionalWidth(bool value) {
    if (_proportionalWidth == value) {
      return;
    }
    _proportionalWidth = value;
    markNeedsLayout();
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    // No gesture should interfere with an ongoing thumb drag.
    if (event is PointerDownEvent) {
      state.tap.addPointer(event);
      state.longPress.addPointer(event);
    }
  }

  // Intrinsic Dimensions
  double get separatorWidth => _kSeparatorInset.horizontal + _kSeparatorWidth;
  double get totalSeparatorWidth => separatorWidth * (childCount ~/ 2);

  int getClosestSegmentIndex(double dx) {
    int index = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData! as _SegmentedControlContainerBoxParentData;
      final double clampX = clampDouble(
        dx,
        childParentData.offset.dx,
        child.size.width + childParentData.offset.dx,
      );

      if (dx <= clampX) {
        break;
      }

      index++;
      child = nonSeparatorChildAfter(child);
    }

    final int segmentCount = childCount ~/ 2 + 1;
    // When the thumb is dragging out of bounds, the return result must be
    // smaller than segment count.
    return math.min(index, segmentCount - 1);
  }

  RenderBox? nonSeparatorChildAfter(RenderBox child) {
    final RenderBox? nextChild = childAfter(child);
    return nextChild == null ? null : childAfter(nextChild);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final int childCount = this.childCount ~/ 2 + 1;
    RenderBox? child = firstChild;
    double maxMinChildWidth = 0;
    while (child != null) {
      final double childWidth = child.getMinIntrinsicWidth(height);
      maxMinChildWidth = math.max(maxMinChildWidth, childWidth);
      child = nonSeparatorChildAfter(child);
    }
    return maxMinChildWidth * childCount + totalSeparatorWidth;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final int childCount = this.childCount ~/ 2 + 1;
    RenderBox? child = firstChild;
    double maxMaxChildWidth = 0;
    while (child != null) {
      final double childWidth = child.getMaxIntrinsicWidth(height);
      maxMaxChildWidth = math.max(maxMaxChildWidth, childWidth);
      child = nonSeparatorChildAfter(child);
    }
    return maxMaxChildWidth * childCount + totalSeparatorWidth;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    RenderBox? child = firstChild;
    double maxMinChildHeight = height;
    while (child != null) {
      final double childHeight = child.getMinIntrinsicHeight(width);
      maxMinChildHeight = math.max(maxMinChildHeight, childHeight);
      child = nonSeparatorChildAfter(child);
    }
    return maxMinChildHeight;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    RenderBox? child = firstChild;
    double maxMaxChildHeight = height;
    while (child != null) {
      final double childHeight = child.getMaxIntrinsicHeight(width);
      maxMaxChildHeight = math.max(maxMaxChildHeight, childHeight);
      child = nonSeparatorChildAfter(child);
    }
    return maxMaxChildHeight;
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _SegmentedControlContainerBoxParentData) {
      child.parentData = _SegmentedControlContainerBoxParentData();
    }
  }

  double _getMaxChildWidth(BoxConstraints constraints) {
    final int childCount = this.childCount ~/ 2 + 1;
    double childWidth = (constraints.minWidth - totalSeparatorWidth) / childCount;
    RenderBox? child = firstChild;
    while (child != null) {
      childWidth = math.max(
        childWidth,
        child.getMaxIntrinsicWidth(double.infinity),
      );
      child = nonSeparatorChildAfter(child);
    }
    return math.min(childWidth, (constraints.maxWidth - totalSeparatorWidth) / childCount);
  }

  double _getMaxChildHeight(BoxConstraints constraints, double childWidth) {
    double maxHeight = height;
    RenderBox? child = firstChild;
    while (child != null) {
      final double boxHeight = child.getMaxIntrinsicHeight(childWidth);
      maxHeight = math.max(maxHeight, boxHeight);
      child = nonSeparatorChildAfter(child);
    }
    return maxHeight;
  }

  List<double> _getChildWidths(BoxConstraints constraints) {
    if (!proportionalWidth) {
      final double maxChildWidth = _getMaxChildWidth(constraints);
      final int segmentCount = childCount ~/ 2 + 1;
      return List<double>.filled(segmentCount, maxChildWidth);
    }

    final List<double> segmentWidths = <double>[];
    RenderBox? child = firstChild;
    while (child != null) {
      final double childWidth =
          child.getMaxIntrinsicWidth(double.infinity);
      child = nonSeparatorChildAfter(child);
      segmentWidths.add(childWidth);
    }

    final double totalWidth = segmentWidths.sum;

    // If the sum of the children's width is larger than the allowed max width,
    // each segment width should scale down until the overall size can fit in
    // the parent constraints; similarly, if the sum of the children's width is
    // smaller than the allowed min width, each segment width should scale up
    // until the overall size can fit in the parent constraints.
    final double allowedMaxWidth = constraints.maxWidth - totalSeparatorWidth;
    final double allowedMinWidth = constraints.minWidth - totalSeparatorWidth;

    final double scale = clampDouble(totalWidth, allowedMinWidth, allowedMaxWidth) / totalWidth;
    if (scale != 1) {
      for (int i = 0; i < segmentWidths.length; i++) {
        segmentWidths[i] = segmentWidths[i] * scale;
      }
    }
    return segmentWidths;
  }

  Size _computeOverallSize(BoxConstraints constraints) {
    final double maxChildHeight = _getMaxChildHeight(constraints, constraints.maxWidth);
    return constraints.constrain(
      Size(_getChildWidths(constraints).sum + totalSeparatorWidth, maxChildHeight),
    );
  }

  @override
  double? computeDryBaseline(covariant BoxConstraints constraints, TextBaseline baseline) {
    final List<double> segmentWidths = _getChildWidths(constraints);
    final double childHeight = _getMaxChildHeight(constraints, constraints.maxWidth);

    int index = 0;
    BaselineOffset baselineOffset = BaselineOffset.noBaseline;
    RenderBox? child = firstChild;
    while (child != null) {
      final BoxConstraints childConstraints = BoxConstraints.tight(
        Size(segmentWidths[index], childHeight),
      );
      baselineOffset = baselineOffset.minOf(
        BaselineOffset(child.getDryBaseline(childConstraints, baseline)),
      );

      child = nonSeparatorChildAfter(child);
      index++;
    }

    return baselineOffset.offset;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeOverallSize(constraints);
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final List<double> segmentWidths = _getChildWidths(constraints);

    final double childHeight = _getMaxChildHeight(constraints, double.infinity);
    final BoxConstraints separatorConstraints = BoxConstraints(
      minHeight: childHeight,
      maxHeight: childHeight,
    );
    RenderBox? child = firstChild;
    int index = 0;
    double start = 0;
    while (child != null) {
      final BoxConstraints childConstraints = BoxConstraints.tight(
        Size(segmentWidths[index ~/ 2], childHeight),
      );
      child.layout(index.isEven ? childConstraints : separatorConstraints, parentUsesSize: true);
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData! as _SegmentedControlContainerBoxParentData;
      final Offset childOffset = Offset(start, 0);
      childParentData.offset = childOffset;
      start += child.size.width;
      assert(
        index.isEven || child.size.width == _kSeparatorWidth + _kSeparatorInset.horizontal,
        '${child.size.width} != ${_kSeparatorWidth + _kSeparatorInset.horizontal}',
      );
      child = childAfter(child);
      index += 1;
    }
    size = _computeOverallSize(constraints);
  }

  // This method is used to convert the original thumb rect painted in
  // the previous frame, to a Rect that is within the valid boundary defined by
  // the child segments.
  //
  // The overall size does not include that of the thumb. That is, if the thumb
  // is located at the first or the last segment, the thumb can get cut off if
  // one of the values in _kThumbInsets is positive.
  Rect? moveThumbRectInBound(Rect? thumbRect, List<RenderBox> children) {
    assert(hasSize);
    assert(children.length >= 2);
    if (thumbRect == null) {
      return null;
    }

    final Offset firstChildOffset =
        (children.first.parentData! as _SegmentedControlContainerBoxParentData).offset;
    final double leftMost = firstChildOffset.dx;
    final double rightMost =
        (children.last.parentData! as _SegmentedControlContainerBoxParentData).offset.dx +
        children.last.size.width;
    assert(rightMost > leftMost);

    // Ignore the horizontal position and the height of `thumbRect`, and
    // calculates them from `children`.
    return Rect.fromLTRB(
      math.max(thumbRect.left, leftMost - _kThumbInsets.left),
      firstChildOffset.dy - _kThumbInsets.top,
      math.min(thumbRect.right, rightMost + _kThumbInsets.right),
      firstChildOffset.dy + children.first.size.height + _kThumbInsets.bottom,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final List<RenderBox> children = getChildrenAsList();

    // Children contains both segment and separator and the order is segment ->
    // separator -> segment. So to paint separators, index should start from 1 and
    // the step should be 2.
    for (int index = 1; index < childCount; index += 2) {
      _paintSeparator(context, offset, children[index]);
    }

    final int? highlightedChildIndex = highlightedIndex;
    // Paint thumb if there's a highlighted segment.
    if (highlightedChildIndex != null) {
      final RenderBox selectedChild = children[highlightedChildIndex * 2];

      final _SegmentedControlContainerBoxParentData childParentData =
          selectedChild.parentData! as _SegmentedControlContainerBoxParentData;
      final Rect newThumbRect = _kThumbInsets.inflateRect(
        childParentData.offset & selectedChild.size,
      );

      // Update thumb animation's tween, in case the end rect changed (e.g., a
      // new segment is added during the animation).
      if (state.thumbController.isAnimating) {
        final Animatable<Rect?>? thumbTween = state.thumbAnimatable;
        if (thumbTween == null) {
          // This is the first frame of the animation.
          final Rect startingRect =
              moveThumbRectInBound(currentThumbRect, children) ?? newThumbRect;
          state.thumbAnimatable = RectTween(begin: startingRect, end: newThumbRect);
        } else if (newThumbRect != thumbTween.transform(1)) {
          // The thumbTween of the running sliding animation needs updating,
          // without restarting the animation.
          final Rect startingRect =
              moveThumbRectInBound(currentThumbRect, children) ?? newThumbRect;
          state.thumbAnimatable = RectTween(
            begin: startingRect,
            end: newThumbRect,
          ).chain(CurveTween(curve: Interval(state.thumbController.value, 1)));
        }
      } else {
        state.thumbAnimatable = null;
      }

      final Rect thumbRect =
          state.thumbAnimatable?.evaluate(state.thumbController) ?? newThumbRect;
      currentThumbRect = thumbRect;

      final _SegmentLocation childLocation;
      if (highlightedChildIndex == 0) {
        childLocation = _SegmentLocation.leftmost;
      } else if (highlightedChildIndex == children.length ~/ 2) {
        childLocation = _SegmentLocation.rightmost;
      } else {
        childLocation = _SegmentLocation.inbetween;
      }

      final double delta = switch (childLocation) {
        _SegmentLocation.leftmost => thumbRect.width - thumbRect.width,
        _SegmentLocation.rightmost => thumbRect.width - thumbRect.width,
        _SegmentLocation.inbetween => 0,
      };

      final Rect effectiveThumbRect = Rect.fromCenter(
        center: thumbRect.center - Offset(delta / 2, 0),
        width: thumbRect.width,
        height: thumbRect.height,
      );

      _paintThumb(context, offset, effectiveThumbRect);
    } else {
      currentThumbRect = null;
    }

    for (int index = 0; index < children.length; index += 2) {
      // Children contains both segment and separator and the order is segment ->
      // separator -> segment. So to paint separators, index should start from 0 and
      // the step should be 2.
      _paintChild(context, offset, children[index]);
    }
  }

  // Paint the separator to the right of the given child.
  final Paint separatorPaint = Paint();
  void _paintSeparator(PaintingContext context, Offset offset, RenderBox child) {
    final _SegmentedControlContainerBoxParentData childParentData =
        child.parentData! as _SegmentedControlContainerBoxParentData;
    context.paintChild(child, offset + childParentData.offset);
  }

  void _paintChild(PaintingContext context, Offset offset, RenderBox child) {
    final _SegmentedControlContainerBoxParentData childParentData =
        child.parentData! as _SegmentedControlContainerBoxParentData;
    context.paintChild(child, childParentData.offset + offset);
  }

  void _paintThumb(PaintingContext context, Offset offset, Rect thumbRect) {
    final RRect thumbShape = RRect.fromRectAndRadius(
      thumbRect.shift(offset),
      _thumbRadius,
    );

    for (final BoxShadow shadow in _thumbShadow) {
      final RRect bounds = thumbShape.shift(shadow.offset).inflate(shadow.spreadRadius);
      context.canvas.drawRRect(bounds, shadow.toPaint());
    }

    context.canvas.drawRRect(thumbShape, Paint()..color = thumbColor);

    if (_thumbSide.style != BorderStyle.none) {
      final Paint paintBorder = Paint()..color = thumbSide.color;
      final double width = thumbSide.width;
      if (width == 0.0) {
        paintBorder
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.0;
        context.canvas.drawRRect(thumbShape, paintBorder);
      } else {
        final RRect inner = thumbShape.deflate(thumbSide.strokeInset);
        final RRect outer = thumbShape.inflate(thumbSide.strokeOutset);
        context.canvas.drawDRRect(outer, inner, paintBorder);
      }
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    RenderBox? child = lastChild;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData! as _SegmentedControlContainerBoxParentData;
      if ((childParentData.offset & child.size).contains(position)) {
        return result.addWithPaintOffset(
          offset: childParentData.offset,
          position: position,
          hitTest: (BoxHitTestResult result, Offset localOffset) {
            assert(localOffset == position - childParentData.offset);
            return child!.hitTest(result, position: localOffset);
          },
        );
      }
      child = childParentData.previousSibling;
    }
    return false;
  }
}
