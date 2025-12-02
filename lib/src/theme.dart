
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'badge.dart';
import 'button.dart';
import 'colors.dart';
import 'input_decorator.dart';
import 'radius.dart';
import 'shadow.dart';
import 'space.dart';
import 'spinner.dart';
import 'text_theme.dart';
import 'theme_data.dart';

/// Applies a theme to descendant widgets.
///
/// A theme describes the colors and typographic choices of an application.
///
/// Descendant widgets obtain the current theme's [RadixThemeData] object using
/// [RadixTheme.of]. When a widget uses [RadixTheme.of], it is automatically
/// rebuilt if the theme later changes, so that the changes can be applied.
class RadixTheme extends StatelessWidget {
  /// Applies the given theme [data] to [child].
  const RadixTheme({super.key, required this.data, required this.child});

  /// Specifies the color and typography values for descendant widgets.
  final RadixThemeData data;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  static final RadixThemeData kFallbackLight = RadixThemeData(
    extensions: {},
    colorScheme: RadixColorScheme.kLight,
    iconTheme: IconThemeData(color: kDefaultIconLightColor),
    textTheme: RadixTextTheme.kDefault,
    space: RadixSpace.kDefault,
    radius: RadixRadiusFactor.kDefault,
    shadows: RadixShadowSwatch.kLight,
    badgeTheme: RadixBadgeThemeData.kLight,
    buttonTheme: RadixButtonThemeData.kLight,
    inputDecorationTheme: RadixInputDecorationThemeData.from(
      variant: RadixInputDecorationVariantTheme.kLight.surface,
      size: RadixInputDecorationVariantTheme.kLight.sizeSwatch.s2,
    ),
    inputDecorationVariantTheme: RadixInputDecorationVariantTheme.kLight,
    spinnerTheme: RadixSpinnerThemeData.kLight,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: RadixColorScheme.kLight.focus.radixScale_5.alphaVariant,
    ),
  );

  static final RadixThemeData kFallbackDark = RadixThemeData(
    extensions: {},
    colorScheme: RadixColorScheme.kDark,
    iconTheme: IconThemeData(color: kDefaultIconLightColor),
    textTheme: RadixTextTheme.kDefault,
    space: RadixSpace.kDefault,
    radius: RadixRadiusFactor.kDefault,
    shadows: RadixShadowSwatch.kDark,
    badgeTheme: RadixBadgeThemeData.kDark,
    buttonTheme: RadixButtonThemeData.kDark,
    inputDecorationTheme: RadixInputDecorationThemeData.from(
      variant: RadixInputDecorationVariantTheme.kDark.surface,
      size: RadixInputDecorationVariantTheme.kDark.sizeSwatch.s2,
    ),
    inputDecorationVariantTheme: RadixInputDecorationVariantTheme.kDark,
    spinnerTheme: RadixSpinnerThemeData.kDark,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: RadixColorScheme.kDark.focus.radixScale_5.alphaVariant,
    ),
  );

  static final RadixThemeExtension kExtensionFallbackLight = RadixThemeExtension(
    colorScheme: RadixColorScheme.kLight,
    textTheme: RadixTextTheme.kDefault,
    space: RadixSpace.kDefault,
    radius: RadixRadiusFactor.kDefault,
    shadows: RadixShadowSwatch.kLight,
    badgeTheme: RadixBadgeThemeData.kLight,
    buttonTheme: RadixButtonThemeData.kLight,
    inputDecorationTheme: RadixInputDecorationThemeData.from(
      variant: RadixInputDecorationVariantTheme.kLight.surface,
      size: RadixInputDecorationVariantTheme.kLight.sizeSwatch.s2,
    ),
    inputDecorationVariantTheme: RadixInputDecorationVariantTheme.kLight,
    spinnerTheme: RadixSpinnerThemeData.kLight,
    selectionColor: RadixColorScheme.kLight.focus.radixScale_5.alphaVariant,
  );

  static final RadixThemeExtension kExtensionFallbackDark = RadixThemeExtension(
    colorScheme: RadixColorScheme.kDark,
    textTheme: RadixTextTheme.kDefault,
    space: RadixSpace.kDefault,
    radius: RadixRadiusFactor.kDefault,
    shadows: RadixShadowSwatch.kDark,
    badgeTheme: RadixBadgeThemeData.kDark,
    buttonTheme: RadixButtonThemeData.kDark,
    inputDecorationTheme: RadixInputDecorationThemeData.from(
      variant: RadixInputDecorationVariantTheme.kDark.surface,
      size: RadixInputDecorationVariantTheme.kDark.sizeSwatch.s2,
    ),
    inputDecorationVariantTheme: RadixInputDecorationVariantTheme.kDark,
    spinnerTheme: RadixSpinnerThemeData.kDark,
    selectionColor: RadixColorScheme.kDark.focus.radixScale_5.alphaVariant,
  );

  /// The data from the closest [RadixTheme] instance that encloses the given
  /// context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///   return Text(
  ///     'Example',
  ///     style: RadixTheme.of(context).textTheme.scale_9,
  ///   );
  /// }
  /// ```
  ///
  /// When the [RadixTheme] is actually created in the same `build` function
  /// (possibly indirectly, e.g. as part of a [RadixApp]), the `context`
  /// argument to the `build` function can't be used to find the [RadixTheme]
  /// (since it's "above" the widget being returned). In such cases,
  /// the following technique with a [Builder] can be used to provide
  /// a new scope with a [BuildContext] that is "under" the [RadixTheme]:
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///   return RadixApp(
  ///     theme: RadixThemeData.light(),
  ///     home: Builder(
  ///       // Create an inner BuildContext so that we can refer to
  ///       // the Theme with RadixTheme.of().
  ///       builder: (BuildContext context) {
  ///         return Center(
  ///           child: Text(
  ///             'Example',
  ///             style: RadixTheme.of(context).textTheme.scale_3,
  ///           ),
  ///         );
  ///       },
  ///     ),
  ///   );
  /// }
  /// ```
  ///
  /// See also:
  ///
  /// * [RadixColorScheme.of], a convenience method that returns [RadixThemeData.colorScheme]
  ///   from the closest [RadixTheme] ancestor. (equivalent to `RadixTheme.of(context).colorScheme`).
  /// * [RadixTextTheme.of], a convenience method that returns [RadixThemeData.textTheme]
  ///   from the closest [RadixTheme] ancestor. (equivalent to `RadixTheme.of(context).textTheme`).
  static RadixThemeData of(BuildContext context) {
    final RadixThemeData theme = maybeOf(context) ?? kFallbackLight;
    return theme;
  }

  static RadixThemeData? maybeOf(BuildContext context) {
    final _InheritedTheme? inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    final RadixThemeData? theme = inheritedTheme?.theme.data;
    return theme;
  }

  /// The [RadixThemeExtension] from the closest [Theme] instance that
  /// encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// RadixThemeExtension radixTheme = RadixTheme.fromTheme(context);
  /// ```
  ///
  /// See also:
  ///
  /// * [RadixColorScheme.fromTheme], a convenience method that returns [RadixThemeExtension.colorScheme]
  ///   from the closest [Theme] ancestor. (equivalent to `RadixTheme.fromTheme(context).colorScheme`).
  /// * [RadixTextTheme.fromTheme], a convenience method that returns [RadixThemeExtension.textTheme]
  ///   from the closest [Theme] ancestor. (equivalent to `RadixTheme.fromTheme(context).textTheme`).
  static RadixThemeExtension fromTheme(BuildContext context) {
    final RadixThemeExtension theme = Theme.of(context).extension<RadixThemeExtension>()!;
    return theme;
  }

  /// The [RadixThemeExtension] from the [Theme] instance.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ThemeData theme = Theme.of(context);
  /// RadixThemeExtension radixTheme = RadixTheme.extensionFrom(theme);
  /// ```
  ///
  /// See also:
  ///
  /// * [RadixColorScheme.extensionFrom], a convenience method that returns [RadixThemeData.colorScheme]
  ///   from the closest [Theme] ancestor. (equivalent to `RadixTheme.extensionFrom(themeData).colorScheme`).
  /// * [RadixTextTheme.extensionFrom], a convenience method that returns [RadixThemeData.textTheme]
  ///   from the closest [Theme] ancestor. (equivalent to `RadixTheme.extensionFrom(context).textTheme`).
  static RadixThemeExtension extensionFrom(ThemeData themeData) {
    return themeData.extension<RadixThemeExtension>()!;
  }

  // The inherited themes in widgets library can not infer their values from
  // Theme in material library. Wraps the child with these inherited themes to
  // overrides their values directly.
  Widget _wrapsWidgetThemes(BuildContext context, Widget child) {
    final DefaultSelectionStyle selectionStyle = DefaultSelectionStyle.of(context);
    return IconTheme(
      data: data.iconTheme,
      child: DefaultSelectionStyle(
        selectionColor: data.textSelectionTheme.selectionColor ?? selectionStyle.selectionColor,
        cursorColor: data.textSelectionTheme.cursorColor ?? selectionStyle.cursorColor,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: _wrapsWidgetThemes(context, child),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<RadixThemeData>('data', data, showName: false));
  }
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({required this.theme, required super.child});

  final RadixTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return RadixTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}
