
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'badge.dart';
import 'button.dart';
import 'colors.dart';
import 'input_decorator.dart';
import 'radius.dart';
import 'select.dart';
import 'shadow.dart';
import 'space.dart';
import 'spinner.dart';
import 'text_theme.dart';
import 'theme.dart';

/// Defines the configuration of the overall visual [RadixTheme] for
/// a [RadixApp] or a widget subtree within the app.
///
/// The [RadixApp] theme property can be used to configure the appearance
/// of the entire app. Widget subtrees within an app can override the app's
/// theme by including a [RadixTheme] widget at the top of the subtree.
///
/// Widgets whose appearance should align with the overall theme can obtain the
/// current theme's configuration with [RadixTheme.of]. Radix components typically
/// depend exclusively on the [colorScheme] and [textTheme]. These properties
/// are guaranteed to have non-null values.
///
/// The static [RadixTheme.of] method finds the [RadixThemeData] value specified
/// for the nearest [BuildContext] ancestor. This lookup is inexpensive, essentially
/// just a single HashMap access. It can sometimes be a little confusing
/// because [RadixTheme.of] can not see a [RadixTheme] widget that is defined in the
/// current build method's context. To overcome that, create a new custom widget
/// for the subtree that appears below the new [RadixTheme], or insert a widget
/// that creates a new BuildContext, like [Builder].
@immutable
class RadixThemeData with Diagnosticable {
  factory RadixThemeData({
    // For the sanity of the reader, make sure these properties are in the same
    // order in every place.

    Iterable<ThemeExtension<dynamic>> extensions = const <ThemeExtension<dynamic>>[],
    required RadixColorScheme colorScheme,
    required IconThemeData iconTheme,
    required RadixTextTheme textTheme,
    required RadixSpace space,
    required RadixRadiusFactor radius,
    required RadixShadowSwatch shadows,
    ActionIconThemeData? actionIconTheme,
    RadixBadgeThemeData? badgeTheme,
    RadixBadgeCustomThemeData? badgeCustomTheme,
    RadixButtonThemeData? buttonTheme,
    RadixButtonCustomThemeData? buttonCustomTheme,
    required RadixInputDecorationThemeData inputDecorationTheme,
    RadixInputDecorationVariantTheme? inputDecorationVariantTheme,
    RadixInputDecorationThemeData? selectDecorationTheme,
    RadixSelectDecorationVariantTheme? selectDecorationVariantTheme,
    required RadixSpinnerThemeData spinnerTheme,
    required TextSelectionThemeData textSelectionTheme,
  }) {
    assert(extensions.whereType<RadixThemeExtension>().isEmpty);
    assert(badgeTheme == null || badgeCustomTheme == null);
    assert(buttonTheme == null || buttonCustomTheme == null);

    return RadixThemeData.raw(
      extensions: _themeExtensionIterableToMap(extensions),
      colorScheme: colorScheme,
      iconTheme: iconTheme,
      textTheme: textTheme,
      space: space,
      radius: radius,
      shadows: shadows,
      actionIconTheme: actionIconTheme,
      badgeTheme: badgeTheme,
      badgeCustomTheme: badgeCustomTheme,
      buttonTheme: buttonTheme,
      buttonCustomTheme: buttonCustomTheme,
      inputDecorationTheme: inputDecorationTheme,
      inputDecorationVariantTheme: inputDecorationVariantTheme,
      selectDecorationTheme: selectDecorationTheme,
      selectDecorationVariantTheme: selectDecorationVariantTheme,
      spinnerTheme: spinnerTheme,
      textSelectionTheme: textSelectionTheme,
    );
  }

  const RadixThemeData.raw({
    // For the sanity of the reader, make sure these properties are in the same
    // order in every place.

    required this.extensions,
    required this.colorScheme,
    required this.iconTheme,
    required this.textTheme,
    required this.space,
    required this.radius,
    required this.shadows,
    this.actionIconTheme,
    this.badgeTheme,
    this.badgeCustomTheme,
    this.buttonTheme,
    this.buttonCustomTheme,
    required this.inputDecorationTheme,
    this.inputDecorationVariantTheme,
    this.selectDecorationTheme,
    this.selectDecorationVariantTheme,
    required this.spinnerTheme,
    required this.textSelectionTheme,
  })  : assert(badgeTheme == null || badgeCustomTheme == null),
        assert(buttonTheme == null || buttonCustomTheme == null);

