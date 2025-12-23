import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'theme.dart';
import 'theme_data.dart';

/// To obtain the current text theme, call [RadixTextTheme.of] with the current
/// [BuildContext]. This is equivalent to calling [RadixTheme.of] and reading
/// the [RadixThemeData.textTheme] property.
///
/// The typographic system is based on a 9-step `size` scale.
/// Every step has a corresponding font size, line height and letter spacing
/// value which are all designed to be used in combination.
///
/// See also:
///
///  * <https://www.radix-ui.com/themes/docs/theme/typography>
@immutable
final class RadixTextTheme with Diagnosticable {
  /// Creates a Radix text theme that uses the given values.
  const RadixTextTheme({
    required this.scale_1,
    required this.scale_2,
    required this.scale_3,
    required this.scale_4,
    required this.scale_5,
    required this.scale_6,
    required this.scale_7,
    required this.scale_8,
    required this.scale_9,
    required this.scaleDefault,
  });

  final TextStyle scale_1;
  final TextStyle scale_2;
  final TextStyle scale_3;
  final TextStyle scale_4;
  final TextStyle scale_5;
  final TextStyle scale_6;
  final TextStyle scale_7;
  final TextStyle scale_8;
  final TextStyle scale_9;

  final TextStyle scaleDefault;

  static const RadixTextTheme kDefault = RadixTextTheme(
    scale_1: TextStyle(
      fontSize: 12,
      letterSpacing: -(12 * 0.0025),
      height: 16 / 12,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    scale_2: TextStyle(
      fontSize: 14,
      height: 20 / 14,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    scale_3: TextStyle(
      fontSize: 16,
      height: 24 / 16,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    scale_4: TextStyle(
      fontSize: 18,
      letterSpacing: -(18 * 0.0025),
      height: 26 / 18,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    scale_5: TextStyle(
      fontSize: 20,
      letterSpacing: -(20 * 0.005),
      height: 28 / 20,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    scale_6: TextStyle(
      fontSize: 24,
      letterSpacing: -(24 * 0.00625),
      height: 30 / 24,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    scale_7: TextStyle(
      fontSize: 28,
      letterSpacing: -(36 * 0.0075),
      height: 36 / 28,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    scale_8: TextStyle(
      fontSize: 35,
      letterSpacing: -(35 * 0.01),
      height: 40 / 35,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    scale_9: TextStyle(
      fontSize: 60,
      letterSpacing: -(60 * 0.025),
      height: 60 / 60,
      leadingDistribution: TextLeadingDistribution.even,
    ),
    scaleDefault: TextStyle(
      fontSize: 16,
      height: 24 / 16,
      leadingDistribution: TextLeadingDistribution.even,
    ),
  );

  /// Linearly interpolate between two text themes.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixTextTheme lerp(RadixTextTheme? a, RadixTextTheme? b, double t) {
    if (identical(a, b) && a != null) {
      return a;
    }
    return RadixTextTheme(
      scale_1: TextStyle.lerp(a?.scale_1, b?.scale_1, t)!,
      scale_2: TextStyle.lerp(a?.scale_2, b?.scale_2, t)!,
      scale_3: TextStyle.lerp(a?.scale_3, b?.scale_3, t)!,
      scale_4: TextStyle.lerp(a?.scale_4, b?.scale_4, t)!,
      scale_5: TextStyle.lerp(a?.scale_5, b?.scale_5, t)!,
      scale_6: TextStyle.lerp(a?.scale_6, b?.scale_6, t)!,
      scale_7: TextStyle.lerp(a?.scale_7, b?.scale_7, t)!,
      scale_8: TextStyle.lerp(a?.scale_8, b?.scale_8, t)!,
      scale_9: TextStyle.lerp(a?.scale_9, b?.scale_9, t)!,
      scaleDefault: TextStyle.lerp(a?.scaleDefault, b?.scaleDefault, t)!,
    );
  }

  /// The [RadixThemeData.textTheme] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).textTheme`.
  static RadixTextTheme of(BuildContext context) => RadixTheme.of(context).textTheme;

  /// The [RadixThemeExtension.textTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).textTheme`.
  static RadixTextTheme fromTheme(BuildContext context) => RadixTheme.fromTheme(context).textTheme;

  /// The [RadixThemeExtension.textTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).textTheme`.
  static RadixTextTheme extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).textTheme;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is RadixTextTheme &&
        scale_1 == other.scale_1 &&
        scale_2 == other.scale_2 &&
        scale_3 == other.scale_3 &&
        scale_4 == other.scale_4 &&
        scale_5 == other.scale_5 &&
        scale_6 == other.scale_6 &&
        scale_7 == other.scale_7 &&
        scale_8 == other.scale_8 &&
        scale_9 == other.scale_9 &&
        scaleDefault == other.scaleDefault;
  }

  @override
  int get hashCode => Object.hash(
    scale_1,
    scale_2,
    scale_3,
    scale_4,
    scale_5,
    scale_6,
    scale_7,
    scale_8,
    scale_9,
    scaleDefault,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'scale_1',
        scale_1,
        defaultValue: kDefault.scale_1,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'scale_2',
        scale_2,
        defaultValue: kDefault.scale_2,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'scale_3',
        scale_3,
        defaultValue: kDefault.scale_3,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'scale_4',
        scale_4,
        defaultValue: kDefault.scale_4,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'scale_5',
        scale_5,
        defaultValue: kDefault.scale_5,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'scale_6',
        scale_6,
        defaultValue: kDefault.scale_6,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'scale_7',
        scale_7,
        defaultValue: kDefault.scale_7,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'scale_8',
        scale_8,
        defaultValue: kDefault.scale_8,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'scale_9',
        scale_9,
        defaultValue: kDefault.scale_9,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'scaleDefault',
        scaleDefault,
        defaultValue: kDefault.scaleDefault,
      ),
    );
  }
}

abstract final class RadixFigmaTextFontVariations {
  static const List<FontVariation> regular_400 = [
    FontVariation('wght', 400),
    FontVariation('slnt', 0),
    FontVariation('wdth', 100),
  ];

  static const List<FontVariation> medium_510 = [
    FontVariation('wght', 510),
    FontVariation('slnt', 0),
    FontVariation('wdth', 100),
  ];

  static const List<FontVariation> bold_700 = [
    FontVariation('wght', 700),
    FontVariation('slnt', 0),
    FontVariation('wdth', 100),
  ];
}