  // GENERAL CONFIGURATION

  /// Arbitrary additions to this theme.
  ///
  /// To define extensions, pass an [Iterable] containing one or more [ThemeExtension]
  /// subclasses to [ThemeData.new] or [copyWith].
  ///
  /// To obtain an extension, use [extension].
  ///
  /// {@tool dartpad}
  /// This sample shows how to create and use a subclass of [ThemeExtension] that
  /// defines two colors.
  ///
  /// ** See code in examples/api/lib/theme/theme_extension.1.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  /// * [extension], a convenience function for obtaining a specific extension.
  final Map<Object, ThemeExtension<dynamic>> extensions;

  /// Used to obtain a particular [ThemeExtension] from [extensions].
  ///
  /// Obtain with `Theme.of(context).extension<MyThemeExtension>()`.
  ///
  /// See [extensions] for an interactive example.
  T? extension<T>() => extensions[T] as T?;

  // COLOR

  final RadixColorScheme colorScheme;

  // TYPOGRAPHY & ICONOGRAPHY

  /// An icon theme that contrasts with the card and canvas colors.
  final IconThemeData iconTheme;

  /// Text with a color that contrasts with the card and canvas colors.
  final RadixTextTheme textTheme;

  // COMPONENT THEMES

  final RadixSpace space;

  final RadixRadiusFactor radius;

  final RadixShadowSwatch shadows;

  /// A theme for customizing icons of [BackButtonIcon], [CloseButtonIcon],
  /// [DrawerButtonIcon], or [EndDrawerButtonIcon].
  final ActionIconThemeData? actionIconTheme;

  final RadixBadgeThemeData? badgeTheme;
  final RadixBadgeCustomThemeData? badgeCustomTheme;

  final RadixButtonThemeData? buttonTheme;
  final RadixButtonCustomThemeData? buttonCustomTheme;

  /// The default [RadixInputDecoration] values for [RadixInputDecorator],
  /// [RadixTextField], and [TextFormField] are based on this theme.
  ///
  /// See [RadixInputDecoration.applyDefaults].
  final RadixInputDecorationThemeData inputDecorationTheme;
  final RadixInputDecorationVariantTheme? inputDecorationVariantTheme;

  final RadixInputDecorationThemeData? selectDecorationTheme;
  final RadixSelectDecorationVariantTheme? selectDecorationVariantTheme;

  final RadixSpinnerThemeData spinnerTheme;

  /// A theme for customizing the appearance and layout of [TextField] widgets.
  final TextSelectionThemeData textSelectionTheme;

  /// Linearly interpolate between two [extensions].
  ///
  /// Includes all theme extensions in [a] and [b].
  ///
  /// {@macro dart.ui.shadow.lerp}
  static Map<Object, ThemeExtension<dynamic>> _lerpThemeExtensions(
    RadixThemeData a,
    RadixThemeData b,
    double t,
  ) {
    // Lerp [a].
    final Map<Object, ThemeExtension<dynamic>> newExtensions = a.extensions.map((
      Object id,
      ThemeExtension<dynamic> extensionA,
    ) {
      final ThemeExtension<dynamic>? extensionB = b.extensions[id];
      return MapEntry<Object, ThemeExtension<dynamic>>(id, extensionA.lerp(extensionB, t));
    });
    // Add [b]-only extensions.
    newExtensions.addEntries(
      b.extensions.entries.where(
        (MapEntry<Object, ThemeExtension<dynamic>> entry) => !a.extensions.containsKey(entry.key),
      ),
    );

    return newExtensions;
  }

  /// Convert the [extensionsIterable] passed to [ThemeData.new] or [copyWith]
  /// to the stored [extensions] map, where each entry's key consists of the extension's type.
  static Map<Object, ThemeExtension<dynamic>> _themeExtensionIterableToMap(
    Iterable<ThemeExtension<dynamic>> extensionsIterable,
  ) {
    return Map<Object, ThemeExtension<dynamic>>.unmodifiable(<Object, ThemeExtension<dynamic>>{
      // Strangely, the cast is necessary for tests to run.
      for (final ThemeExtension<dynamic> extension in extensionsIterable)
        extension.type: extension as ThemeExtension<ThemeExtension<dynamic>>,
    });
  }

  /// Linearly interpolate between two themes.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixThemeData lerp(RadixThemeData a, RadixThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    if ((a.buttonTheme != null && b.buttonTheme == null) || (a.buttonTheme == null && b.buttonTheme != null)) {
      throw UnsupportedError(
        "Cannot interpolate between a null value and a non-null value for the 'buttonTheme' property. "
        "Both operands must be non-null for linear interpolation to proceed.",
      );
    }

    if ((a.buttonTheme != null && b.buttonTheme == null) || (a.buttonTheme == null && b.buttonTheme != null)) {
      throw UnsupportedError(
        "Cannot interpolate between a null value and a non-null value for the 'buttonTheme' property. "
        "Both operands must be non-null for linear interpolation to proceed.",
      );
    }

    return RadixThemeData.raw(
      // For the sanity of the reader, make sure these properties are in the same
      // order in every place.

      // GENERAL CONFIGURATION
      extensions: _lerpThemeExtensions(a, b, t),
      // COLOR
      colorScheme: RadixColorScheme.lerp(a.colorScheme, b.colorScheme, t),
      // TYPOGRAPHY & ICONOGRAPHY
      iconTheme: IconThemeData.lerp(a.iconTheme, b.iconTheme, t),
      textTheme: RadixTextTheme.lerp(a.textTheme, b.textTheme, t),
      // COMPONENT THEMES
      space: RadixSpace.lerp(a.space, b.space, t),
      radius: RadixRadiusFactor.lerp(a.radius, b.radius, t),
      shadows: RadixShadowSwatch.lerp(a.shadows, b.shadows, t),
      actionIconTheme: ActionIconThemeData.lerp(a.actionIconTheme, b.actionIconTheme, t),
      badgeTheme: RadixBadgeThemeData.lerp(a.badgeTheme, b.badgeTheme, t),
      badgeCustomTheme: a.badgeCustomTheme?.lerp(b.badgeCustomTheme, t) as RadixBadgeCustomThemeData?
                         ?? (t < 0.5 ? null : b.badgeCustomTheme),
      buttonTheme: RadixButtonThemeData.lerp(a.buttonTheme, b.buttonTheme, t),
      buttonCustomTheme: a.buttonCustomTheme?.lerp(b.buttonCustomTheme, t) as RadixButtonCustomThemeData?
                         ?? (t < 0.5 ? null : b.buttonCustomTheme),
      inputDecorationTheme: t < 0.5 ? a.inputDecorationTheme : b.inputDecorationTheme,
      inputDecorationVariantTheme: t < 0.5 ? a.inputDecorationVariantTheme : b.inputDecorationVariantTheme,
      selectDecorationTheme: t < 0.5 ? a.selectDecorationTheme : b.selectDecorationTheme,
      selectDecorationVariantTheme: t < 0.5 ? a.selectDecorationVariantTheme : b.selectDecorationVariantTheme,
      spinnerTheme: RadixSpinnerThemeData.lerp(a.spinnerTheme, b.spinnerTheme, t),
      textSelectionTheme: TextSelectionThemeData.lerp(
        a.textSelectionTheme,
        b.textSelectionTheme,
        t,
      )!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RadixThemeData &&
        // For the sanity of the reader, make sure these properties are in the same
        // order in every place.

        // GENERAL CONFIGURATION
        mapEquals(other.extensions, extensions) &&
        // COLOR
        other.colorScheme == colorScheme &&
        // TYPOGRAPHY & ICONOGRAPHY
        other.iconTheme == iconTheme &&
        other.textTheme == textTheme &&
        // COMPONENT THEMES
        other.space == space &&
        other.radius == radius &&
        other.shadows == shadows &&
        other.actionIconTheme == actionIconTheme &&
        other.badgeTheme == badgeTheme &&
        other.badgeCustomTheme == badgeCustomTheme &&
        other.buttonTheme == buttonTheme &&
        other.buttonCustomTheme == buttonCustomTheme &&
        other.inputDecorationTheme == inputDecorationTheme &&
        other.inputDecorationVariantTheme == inputDecorationVariantTheme &&
        other.selectDecorationTheme == selectDecorationTheme &&
        other.selectDecorationVariantTheme == selectDecorationVariantTheme &&
        other.spinnerTheme == spinnerTheme &&
        other.textSelectionTheme == textSelectionTheme;
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      // For the sanity of the reader, make sure these properties are in the same
      // order in every place.

      // GENERAL CONFIGURATION
      ...extensions.keys,
      ...extensions.values,
      // COLOR
      colorScheme,
      // TYPOGRAPHY & ICONOGRAPHY
      iconTheme,
      textTheme,
      // COMPONENT THEMES
      space,
      radius,
      shadows,
      actionIconTheme,
      badgeTheme,
      badgeCustomTheme,
      buttonTheme,
      buttonCustomTheme,
      inputDecorationTheme,
      inputDecorationVariantTheme,
      selectDecorationTheme,
      selectDecorationVariantTheme,
      spinnerTheme,
      textSelectionTheme,
    ];
    return Object.hashAll(values);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final RadixThemeData defaultData = RadixTheme.kFallbackLight;
    // For the sanity of the reader, make sure these properties are in the same
    // order in every place.

    // GENERAL CONFIGURATION
    properties.add(
      IterableProperty<ThemeExtension<dynamic>>(
        'extensions',
        extensions.values,
        defaultValue: defaultData.extensions.values,
        level: DiagnosticLevel.debug,
      ),
    );
    // COLORS
    properties.add(
      DiagnosticsProperty<RadixColorScheme>(
        'colorScheme',
        colorScheme,
        defaultValue: defaultData.colorScheme,
        level: DiagnosticLevel.debug,
      ),
    );
    // TYPOGRAPHY & ICONOGRAPHY
    properties.add(
      DiagnosticsProperty<IconThemeData>('iconTheme', iconTheme, level: DiagnosticLevel.debug),
    );
    properties.add(
      DiagnosticsProperty<RadixTextTheme>('textTheme', textTheme, level: DiagnosticLevel.debug),
    );
    // COMPONENT THEMES
    properties.add(
      DiagnosticsProperty<RadixSpace>(
        'space',
        space,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixRadiusFactor>(
        'radius',
        radius,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixShadowSwatch>(
        'shadows',
        shadows,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<ActionIconThemeData>(
        'actionIconTheme',
        actionIconTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixBadgeThemeData>(
        'badgeTheme',
        badgeTheme,
        defaultValue: defaultData.badgeTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixButtonThemeData>(
        'buttonTheme',
        buttonTheme,
        defaultValue: defaultData.buttonTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixInputDecorationThemeData>(
        'inputDecorationTheme',
        inputDecorationTheme,
        defaultValue: defaultData.inputDecorationTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixInputDecorationThemeData>(
        'selectDecorationTheme',
        selectDecorationTheme,
        defaultValue: defaultData.selectDecorationTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixSpinnerThemeData>(
        'spinnerTheme',
        spinnerTheme,
        defaultValue: defaultData.spinnerTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextSelectionThemeData>(
        'textSelectionTheme',
        textSelectionTheme,
        defaultValue: defaultData.textSelectionTheme,
        level: DiagnosticLevel.debug,
      ),
    );
  }
}

@immutable
class RadixThemeExtension extends ThemeExtension<RadixThemeExtension> with Diagnosticable {
  factory RadixThemeExtension({
    // For the sanity of the reader, make sure these properties are in the same
    // order in every place.

    required RadixColorScheme colorScheme,
    required RadixTextTheme textTheme,
    required RadixSpace space,
    required RadixRadiusFactor radius,
    required RadixShadowSwatch shadows,
    RadixBadgeThemeData? badgeTheme,
    RadixBadgeCustomThemeData? badgeCustomTheme,
    RadixButtonThemeData? buttonTheme,
    RadixButtonCustomThemeData? buttonCustomTheme,
    required RadixInputDecorationThemeData inputDecorationTheme,
    RadixInputDecorationVariantTheme? inputDecorationVariantTheme,
    RadixInputDecorationThemeData? selectDecorationTheme,
    RadixSelectDecorationVariantTheme? selectDecorationVariantTheme,
    required RadixSpinnerThemeData spinnerTheme,
    required Color selectionColor,
  }) {
    assert(badgeTheme == null || badgeCustomTheme == null);
    assert(buttonTheme == null || buttonCustomTheme == null);

    return RadixThemeExtension.raw(
      colorScheme: colorScheme,
      textTheme: textTheme,
      space: space,
      radius: radius,
      shadows: shadows,
      badgeTheme: badgeTheme,
      badgeCustomTheme: badgeCustomTheme,
      buttonTheme: buttonTheme,
      buttonCustomTheme: buttonCustomTheme,
      inputDecorationTheme: inputDecorationTheme,
      inputDecorationVariantTheme: inputDecorationVariantTheme,
      selectDecorationTheme: selectDecorationTheme,
      selectDecorationVariantTheme: selectDecorationVariantTheme,
      spinnerTheme: spinnerTheme,
      selectionColor: selectionColor,
    );
  }

  const RadixThemeExtension.raw({
    // For the sanity of the reader, make sure these properties are in the same
    // order in every place.

    required this.colorScheme,
    required this.textTheme,
    required this.space,
    required this.radius,
    required this.shadows,
    this.badgeTheme,
    this.badgeCustomTheme,
    this.buttonTheme,
    this.buttonCustomTheme,
    required this.inputDecorationTheme,
    this.inputDecorationVariantTheme,
    this.selectDecorationTheme,
    this.selectDecorationVariantTheme,
    required this.spinnerTheme,
    required this.selectionColor,
  })  : assert(badgeTheme == null || badgeCustomTheme == null),
        assert(buttonTheme == null || buttonCustomTheme == null);

  final RadixColorScheme colorScheme;

  /// Text with a color that contrasts with the card and canvas colors.
  final RadixTextTheme textTheme;

  final RadixSpace space;

  final RadixRadiusFactor radius;

  final RadixShadowSwatch shadows;

  final RadixBadgeThemeData? badgeTheme;
  final RadixBadgeCustomThemeData? badgeCustomTheme;

  final RadixButtonThemeData? buttonTheme;
  final RadixButtonCustomThemeData? buttonCustomTheme;

  /// The default [RadixInputDecoration] values for [RadixInputDecorator],
  /// [RadixTextField], and [TextFormField] are based on this theme.
  ///
  /// See [RadixInputDecoration.applyDefaults].
  final RadixInputDecorationThemeData inputDecorationTheme;
  final RadixInputDecorationVariantTheme? inputDecorationVariantTheme;

  final RadixInputDecorationThemeData? selectDecorationTheme;
  final RadixSelectDecorationVariantTheme? selectDecorationVariantTheme;

  final RadixSpinnerThemeData spinnerTheme;

  /// The background color of selected text.
  final Color selectionColor;

  @override
  ThemeExtension<RadixThemeExtension> lerp(covariant RadixThemeExtension other, double t) {
    return RadixThemeExtension.raw(
      // For the sanity of the reader, make sure these properties are in the same
      // order in every place.

      colorScheme: RadixColorScheme.lerp(colorScheme, other.colorScheme, t),
      textTheme: RadixTextTheme.lerp(textTheme, other.textTheme, t),
      space: RadixSpace.lerp(space, other.space, t),
      radius: RadixRadiusFactor.lerp(radius, other.radius, t),
      shadows: RadixShadowSwatch.lerp(shadows, other.shadows, t),
      badgeTheme: RadixBadgeThemeData.lerp(badgeTheme, other.badgeTheme, t),
      badgeCustomTheme: badgeCustomTheme?.lerp(other.badgeCustomTheme, t) as RadixBadgeCustomThemeData?
                         ?? (t < 0.5 ? null : other.badgeCustomTheme),
      buttonTheme: RadixButtonThemeData.lerp(buttonTheme, other.buttonTheme, t),
      buttonCustomTheme: buttonCustomTheme?.lerp(other.buttonCustomTheme, t) as RadixButtonCustomThemeData?
                         ?? (t < 0.5 ? null : other.buttonCustomTheme),
      inputDecorationTheme: t < 0.5 ? inputDecorationTheme : other.inputDecorationTheme,
      inputDecorationVariantTheme: t < 0.5 ? inputDecorationVariantTheme : other.inputDecorationVariantTheme,
      selectDecorationTheme: t < 0.5 ? selectDecorationTheme : other.selectDecorationTheme,
      selectDecorationVariantTheme: t < 0.5 ? selectDecorationVariantTheme : other.selectDecorationVariantTheme,
      spinnerTheme: RadixSpinnerThemeData.lerp(spinnerTheme, other.spinnerTheme, t),
      selectionColor: Color.lerp(selectionColor, other.selectionColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RadixThemeExtension &&
        // For the sanity of the reader, make sure these properties are in the same
        // order in every place.

        other.colorScheme == colorScheme &&
        other.textTheme == textTheme &&
        other.space == space &&
        other.radius == radius &&
        other.shadows == shadows &&
        other.badgeTheme == badgeTheme &&
        other.badgeCustomTheme == badgeCustomTheme &&
        other.buttonTheme == buttonTheme &&
        other.buttonCustomTheme == buttonCustomTheme &&
        other.inputDecorationTheme == inputDecorationTheme &&
        other.inputDecorationVariantTheme == inputDecorationVariantTheme &&
        other.selectDecorationTheme == selectDecorationTheme &&
        other.selectDecorationVariantTheme == selectDecorationVariantTheme &&
        other.spinnerTheme == spinnerTheme &&
        other.selectionColor == selectionColor;
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      // For the sanity of the reader, make sure these properties are in the same
      // order in every place.

      colorScheme,
      textTheme,
      space,
      radius,
      shadows,
      badgeTheme,
      badgeCustomTheme,
      buttonTheme,
      buttonCustomTheme,
      inputDecorationTheme,
      inputDecorationVariantTheme,
      selectDecorationTheme,
      selectDecorationVariantTheme,
      spinnerTheme,
      selectionColor,
    ];
    return Object.hashAll(values);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final RadixThemeData defaultData = RadixTheme.kFallbackLight;
    // For the sanity of the reader, make sure these properties are in the same
    // order in every place.

    properties.add(
      DiagnosticsProperty<RadixColorScheme>(
        'colorScheme',
        colorScheme,
        defaultValue: defaultData.colorScheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixTextTheme>(
        'textTheme',
        textTheme,
        defaultValue: defaultData.textTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixSpace>(
        'space',
        space,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixRadiusFactor>(
        'radius',
        radius,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixShadowSwatch>(
        'shadows',
        shadows,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixBadgeThemeData>(
        'badgeTheme',
        badgeTheme,
        defaultValue: defaultData.badgeTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixButtonThemeData>(
        'buttonTheme',
        buttonTheme,
        defaultValue: defaultData.buttonTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixInputDecorationThemeData>(
        'inputDecorationTheme',
        inputDecorationTheme,
        defaultValue: defaultData.inputDecorationTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixInputDecorationThemeData>(
        'selectDecorationTheme',
        selectDecorationTheme,
        defaultValue: defaultData.selectDecorationTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<RadixSpinnerThemeData>(
        'spinnerTheme',
        spinnerTheme,
        defaultValue: defaultData.spinnerTheme,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      ColorProperty(
        'selectionColor',
        selectionColor,
        defaultValue: defaultData.textSelectionTheme.selectionColor,
        level: DiagnosticLevel.debug,
      ),
    );
  }

  @override
  RadixThemeExtension copyWith({
    RadixColorScheme? colorScheme,
    RadixTextTheme? textTheme,
    RadixSpace? space,
    RadixRadiusFactor? radius,
    RadixShadowSwatch? shadows,
    RadixBadgeThemeData? badgeTheme,
    RadixButtonThemeData? buttonTheme,
    RadixInputDecorationThemeData? inputDecorationTheme,
    RadixInputDecorationVariantTheme? inputDecorationVariantTheme,
    RadixInputDecorationThemeData? selectDecorationTheme,
    RadixSelectDecorationVariantTheme? selectDecorationVariantTheme,
    RadixSpinnerThemeData? spinnerTheme,
    Color? selectionColor,
  }) {
    return RadixThemeExtension(
      colorScheme: colorScheme ?? this.colorScheme,
      textTheme: textTheme ?? this.textTheme,
      space: space ?? this.space,
      radius: radius ?? this.radius,
      shadows: shadows ?? this.shadows,
      badgeTheme: badgeTheme ?? this.badgeTheme,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      inputDecorationTheme: inputDecorationTheme ?? this.inputDecorationTheme,
      inputDecorationVariantTheme: inputDecorationVariantTheme ?? this.inputDecorationVariantTheme,
      selectDecorationTheme: selectDecorationTheme ?? this.selectDecorationTheme,
      selectDecorationVariantTheme: selectDecorationVariantTheme ?? this.selectDecorationVariantTheme,
      spinnerTheme: spinnerTheme ?? this.spinnerTheme,
      selectionColor: selectionColor ?? this.selectionColor,
    );
  }
}
