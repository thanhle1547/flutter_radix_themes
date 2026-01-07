import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'theme.dart';
import 'theme_data.dart';

final class RadixColorScheme with Diagnosticable {
  /// Create a RadixColorScheme instance from the given colors.
  const RadixColorScheme({
    // For the sanity of the reader, make sure these properties are in the same
    // order in every place.

    required this.gray,
    required this.accent,
    required this.neutral,
    required this.error,
    required this.success,
    required this.warning,
    required this.info,
    required this.textColor,
    this.headingColor,
    required this.pageBackgroundColor,
    required this.panelSolidColor,
    required this.panelTranslucentColor,
    required this.surfaceColor,
    required this.overlayColor,
  }) : focus = accent;

  final RadixColorsSwatch gray;

  /// The accent swatch.
  final RadixColorsSwatch accent;

  final RadixColorsSwatch focus;

  /// The neutral swatch.
  final RadixColorsSwatch neutral;

  /// The error swatch.
  final RadixColorsSwatch error;

  /// The success swatch.
  final RadixColorsSwatch success;

  /// The warning swatch.
  final RadixColorsSwatch warning;

  /// The info swatch.
  final RadixColorsSwatch info;

  // SEMANTIC COLORS

  /// The default text color for [Text] in the application.
  ///
  /// Figma variable: `Tokens/Colors/text`
  final Color textColor;

  /// The default heading color.
  final Color? headingColor;

  /// A color used for page backgrounds.
  final Color pageBackgroundColor;

  /// The color to use for panel backgrounds, such as cards, tables,
  /// popovers, dropdown menus, etc. to present information unobstructed.
  ///
  /// Figma variable: `Panel/solid`
  ///
  /// CSS variable: `--color-panel-solid`
  final Color panelSolidColor;

  /// The color to use for panel backgrounds, such as cards, tables,
  /// popovers, dropdown menus, etc. to create a subtle overlay effect.
  ///
  /// Figma variable: `Panel/translucent`
  ///
  /// CSS variable: `--color-panel-translucent`
  final Color panelTranslucentColor;

  /// The color to use for form component backgrounds, such as
  /// text fields, checkboxes, select, etc.
  ///
  /// CSS variable: `--color-surface`
  final Color surfaceColor;

  /// The color to use for dialog overlays.
  ///
  /// Figma variable: `Tokens/Colors/overlay`
  ///
  /// CSS variable: `--color-overlay`
  final Color overlayColor;

  static final RadixColorScheme kLight = RadixColorScheme(
    gray: RadixLightColors.slate,
    accent: RadixLightColors.indigo,
    neutral: RadixLightColors.slate,
    error: RadixLightColors.red,
    success: RadixLightColors.green,
    warning: RadixLightColors.amber,
    info: RadixLightColors.sky,
    textColor: RadixLightColors.slate.scale_12,
    headingColor: RadixLightColors.indigo.radixScale_12.alphaVariant,
    pageBackgroundColor: RadixColors.white,
    panelSolidColor: RadixColors.white,
    panelTranslucentColor: Color.fromRGBO(255, 255, 255, 0.8),
    // CSS version is:
    // panelTranslucentColor: Color.fromRGBO(255, 255, 255, 0.7),
    surfaceColor: Color.fromRGBO(255, 255, 255, 0.85),
    overlayColor: RadixColors.black.alphaVariantSwatch.scale_6,
  );

  static final RadixColorScheme kDark = RadixColorScheme(
    gray: RadixDarkColors.slate,
    accent: RadixDarkColors.indigo,
    neutral: RadixDarkColors.slate,
    error: RadixDarkColors.red,
    success: RadixDarkColors.green,
    warning: RadixDarkColors.amber,
    info: RadixDarkColors.sky,
    textColor: RadixColors.white,
    headingColor: RadixDarkColors.indigo.radixScale_12.alphaVariant,
    pageBackgroundColor: RadixColors.white,
    panelSolidColor: RadixDarkColors.slate.scale_2, // It's RadixColorScheme.neutral.scale_2
    // CSS version is:
    // panelSolidColor: RadixDarkColors.slate.scale_2, // It's RadixColorScheme.gray.scale_2
    panelTranslucentColor: Color.fromRGBO(29, 29, 33, 0.7),
    // CSS version is:
    // panelTranslucentColor: RadixDarkColors.slate.radixScale_2.alphaVariant, // It's RadixColorScheme.gray.radixScale_2.alphaVariant
    surfaceColor: Color.fromRGBO(0, 0, 0, 0.25),
    overlayColor: RadixColors.black.alphaVariantSwatch.scale_8,
  );

  /// Linearly interpolate between two [RadixColorScheme] objects.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixColorScheme lerp(RadixColorScheme a, RadixColorScheme b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return RadixColorScheme(
      gray: RadixColorsSwatch.lerp(a.gray, b.gray, t)!,
      accent: RadixColorsSwatch.lerp(a.accent, b.accent, t)!,
      neutral: RadixColorsSwatch.lerp(a.neutral, b.neutral, t)!,
      error: RadixColorsSwatch.lerp(a.error, b.error, t)!,
      success: RadixColorsSwatch.lerp(a.success, b.success, t)!,
      warning: RadixColorsSwatch.lerp(a.warning, b.warning, t)!,
      info: RadixColorsSwatch.lerp(a.info, b.info, t)!,
      textColor: Color.lerp(a.textColor, b.textColor, t)!,
      headingColor: Color.lerp(a.headingColor, b.headingColor, t),
      pageBackgroundColor: Color.lerp(a.pageBackgroundColor, b.pageBackgroundColor, t)!,
      panelSolidColor: Color.lerp(a.panelSolidColor, b.panelSolidColor, t)!,
      panelTranslucentColor: Color.lerp(a.panelTranslucentColor, b.panelTranslucentColor, t)!,
      surfaceColor: Color.lerp(a.surfaceColor, b.surfaceColor, t)!,
      overlayColor: Color.lerp(a.overlayColor, b.overlayColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is RadixColorScheme &&
        other.gray == gray &&
        other.accent == accent &&
        other.neutral == neutral &&
        other.error == error &&
        other.success == success &&
        other.warning == warning &&
        other.info == info &&
        other.textColor == textColor &&
        other.headingColor == headingColor &&
        other.pageBackgroundColor == pageBackgroundColor &&
        other.panelSolidColor == panelSolidColor &&
        other.panelTranslucentColor == panelTranslucentColor &&
        other.surfaceColor == surfaceColor &&
        other.overlayColor == overlayColor;
  }

  @override
  int get hashCode => Object.hash(
    gray,
    accent,
    neutral,
    error,
    success,
    warning,
    info,
    textColor,
    headingColor,
    pageBackgroundColor,
    panelSolidColor,
    panelTranslucentColor,
    surfaceColor,
    overlayColor,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('textColor', textColor));
    properties.add(ColorProperty('headingColor', headingColor));
    properties.add(ColorProperty('pageBackgroundColor', pageBackgroundColor));
    properties.add(ColorProperty('panelSolidColor', panelSolidColor));
    properties.add(ColorProperty('panelTranslucentColor', panelTranslucentColor));
    properties.add(ColorProperty('surfaceColor', surfaceColor));
    properties.add(ColorProperty('overlayColor', overlayColor));
  }

  /// The [RadixThemeData.colorScheme] of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).colorScheme`.
  static RadixColorScheme of(BuildContext context) => RadixTheme.of(context).colorScheme;

  /// The [RadixThemeExtension.colorScheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).colorScheme`.
  static RadixColorScheme fromTheme(BuildContext context) => RadixTheme.fromTheme(context).colorScheme;

  /// The [RadixThemeExtension.colorScheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).colorScheme`.
  static RadixColorScheme extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).colorScheme;
}

/// [Color], [RadixColor] and [RadixDynamicColorsSwatch] constants which
/// represent [Radix Color](https://www.radix-ui.com/themes/docs/theme/color),
/// that can be used to configure the color properties of most components.
///
/// Each accent color includes a solid and a transparent variant.
/// These accent colors are used for interactive elements such as buttons, links,
/// and highlights.
///
/// See also:
///
///  * <https://www.radix-ui.com/themes/docs/theme/color>
abstract final class RadixColors {
  /// Completely invisible.
  static const Color transparent = Color(0x00000000);

  /// Completely opaque white.
  static const RadixOverlayColor white = RadixOverlayColor(
    0xFFFFFFFF,
    RadixColorsSwatch([
      /* 1  */ Color.fromRGBO(255, 255, 255, 0.05),
      /* 2  */ Color.fromRGBO(255, 255, 255, 0.1 ),
      /* 3  */ Color.fromRGBO(255, 255, 255, 0.15),
      /* 4  */ Color.fromRGBO(255, 255, 255, 0.2 ),
      /* 5  */ Color.fromRGBO(255, 255, 255, 0.3 ),
      /* 6  */ Color.fromRGBO(255, 255, 255, 0.4 ),
      /* 7  */ Color.fromRGBO(255, 255, 255, 0.5 ),
      /* 8  */ Color.fromRGBO(255, 255, 255, 0.6 ),
      /* 9  */ Color.fromRGBO(255, 255, 255, 0.7 ),
      /* 10 */ Color.fromRGBO(255, 255, 255, 0.8 ),
      /* 11 */ Color.fromRGBO(255, 255, 255, 0.9 ),
      /* 12 */ Color.fromRGBO(255, 255, 255, 0.95),
    ]),
    // Figma variable: `Tokens/Colors/white-contrast`
    contrast: Color(0xFFFFFFFF),
  );

  static const RadixOverlayColor black = RadixOverlayColor(
    0xFF1C2024,
    RadixColorsSwatch([
      /* 1  */ Color.fromRGBO(0  , 0  , 0  , 0.05),
      /* 2  */ Color.fromRGBO(0  , 0  , 0  , 0.1 ),
      /* 3  */ Color.fromRGBO(0  , 0  , 0  , 0.15),
      /* 4  */ Color.fromRGBO(0  , 0  , 0  , 0.2 ),
      /* 5  */ Color.fromRGBO(0  , 0  , 0  , 0.3 ),
      /* 6  */ Color.fromRGBO(0  , 0  , 0  , 0.4 ),
      /* 7  */ Color.fromRGBO(0  , 0  , 0  , 0.5 ),
      /* 8  */ Color.fromRGBO(0  , 0  , 0  , 0.6 ),
      /* 9  */ Color.fromRGBO(0  , 0  , 0  , 0.7 ),
      /* 10 */ Color.fromRGBO(0  , 0  , 0  , 0.8 ),
      /* 11 */ Color.fromRGBO(0  , 0  , 0  , 0.9 ),
      /* 12 */ Color.fromRGBO(0  , 0  , 0  , 0.95),
    ]),
    // Figma variable: `Tokens/Colors/black-contrast`
    contrast: Color(0xFF1C2024),
  );

  /// A pure gray color.
  static const RadixDynamicColorsSwatch gray = RadixDynamicColorsSwatch(
    debugLabel: 'gray',
    light: RadixLightColors.gray,
    dark: RadixDarkColors.gray,
  );

  /// A tinted gray color.
  static const RadixDynamicColorsSwatch slate = RadixDynamicColorsSwatch(
    debugLabel: 'slate',
    light: RadixLightColors.slate,
    dark: RadixDarkColors.slate,
  );

  /// A tinted gray color.
  static const RadixDynamicColorsSwatch sand = RadixDynamicColorsSwatch(
    debugLabel: 'sand',
    light: RadixLightColors.sand,
    dark: RadixDarkColors.sand,
  );

  static const RadixDynamicColorsSwatch red = RadixDynamicColorsSwatch(
    debugLabel: 'red',
    light: RadixLightColors.red,
    dark: RadixDarkColors.red,
  );

  static const RadixDynamicColorsSwatch crimson = RadixDynamicColorsSwatch(
    debugLabel: 'crimson',
    light: RadixLightColors.crimson,
    dark: RadixDarkColors.crimson,
  );

  static const RadixDynamicColorsSwatch indigo = RadixDynamicColorsSwatch(
    debugLabel: 'indigo',
    light: RadixLightColors.indigo,
    dark: RadixDarkColors.indigo,
  );

  static const RadixDynamicColorsSwatch green = RadixDynamicColorsSwatch(
    debugLabel: 'green',
    light: RadixLightColors.green,
    dark: RadixDarkColors.green,
  );

  static const RadixDynamicColorsSwatch amber = RadixDynamicColorsSwatch(
    debugLabel: 'amber',
    light: RadixLightColors.amber,
    dark: RadixDarkColors.amber,
  );

  static const RadixDynamicColorsSwatch sky = RadixDynamicColorsSwatch(
    debugLabel: 'sky',
    light: RadixLightColors.sky,
    dark: RadixDarkColors.sky,
  );
}

/// [Color], [RadixColor] and [RadixColorsSwatch] constants which
/// represent the Light Theme appearance of
/// [Radix Color](https://www.radix-ui.com/themes/docs/theme/color).
///
/// These constants can be used to configure the color properties of
/// most components when using the light color scheme.
///
/// Each accent color includes a solid and a transparent variant.
/// These accent colors are used for interactive elements such as buttons, links,
/// and highlights.
///
/// See also:
///
///  * <https://www.radix-ui.com/themes/docs/theme/color>
abstract final class RadixLightColors {
  /// A pure gray color.
  static const RadixColorsSwatch gray = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFFFCFCFC /* #FCFCFC */, Color.fromRGBO(0  , 0  , 0  , 0.0118)),
      /* 2  */ RadixColor(0xFFF9F9F9 /* #F9F9F9 */, Color.fromRGBO(0  , 0  , 0  , 0.0235)),
      /* 3  */ RadixColor(0xFFF0F0F0 /* #F0F0F0 */, Color.fromRGBO(0  , 0  , 0  , 0.0588)),
      /* 4  */ RadixColor(0xFFE8E8E8 /* #E8E8E8 */, Color.fromRGBO(0  , 0  , 0  , 0.0902)),
      /* 5  */ RadixColor(0xFFE0E0E0 /* #E0E0E0 */, Color.fromRGBO(0  , 0  , 0  , 0.1216)),
      /* 6  */ RadixColor(0xFFD9D9D9 /* #D9D9D9 */, Color.fromRGBO(0  , 0  , 0  , 0.149 )),
      /* 7  */ RadixColor(0xFFCECECE /* #CECECE */, Color.fromRGBO(0  , 0  , 0  , 0.1922)),
      /* 8  */ RadixColor(0xFFBBBBBB /* #BBBBBB */, Color.fromRGBO(0  , 0  , 0  , 0.2667)),
      /* 9  */ RadixColor(0xFF8D8D8D /* #8D8D8D */, Color.fromRGBO(0  , 0  , 0  , 0.4471)),
      /* 10 */ RadixColor(0xFF838383 /* #838383 */, Color.fromRGBO(0  , 0  , 0  , 0.4863)),
      /* 11 */ RadixColor(0xFF646464 /* #646464 */, Color.fromRGBO(0  , 0  , 0  , 0.6078)),
      /* 12 */ RadixColor(0xFF202020 /* #202020 */, Color.fromRGBO(0  , 0  , 0  , 0.8745)),
    ],
    debugLabel: 'gray (light)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0xCCFFFFFF),
  );

  /// A tinted gray color.
  static const RadixColorsSwatch slate = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFFFCFCFD /* #FCFCFD */, Color.fromRGBO(0  , 0  , 85 , 0.0118) /* #000055 */),
      /* 2  */ RadixColor(0xFFF9F9FB /* #F9F9FB */, Color.fromRGBO(0  , 0  , 85 , 0.0235) /* #000055 */),
      /* 3  */ RadixColor(0xFFF0F0F3 /* #F0F0F3 */, Color.fromRGBO(0  , 0  , 51 , 0.0588) /* #000033 */),
      /* 4  */ RadixColor(0xFFE8E8EC /* #E8E8EC */, Color.fromRGBO(0  , 0  , 45 , 0.0902) /* #00002D */),
      /* 5  */ RadixColor(0xFFE0E1E6 /* #E0E1E6 */, Color.fromRGBO(0  , 9  , 50 , 0.1216) /* #000932 */),
      /* 6  */ RadixColor(0xFFD9D9E0 /* #D9D9E0 */, Color.fromRGBO(0  , 0  , 47 , 0.149 ) /* #00002F */),
      /* 7  */ RadixColor(0xFFCDCED6 /* #CDCED6 */, Color.fromRGBO(0  , 6  , 46 , 0.1961) /* #00062E */),
      /* 8  */ RadixColor(0xFFB9BBC6 /* #B9BBC6 */, Color.fromRGBO(0  , 8  , 48 , 0.2745) /* #000830 */),
      /* 9  */ RadixColor(0xFF8B8D98 /* #8B8D98 */, Color.fromRGBO(0  , 5  , 29 , 0.4549) /* #00051D */),
      /* 10 */ RadixColor(0xFF80838D /* #80838D */, Color.fromRGBO(0  , 7  , 27 , 0.498 ) /* #00071B */),
      /* 11 */ RadixColor(0xFF60646C /* #60646C */, Color.fromRGBO(0  , 7  , 20 , 0.6235) /* #000714 */),
      /* 12 */ RadixColor(0xFF1C2024 /* #1C2024 */, Color.fromRGBO(0  , 5  , 9  , 0.8902) /* #000509 */),
    ],
    debugLabel: 'slate (light)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0xCCFFFFFF),
  );

  /// A tinted gray color.
  static const RadixColorsSwatch sand = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFFFDFDFC /* #FDFDFC */, Color.fromRGBO(85 , 85 , 0  , 0.0118) /* #555500 */),
      /* 2  */ RadixColor(0xFFF9F9F8 /* #F9F9F8 */, Color.fromRGBO(37 , 37 , 0  , 0.0275) /* #252500 */),
      /* 3  */ RadixColor(0xFFF1F0EF /* #F1F0EF */, Color.fromRGBO(32 , 16 , 0  , 0.0627) /* #201000 */),
      /* 4  */ RadixColor(0xFFE9E8E6 /* #E9E8E6 */, Color.fromRGBO(31 , 21 , 0  , 0.088 ) /* #1F1500 */),
      /* 5  */ RadixColor(0xFFE2E1DE /* #E2E1DE */, Color.fromRGBO(31 , 24 , 0  , 0.1294) /* #1F1800 */),
      /* 6  */ RadixColor(0xFFDAD9D6 /* #DAD9D6 */, Color.fromRGBO(25 , 19 , 0  , 0.1608) /* #191300 */),
      /* 7  */ RadixColor(0xFFCFCECA /* #CFCECA */, Color.fromRGBO(25 , 20 , 0  , 0.2078) /* #191400 */),
      /* 8  */ RadixColor(0xFFBCBBB5 /* #BCBBB5 */, Color.fromRGBO(25 , 21 , 1  , 0.2902) /* #191501 */),
      /* 9  */ RadixColor(0xFF8D8D86 /* #8D8D86 */, Color.fromRGBO(15 , 15 , 0  , 0.4745) /* #0F0F00 */),
      /* 10 */ RadixColor(0xFF82827C /* #82827C */, Color.fromRGBO(12 , 12 , 0  , 0.5137) /* #0C0C00 */),
      /* 11 */ RadixColor(0xFF63635E /* #63635E */, Color.fromRGBO(8  , 8  , 0  , 0.6314) /* #080800 */),
      /* 12 */ RadixColor(0xFF21201C /* #21201C */, Color.fromRGBO(6  , 5  , 0  , 0.8902) /* #060500 */),
    ],
    debugLabel: 'sand (light)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0xCCFFFFFF),
  );

  static const RadixColorsSwatch red = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFFFFFCFC /* #FFFCFC */, Color.fromRGBO(255, 0  , 0  , 0.0118) /* #FF0000 */),
      /* 2  */ RadixColor(0xFFFFF7F7 /* #FFF7F7 */, Color.fromRGBO(255, 0  , 0  , 0.0314) /* #FF0000 */),
      /* 3  */ RadixColor(0xFFFEEBEC /* #FEEBEC */, Color.fromRGBO(243, 0  , 13 , 0.0784) /* #F3000D */),
      /* 4  */ RadixColor(0xFFFFDBDC /* #FFDBDC */, Color.fromRGBO(255, 0  , 8  , 0.1412) /* #FF0008 */),
      /* 5  */ RadixColor(0xFFFFCDCE /* #FFCDCE */, Color.fromRGBO(255, 0  , 4  , 0.1961) /* #FF0006 */),
      /* 6  */ RadixColor(0xFFFDBDBE /* #FDBDBE */, Color.fromRGBO(248, 0  , 4  , 0.2588) /* #F80004 */),
      /* 7  */ RadixColor(0xFFF4A9AA /* #F4A9AA */, Color.fromRGBO(223, 0  , 3  , 0.3373) /* #DF0003 */),
      /* 8  */ RadixColor(0xFFEB8E90 /* #EB8E90 */, Color.fromRGBO(210, 0  , 5  , 0.4431) /* #D20005 */),
      /* 9  */ RadixColor(0xFFE5484D /* #E5484D */, Color.fromRGBO(219, 0  , 7  , 0.7176) /* #DB0007 */),
      /* 10 */ RadixColor(0xFFDC3E42 /* #DC3E42 */, Color.fromRGBO(209, 0  , 5  , 0.7569) /* #D10005 */),
      /* 11 */ RadixColor(0xFFCE2C31 /* #CE2C31 */, Color.fromRGBO(196, 0  , 6  , 0.8275) /* #C40006 */),
      /* 12 */ RadixColor(0xFF641723 /* #641723 */, Color.fromRGBO(85 , 0  , 13 , 0.9098) /* #55000D */),
    ],
    debugLabel: 'red (light)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0xCCFFF5F5),
  );

  static const RadixColorsSwatch crimson = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFFFFFCFD /* #FFFCFD */, Color.fromRGBO(255, 0  , 85 , 0.0118) /* #FF0055 */),
      /* 2  */ RadixColor(0xFFFEF7F9 /* #FEF7F9 */, Color.fromRGBO(224, 0  , 64 , 0.0314) /* #E00040 */),
      /* 3  */ RadixColor(0xFFFFE9F0 /* #FFE9F0 */, Color.fromRGBO(255, 0  , 82 , 0.0863) /* #FF0052 */),
      /* 4  */ RadixColor(0xFFFEDCE7 /* #FEDCE7 */, Color.fromRGBO(248, 0  , 81 , 0.1373) /* #F80051 */),
      /* 5  */ RadixColor(0xFFFACEDD /* #FACEDD */, Color.fromRGBO(229, 0  , 79 , 0.1922) /* #E5004F */),
      /* 6  */ RadixColor(0xFFF3BED1 /* #F3BED1 */, Color.fromRGBO(208, 0  , 75 , 0.2549) /* #D0004B */),
      /* 7  */ RadixColor(0xFFEAACC3 /* #EAACC3 */, Color.fromRGBO(191, 0  , 71 , 0.3255) /* #BF0047 */),
      /* 8  */ RadixColor(0xFFE093B2 /* #E093B2 */, Color.fromRGBO(182, 0  , 74 , 0.4235) /* #B6004A */),
      /* 9  */ RadixColor(0xFFE93D82 /* #E93D82 */, Color.fromRGBO(226, 0  , 91 , 0.7608) /* #E2005B */),
      /* 10 */ RadixColor(0xFFDF3478 /* #DF3478 */, Color.fromRGBO(215, 0  , 86 , 0.7961) /* #D70056 */),
      /* 11 */ RadixColor(0xFFCB1D63 /* #CB1D63 */, Color.fromRGBO(196, 0  , 79 , 0.8863) /* #C4004F */),
      /* 12 */ RadixColor(0xFF621639 /* #621639 */, Color.fromRGBO(83 , 0  , 38 , 0.9137) /* #530026 */),
    ],
    debugLabel: 'crimson (light)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0xCCFFF5F5),
  );

  static const RadixColorsSwatch indigo = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFFFDFDFE /* #FDFDFE */, Color.fromRGBO(0  , 0  , 128, 0.0078) /* #000080 */),
      /* 2  */ RadixColor(0xFFF7F9FF /* #F7F9FF */, Color.fromRGBO(0  , 64 , 255, 0.0314) /* #0040FF */),
      /* 3  */ RadixColor(0xFFEDF2FE /* #EDF2FE */, Color.fromRGBO(0  , 71 , 241, 0.0706) /* #0047F1 */),
      /* 4  */ RadixColor(0xFFE1E9FF /* #E1E9FF */, Color.fromRGBO(0  , 68 , 255, 0.1176) /* #0044FF */),
      /* 5  */ RadixColor(0xFFD2DEFF /* #D2DEFF */, Color.fromRGBO(0  , 68 , 255, 0.1765) /* #0044FF */),
      /* 6  */ RadixColor(0xFFC1D0FF /* #C1D0FF */, Color.fromRGBO(0  , 62 , 255, 0.2431) /* #003EFF */),
      /* 7  */ RadixColor(0xFFABBDF9 /* #ABBDF9 */, Color.fromRGBO(0  , 55 , 237, 0.3294) /* #0037ED */),
      /* 8  */ RadixColor(0xFF8DA4EF /* #8DA4EF */, Color.fromRGBO(0  , 52 , 220, 0.4471) /* #0034DC */),
      /* 9  */ RadixColor(0xFF3E63DD /* #3E63DD */, Color.fromRGBO(0  , 49 , 210, 0.7569) /* #0031D2 */),
      /* 10 */ RadixColor(0xFF3358D4 /* #3358D4 */, Color.fromRGBO(0  , 46 , 201, 0.8   ) /* #002EC9 */),
      /* 11 */ RadixColor(0xFF3A5BC7 /* #3A5BC7 */, Color.fromRGBO(0  , 43 , 183, 0.7725) /* #002BB7 */),
      /* 12 */ RadixColor(0xFF1F2D5C /* #1F2D5C */, Color.fromRGBO(0  , 16 , 70 , 0.8784) /* #001046 */),
    ],
    debugLabel: 'indigo (light)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0xCCF5F8FF),
  );

  static const RadixColorsSwatch green = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFFFBFEFC /* #FBFEFC */, Color.fromRGBO(0  , 192, 64 , 0.0157) /* #00C040 */),
      /* 2  */ RadixColor(0xFFFFF7F7 /* #FFF7F7 */, Color.fromRGBO(0  , 163, 47 , 0.0431) /* #00A32F */),
      /* 3  */ RadixColor(0xFFE6F6EB /* #E6F6EB */, Color.fromRGBO(0  , 164, 51 , 0.098 ) /* #00A433 */),
      /* 4  */ RadixColor(0xFFD6F1DF /* #D6F1DF */, Color.fromRGBO(0  , 168, 56 , 0.1608) /* #00A838 */),
      /* 5  */ RadixColor(0xFFC4E8D1 /* #C4E8D1 */, Color.fromRGBO(1  , 156, 57 , 0.2314) /* #019C39 */),
      /* 6  */ RadixColor(0xFFADDDC0 /* #ADDDC0 */, Color.fromRGBO(0  , 150, 60 , 0.3216) /* #00963C */),
      /* 7  */ RadixColor(0xFF8ECEAA /* #8ECEAA */, Color.fromRGBO(0  , 145, 64 , 0.4431) /* #009140 */),
      /* 8  */ RadixColor(0xFF5BB98B /* #5BB98B */, Color.fromRGBO(0  , 146, 75 , 0.6431) /* #00924B */),
      /* 9  */ RadixColor(0xFF30A46C /* #30A46C */, Color.fromRGBO(0  , 143, 74 , 0.8118) /* #008F4A */),
      /* 10 */ RadixColor(0xFF2B9A66 /* #2B9A66 */, Color.fromRGBO(0  , 134, 71 , 0.8314) /* #008647 */),
      /* 11 */ RadixColor(0xFF218358 /* #218358 */, Color.fromRGBO(0  , 113, 63 , 0.8706) /* #00713F */),
      /* 12 */ RadixColor(0xFF193B2D /* #193B2D */, Color.fromRGBO(0  , 38 , 22 , 0.902 ) /* #002616 */),
    ],
    debugLabel: 'green (light)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0xCCF1FAF4),
  );

  static const RadixColorsSwatch amber = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFFFEFDFB /* #FEFDFB */, Color.fromRGBO(192, 128, 0  , 0.0157) /* #C08000 */),
      /* 2  */ RadixColor(0xFFFEFBE9 /* #FEFBE9 */, Color.fromRGBO(244, 209, 0  , 0.0863) /* #F4D100 */),
      /* 3  */ RadixColor(0xFFFFF7C2 /* #FFF7C2 */, Color.fromRGBO(255, 222, 0  , 0.2392) /* #FFDE00 */),
      /* 4  */ RadixColor(0xFFFFEE9C /* #FFEE9C */, Color.fromRGBO(255, 212, 0  , 0.3882) /* #FFD400 */),
      /* 5  */ RadixColor(0xFFFBE577 /* #FBE577 */, Color.fromRGBO(248, 207, 0  , 0.5333) /* #F8CF00 */),
      /* 6  */ RadixColor(0xFFF3D673 /* #F3D673 */, Color.fromRGBO(234, 181, 0  , 0.549 ) /* #EAB500 */),
      /* 7  */ RadixColor(0xFFE9C162 /* #E9C162 */, Color.fromRGBO(220, 155, 0  , 0.6157) /* #DC9B00 */),
      /* 8  */ RadixColor(0xFFE2A336 /* #E2A336 */, Color.fromRGBO(218, 138, 0  , 0.7882) /* #DA8A00 */),
      /* 9  */ RadixColor(0xFFFFC53D /* #FFC53D */, Color.fromRGBO(255, 179, 0  , 0.7608) /* #FFB300 */),
      /* 10 */ RadixColor(0xFFFFBA18 /* #FFBA18 */, Color.fromRGBO(255, 179, 0  , 0.9059) /* #FFB300 */),
      /* 11 */ RadixColor(0xFFAB6400 /* #AB6400 */, Color.fromRGBO(171, 100, 0  , 1     ) /* #AB6400 */),
      /* 12 */ RadixColor(0xFF4F3422 /* #4F3422 */, Color.fromRGBO(52 , 21 , 0  , 0.8667) /* #341500 */),
    ],
    debugLabel: 'amber (light)',
    contrast: Color(0xFF21201C),
    surface: Color(0xCCFEFAE4),
  );

  static const RadixColorsSwatch sky = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFFF9FEFF /* #F9FEFF */, Color.fromRGBO(0  , 213, 255, 0.0235) /* #00D5FF */),
      /* 2  */ RadixColor(0xFFF1FAFD /* #F1FAFD */, Color.fromRGBO(0  , 164, 219, 0.0549) /* #00A4DB */),
      /* 3  */ RadixColor(0xFFE1F6FD /* #E1F6FD */, Color.fromRGBO(0  , 179, 238, 0.1176) /* #00B3EE */),
      /* 4  */ RadixColor(0xFFD1F0FA /* #D1F0FA */, Color.fromRGBO(0  , 172, 228, 0.1804) /* #00ACE4 */),
      /* 5  */ RadixColor(0xFFBEE7F5 /* #BEE7F5 */, Color.fromRGBO(0  , 161, 216, 0.2549) /* #00A1D8 */),
      /* 6  */ RadixColor(0xFFA9DAED /* #A9DAED */, Color.fromRGBO(0  , 146, 202, 0.3373) /* #0092CA */),
      /* 7  */ RadixColor(0xFF8DCAE3 /* #8DCAE3 */, Color.fromRGBO(0  , 137, 193, 0.4471) /* #0089C1 */),
      /* 8  */ RadixColor(0xFF60B3D7 /* #60B3D7 */, Color.fromRGBO(0  , 133, 191, 0.6235) /* #0085BF */),
      /* 9  */ RadixColor(0xFF7CE2FE /* #7CE2FE */, Color.fromRGBO(0  , 199, 254, 0.5137) /* #00C7FE */),
      /* 10 */ RadixColor(0xFF74DAF8 /* #74DAF8 */, Color.fromRGBO(0  , 188, 243, 0.5451) /* #00BCF3 */),
      /* 11 */ RadixColor(0xFF00749E /* #00749E */, Color.fromRGBO(0  , 116, 158, 1     ) /* #00749E */),
      /* 12 */ RadixColor(0xFF1D3E56 /* #1D3E56 */, Color.fromRGBO(0  , 37 , 64 , 0.8863) /* #002540 */),
    ],
    debugLabel: 'sky (light)',
    contrast: Color(0xFF1C2024),
    surface: Color(0xCCEEF9FD),
  );
}

/// [Color], [RadixColor] and [RadixColorsSwatch] constants which
/// represent the Dark Theme appearance of
/// [Radix Color](https://www.radix-ui.com/themes/docs/theme/color).
///
/// These constants can be used to configure the color properties of
/// most components when using the dark color scheme.
///
/// Each accent color includes a solid and a transparent variant.
/// These accent colors are used for interactive elements such as buttons, links,
/// and highlights.
///
/// See also:
///
///  * <https://www.radix-ui.com/themes/docs/theme/color>
abstract final class RadixDarkColors {
  /// A pure gray color.
  static const RadixColorsSwatch gray = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFF111111 /* #111111 */, Color.fromRGBO(0  , 0  , 0  , 0     )),
      /* 2  */ RadixColor(0xFF191919 /* #191919 */, Color.fromRGBO(255, 255, 255, 0.0353)),
      /* 3  */ RadixColor(0xFF222222 /* #222222 */, Color.fromRGBO(255, 255, 255, 0.0706)),
      /* 4  */ RadixColor(0xFF2A2A2A /* #2A2A2A */, Color.fromRGBO(255, 255, 255, 0.1059)),
      /* 5  */ RadixColor(0xFF313131 /* #313131 */, Color.fromRGBO(255, 255, 255, 0.1333)),
      /* 6  */ RadixColor(0xFF3A3A3A /* #3A3A3A */, Color.fromRGBO(255, 255, 255, 0.1725)),
      /* 7  */ RadixColor(0xFF484848 /* #484848 */, Color.fromRGBO(255, 255, 255, 0.2341)),
      /* 8  */ RadixColor(0xFF6E6E6E /* #6E6E6E */, Color.fromRGBO(255, 255, 255, 0.3333)),
      /* 9  */ RadixColor(0xFF6E6E6E /* #6E6E6E */, Color.fromRGBO(255, 255, 255, 0.3922)),
      /* 10 */ RadixColor(0xFF7B7B7B /* #7B7B7B */, Color.fromRGBO(255, 255, 255, 0.4471)),
      /* 11 */ RadixColor(0xFFB4B4B4 /* #B4B4B4 */, Color.fromRGBO(255, 255, 255, 0.6863)),
      /* 12 */ RadixColor(0xFFEEEEEE /* #EEEEEE */, Color.fromRGBO(255, 255, 255, 0.9294)),
    ],
    debugLabel: 'gray',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0x80212121),
  );

  /// A tinted gray color.
  static const RadixColorsSwatch slate = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFF111113 /* #111113 */, Color.fromRGBO(0  , 0  , 0  , 0     ) /* #000000 */),
      /* 2  */ RadixColor(0xFF18191B /* #18191B */, Color.fromRGBO(216, 244, 246, 0.0353) /* #D8F4F6 */),
      /* 3  */ RadixColor(0xFF212225 /* #212225 */, Color.fromRGBO(221, 234, 248, 0.0784) /* #DDEAF8 */),
      /* 4  */ RadixColor(0xFF272A2D /* #272A2D */, Color.fromRGBO(211, 237, 248, 0.1137) /* #D3EDF8 */),
      /* 5  */ RadixColor(0xFF2E3135 /* #2E3135 */, Color.fromRGBO(217, 237, 254, 0.1451) /* #D9EDFE */),
      /* 6  */ RadixColor(0xFF363A3F /* #363A3F */, Color.fromRGBO(214, 235, 253, 0.1882) /* #D6EBFD */),
      /* 7  */ RadixColor(0xFF43484E /* #43484E */, Color.fromRGBO(217, 237, 255, 0.2501) /* #D9EDFF */),
      /* 8  */ RadixColor(0xFF5A6169 /* #5A6169 */, Color.fromRGBO(217, 237, 255, 0.3647) /* #D9EDFF */),
      /* 9  */ RadixColor(0xFF696E77 /* #696E77 */, Color.fromRGBO(223, 235, 253, 0.4275) /* #DFEBFD */),
      /* 10 */ RadixColor(0xFF777B84 /* #777B84 */, Color.fromRGBO(229, 237, 253, 0.4824) /* #E5EDFD */),
      /* 11 */ RadixColor(0xFFB0B4BA /* #B0B4BA */, Color.fromRGBO(241, 247, 254, 0.7098) /* #F1F7FE */),
      /* 12 */ RadixColor(0xFFEDEEF0 /* #EDEEF0 */, Color.fromRGBO(252, 253, 255, 0.9373) /* #FCFDFF */),
    ],
    debugLabel: 'slate (dark)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0x801F2123),
  );

  /// A tinted gray color.
  static const RadixColorsSwatch sand = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFF111110 /* #111110 */, Color.fromRGBO(0  , 0  , 0  , 0     ) /* #000000 */),
      /* 2  */ RadixColor(0xFF191918 /* #191918 */, Color.fromRGBO(244, 244, 243, 0.0353) /* #F4F4F3 */),
      /* 3  */ RadixColor(0xFF222221 /* #222221 */, Color.fromRGBO(246, 246, 245, 0.0745) /* #F6F6F5 */),
      /* 4  */ RadixColor(0xFF2A2A28 /* #2A2A28 */, Color.fromRGBO(254, 254, 243, 0.1059) /* #FEFEF3 */),
      /* 5  */ RadixColor(0xFF31312E /* #31312E */, Color.fromRGBO(251, 251, 235, 0.1373) /* #FBFBEB */),
      /* 6  */ RadixColor(0xFF3B3A37 /* #3B3A37 */, Color.fromRGBO(255, 250, 237, 0.1765) /* #FFFAED */),
      /* 7  */ RadixColor(0xFF494844 /* #494844 */, Color.fromRGBO(255, 251, 237, 0.2353) /* #FFFBED */),
      /* 8  */ RadixColor(0xFF62605B /* #62605B */, Color.fromRGBO(255, 249, 235, 0.3412) /* #FFF9EB */),
      /* 9  */ RadixColor(0xFF6F6D66 /* #6F6D66 */, Color.fromRGBO(255, 250, 233, 0.3961) /* #FFFAE9 */),
      /* 10 */ RadixColor(0xFF7C7B74 /* #7C7B74 */, Color.fromRGBO(255, 253, 238, 0.451 ) /* #FFFDEE */),
      /* 11 */ RadixColor(0xFFB5B3AD /* #B5B3AD */, Color.fromRGBO(255, 252, 244, 0.6902) /* #FFFCF4 */),
      /* 12 */ RadixColor(0xFFEEEEEC /* #EEEEEC */, Color.fromRGBO(255, 255, 253, 0.9294) /* #FFFFFD */),
    ],
    debugLabel: 'sand (dark)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0x80212120),
  );

  static const RadixColorsSwatch red = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFF191111 /* #191111 */, Color.fromRGBO(244, 18 , 18 , 0.0353) /* #F41212 */),
      /* 2  */ RadixColor(0xFF201314 /* #201314 */, Color.fromRGBO(242, 47 , 62 , 0.0667) /* #F22F3E */),
      /* 3  */ RadixColor(0xFF3B1219 /* #3B1219 */, Color.fromRGBO(255, 23 , 63 , 0.1765) /* #FF173F */),
      /* 4  */ RadixColor(0xFF500F1C /* #500F1C */, Color.fromRGBO(254, 10 , 59 , 0.2667) /* #FE0A3B */),
      /* 5  */ RadixColor(0xFF611623 /* #611623 */, Color.fromRGBO(255, 32 , 71 , 0.3373) /* #FF2047 */),
      /* 6  */ RadixColor(0xFF72232D /* #72232D */, Color.fromRGBO(255, 62 , 86 , 0.4078) /* #FF3E56 */),
      /* 7  */ RadixColor(0xFF8C333A /* #8C333A */, Color.fromRGBO(255, 83 , 97 , 0.5176) /* #FF5361 */),
      /* 8  */ RadixColor(0xFFB54548 /* #B54548 */, Color.fromRGBO(255, 93 , 97 , 0.6902) /* #FF5D61 */),
      /* 9  */ RadixColor(0xFFE5484D /* #E5484D */, Color.fromRGBO(254, 78 , 84 , 0.8941) /* #FE4E54 */),
      /* 10 */ RadixColor(0xFFEC5D5E /* #EC5D5E */, Color.fromRGBO(255, 100, 101, 0.9216) /* #FF6465 */),
      /* 11 */ RadixColor(0xFFFF9592 /* #FF9592 */, Color.fromRGBO(255, 149, 146, 1     ) /* #FF9592 */),
      /* 12 */ RadixColor(0xFFFFD1D9 /* #FFD1D9 */, Color.fromRGBO(255, 209, 217, 1     ) /* #FFD1D9 */),
    ],
    debugLabel: 'red (dark)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0x802F1517),
  );

  static const RadixColorsSwatch crimson = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFF191114 /* #191114 */, Color.fromRGBO(244, 18 , 103, 0.0353) /* #F41267 */),
      /* 2  */ RadixColor(0xFF201318 /* #201318 */, Color.fromRGBO(242, 47 , 122, 0.0667) /* #F22F7A */),
      /* 3  */ RadixColor(0xFF381525 /* #381525 */, Color.fromRGBO(254, 42 , 139, 0.1647) /* #FE2A8B */),
      /* 4  */ RadixColor(0xFF4D122F /* #4D122F */, Color.fromRGBO(253, 21 , 135, 0.2549) /* #FD1587 */),
      /* 5  */ RadixColor(0xFF5C1839 /* #5C1839 */, Color.fromRGBO(253, 39 , 143, 0.3176) /* #FD278F */),
      /* 6  */ RadixColor(0xFF6D2545 /* #6D2545 */, Color.fromRGBO(254, 69 , 151, 0.3882) /* #FE4597 */),
      /* 7  */ RadixColor(0xFF873356 /* #873356 */, Color.fromRGBO(253, 85 , 155, 0.498 ) /* #FD559B */),
      /* 8  */ RadixColor(0xFFB0436E /* #B0436E */, Color.fromRGBO(254, 91 , 155, 0.6706) /* #FE5B9B */),
      /* 9  */ RadixColor(0xFFE93D82 /* #E93D82 */, Color.fromRGBO(254, 65 , 141, 0.9098) /* #FE418D */),
      /* 10 */ RadixColor(0xFFEE518A /* #EE518A */, Color.fromRGBO(255, 86 , 147, 0.9294) /* #FF5693 */),
      /* 11 */ RadixColor(0xFFFF92AD /* #FF92AD */, Color.fromRGBO(255, 146, 173, 1     ) /* #FF92AD */),
      /* 12 */ RadixColor(0xFFFDD3E8 /* #FDD3E8 */, Color.fromRGBO(255, 213, 234, 0.9922) /* #FFD5EA */),
    ],
    debugLabel: 'crimson (dark)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0x802F151F),
  );

  static const RadixColorsSwatch indigo = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFF11131F /* #11131F */, Color.fromRGBO(17 , 51 , 255, 0.0588) /* #1133FF */),
      /* 2  */ RadixColor(0xFF141726 /* #141726 */, Color.fromRGBO(51 , 84 , 250, 0.0902) /* #3354FA */),
      /* 3  */ RadixColor(0xFF182449 /* #182449 */, Color.fromRGBO(41 , 84 , 250, 0.2353) /* #2F62FF */),
      /* 4  */ RadixColor(0xFF1D2E62 /* #1D2E62 */, Color.fromRGBO(53 , 102, 255, 0.3412) /* #3566FF */),
      /* 5  */ RadixColor(0xFF253974 /* #253974 */, Color.fromRGBO(65 , 113, 253, 0.4196) /* #4171FD */),
      /* 6  */ RadixColor(0xFF304384 /* #304384 */, Color.fromRGBO(81 , 120, 253, 0.4863) /* #5178FD */),
      /* 7  */ RadixColor(0xFF3A4F97 /* #3A4F97 */, Color.fromRGBO(90 , 127, 255, 0.5647) /* #5A7FFF */),
      /* 8  */ RadixColor(0xFF435DB1 /* #435DB1 */, Color.fromRGBO(91 , 129, 254, 0.6745) /* #5B81FE */),
      /* 9  */ RadixColor(0xFF3E63DD /* #3E63DD */, Color.fromRGBO(70 , 113, 255, 0.8588) /* #4671FF */),
      /* 10 */ RadixColor(0xFF5472E4 /* #5472E4 */, Color.fromRGBO(92 , 126, 254, 0.8902) /* #5C7EFE */),
      /* 11 */ RadixColor(0xFF9EB1FF /* #9EB1FF */, Color.fromRGBO(158, 177, 255, 1     ) /* #9EB1FF */),
      /* 12 */ RadixColor(0xFFD6E1FF /* #D6E1FF */, Color.fromRGBO(214, 225, 255, 1     ) /* #D6E1FF */),
    ],
    debugLabel: 'indigo (dark)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0x80171D3B),
  );

  static const RadixColorsSwatch green = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFF0E1512 /* #0E1512 */, Color.fromRGBO(0  , 222, 69 , 0.0196) /* #00DE45 */),
      /* 2  */ RadixColor(0xFF121B17 /* #121B17 */, Color.fromRGBO(41 , 249, 157, 0.0431) /* #29F99D */),
      /* 3  */ RadixColor(0xFF132D21 /* #132D21 */, Color.fromRGBO(34 , 255, 153, 0.1176) /* #22FF99 */),
      /* 4  */ RadixColor(0xFF113B29 /* #113B29 */, Color.fromRGBO(17 , 255, 153, 0.1765) /* #11FF99 */),
      /* 5  */ RadixColor(0xFF174933 /* #174933 */, Color.fromRGBO(43 , 255, 162, 0.2353) /* #2BFFA2 */),
      /* 6  */ RadixColor(0xFF20573E /* #20573E */, Color.fromRGBO(68 , 255, 170, 0.2941) /* #44FFAA */),
      /* 7  */ RadixColor(0xFF28684A /* #28684A */, Color.fromRGBO(80 , 253, 172, 0.3686) /* #50FDAC */),
      /* 8  */ RadixColor(0xFF2F7C57 /* #2F7C57 */, Color.fromRGBO(84 , 255, 173, 0.451 ) /* #54FFAD */),
      /* 9  */ RadixColor(0xFF30A46C /* #30A46C */, Color.fromRGBO(68 , 255, 164, 0.6196) /* #44FFA4 */),
      /* 10 */ RadixColor(0xFF33B074 /* #33B074 */, Color.fromRGBO(67 , 254, 164, 0.6706) /* #43FEA4 */),
      /* 11 */ RadixColor(0xFF3DD68C /* #3DD68C */, Color.fromRGBO(70 , 254, 165, 0.8314) /* #46FEA5 */),
      /* 12 */ RadixColor(0xFFB1F1CB /* #B1F1CB */, Color.fromRGBO(187, 255, 215, 0.9412) /* #BBFFD7 */),
    ],
    debugLabel: 'green (dark)',
    contrast: Color(0xFFFFFFFF),
    surface: Color(0x8015251D),
  );

  static const RadixColorsSwatch amber = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFF16120C /* #16120C */, Color.fromRGBO(192, 128, 0  , 0.0235) /* #E63C00 */),
      /* 2  */ RadixColor(0xFF1D180F /* #1D180F */, Color.fromRGBO(244, 209, 0  , 0.051 ) /* #FD9B00 */),
      /* 3  */ RadixColor(0xFF302008 /* #302008 */, Color.fromRGBO(255, 222, 0  , 0.1333) /* #FA8200 */),
      /* 4  */ RadixColor(0xFF3F2700 /* #3F2700 */, Color.fromRGBO(255, 212, 0  , 0.1961) /* #FC8200 */),
      /* 5  */ RadixColor(0xFF4D3000 /* #4D3000 */, Color.fromRGBO(248, 207, 0  , 0.2549) /* #FD8B00 */),
      /* 6  */ RadixColor(0xFF5C3D05 /* #5C3D05 */, Color.fromRGBO(234, 181, 0  , 0.3176) /* #FD9B00 */),
      /* 7  */ RadixColor(0xFF714F19 /* #714F19 */, Color.fromRGBO(220, 155, 0  , 0.4039) /* #FFAB25 */),
      /* 8  */ RadixColor(0xFF8F6424 /* #8F6424 */, Color.fromRGBO(218, 138, 0  , 0.5294) /* #FFAE35 */),
      /* 9  */ RadixColor(0xFFFFC53D /* #FFC53D */, Color.fromRGBO(255, 179, 0  , 1     ) /* #FFC53D */),
      /* 10 */ RadixColor(0xFFFFD60A /* #FFD60A */, Color.fromRGBO(255, 179, 0  , 1     ) /* #FFD60A */),
      /* 11 */ RadixColor(0xFFFFCA16 /* #FFCA16 */, Color.fromRGBO(171, 100, 0  , 1     ) /* #FFCA16 */),
      /* 12 */ RadixColor(0xFFFFE7B3 /* #FFE7B3 */, Color.fromRGBO(52 , 21 , 0  , 1     ) /* #FFE7B3 */),
    ],
    debugLabel: 'amber (dark)',
    contrast: Color(0xFF21201C), // It's RadixLightColors.sand.scale_12
    surface: Color(0x80271F13),
  );

  static const RadixColorsSwatch sky = RadixColorsSwatch(
    [
      /* 1  */ RadixColor(0xFF0D141F /* #0D141F */, Color.fromRGBO(0  , 68 , 255, 0.0588) /* #0044FF */),
      /* 2  */ RadixColor(0xFF111A27 /* #111A27 */, Color.fromRGBO(17 , 113, 251, 0.0941) /* #1171FB */),
      /* 3  */ RadixColor(0xFF112840 /* #112840 */, Color.fromRGBO(17 , 132, 252, 0.2   ) /* #1184FC */),
      /* 4  */ RadixColor(0xFF113555 /* #113555 */, Color.fromRGBO(18 , 143, 255, 0.2863) /* #128FFF */),
      /* 5  */ RadixColor(0xFF154467 /* #154467 */, Color.fromRGBO(28 , 157, 253, 0.3647) /* #1C9DFD */),
      /* 6  */ RadixColor(0xFF1B537B /* #1B537B */, Color.fromRGBO(40 , 165, 255, 0.4471) /* #28A5FF */),
      /* 7  */ RadixColor(0xFF1F6692 /* #1F6692 */, Color.fromRGBO(43 , 173, 254, 0.5451) /* #2BADFE */),
      /* 8  */ RadixColor(0xFF197CAE /* #197CAE */, Color.fromRGBO(29 , 178, 254, 0.6627) /* #1DB2FE */),
      /* 9  */ RadixColor(0xFF7CE2FE /* #7CE2FE */, Color.fromRGBO(124, 227, 255, 0.9961) /* #7CE3FF */),
      /* 10 */ RadixColor(0xFFA8EEFF /* #A8EEFF */, Color.fromRGBO(168, 238, 255, 1     ) /* #A8EEFF */),
      /* 11 */ RadixColor(0xFF75C7F0 /* #75C7F0 */, Color.fromRGBO(124, 211, 255, 0.9373) /* #7CD3FF */),
      /* 12 */ RadixColor(0xFFC2F3FF /* #C2F3FF */, Color.fromRGBO(194, 243, 255, 1     ) /* #C2F3FF */),
    ],
    debugLabel: 'sky (dark)',
    contrast: Color(0xFF1C2024), // It's RadixLightColors.slate.scale_12
    surface: Color(0x8013233B),
  );
}

/// Defines a swatch of colors based on Radix UI's 12-step scale.
@immutable
final class RadixColorsSwatch {
  /// Creates a Radix accent color swatch with a variety of step scale.
  const RadixColorsSwatch(
    this._swatch, {
    String? debugLabel,
    this.contrast,
    this.surface,
  }) : _debugLabel = debugLabel;

  final String? _debugLabel;

  @protected
  final List<Color> _swatch;

  final Color? contrast;
  final Color? surface;

  /// Used for background.
  Color get scale_1  => _swatch[0];
  RadixColor get radixScale_1  => scale_1 as RadixColor;
  /// Used for background.
  Color get scale_2  => _swatch[1];
  RadixColor get radixScale_2  => scale_2 as RadixColor;

  /// Used for interactive components.
  Color get scale_3  => _swatch[2];
  RadixColor get radixScale_3  => scale_3 as RadixColor;
  /// Used for interactive components.
  Color get scale_4  => _swatch[3];
  RadixColor get radixScale_4  => scale_4 as RadixColor;
  /// Used for interactive components.
  Color get scale_5  => _swatch[4];
  RadixColor get radixScale_5  => scale_5 as RadixColor;

  /// Used for borders and separators.
  Color get scale_6  => _swatch[5];
  RadixColor get radixScale_6  => scale_6 as RadixColor;
  /// Used for borders and separators.
  Color get scale_7  => _swatch[6];
  RadixColor get radixScale_7  => scale_7 as RadixColor;
  /// Used for borders and separators.
  Color get scale_8  => _swatch[7];
  RadixColor get radixScale_8  => scale_8 as RadixColor;

  /// Solid colors
  Color get scale_9  => _swatch[8];
  RadixColor get radixScale_9  => scale_9 as RadixColor;
  /// Solid colors
  Color get scale_10 => _swatch[9];
  RadixColor get radixScale_10 => scale_10 as RadixColor;

  /// Used for accessible text.
  Color get scale_11 => _swatch[10];
  RadixColor get radixScale_11 => scale_11 as RadixColor;
  /// Used for accessible text.
  Color get scale_12 => _swatch[11];
  RadixColor get radixScale_12 => scale_12 as RadixColor;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return super == other &&
           other is RadixColorsSwatch &&
           listEquals<Color>(other._swatch, _swatch) &&
           contrast == other.contrast &&
           surface == other.surface;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _swatch);

  @override
  String toString() => _debugLabel ?? objectRuntimeType(this, 'RadixColorsSwatch');

  /// Linearly interpolate between two [RadixColorsSwatch]es.
  ///
  /// It delegates to [Color.lerp] to interpolate the different colors of the
  /// swatch.
  ///
  /// If either color is null, this function linearly interpolates from a
  /// transparent instance of the other color.
  ///
  /// The `t` argument represents position on the timeline, with 0.0 meaning
  /// that the interpolation has not started, returning `a` (or something
  /// equivalent to `a`), 1.0 meaning that the interpolation has finished,
  /// returning `b` (or something equivalent to `b`), and values in between
  /// meaning that the interpolation is at the relevant point on the timeline
  /// between `a` and `b`. The interpolation can be extrapolated beyond 0.0 and
  /// 1.0, so negative values and values greater than 1.0 are valid (and can
  /// easily be generated by curves such as [Curves.elasticInOut]). Each channel
  /// will be clamped to the range 0 to 255.
  ///
  /// Values for `t` are usually obtained from an [Animation<double>], such as
  /// an [AnimationController].
  static RadixColorsSwatch? lerp(
    RadixColorsSwatch? a,
    RadixColorsSwatch? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }
    final Iterable<Color> swatch;
    if (b == null) {
      swatch = a!._swatch.map(
        (Color color) => Color.lerp(color, null, t)!,
      );
    } else {
      if (a == null) {
        swatch = b._swatch.map(
          (Color color) => Color.lerp(null, color, t)!,
        );
      } else {
        swatch = a._swatch.asMap().entries.map(
          (entry) {
            final int index = entry.key;
            final Color color = entry.value;

            return Color.lerp(color, b._swatch[index], t)!;
          },
        );
      }
    }
    return RadixColorsSwatch(
      swatch.toList(growable: false),
      contrast: Color.lerp(a?.contrast, b?.contrast, t),
      surface: Color.lerp(a?.surface, b?.surface, t),
    );
  }
}

extension RadixColorsSwatchExtension on RadixColorsSwatch {
  Color resolveForHeading() {
    return radixScale_12.alphaVariant;
  }
}

/// Defines a single solid color as well as a transparent (alpha) variant.
///
/// The transparent variant which is designed to appear visually
/// the same when placed over the page background.
final class RadixColor extends Color {
  const RadixColor(super.value, this.alphaVariant);

  final Color alphaVariant;
}

/// Defines a single color as well a alpha color swatch with 12-step scale.
final class RadixOverlayColor extends Color {
  const RadixOverlayColor(
    super.value,
    this.alphaVariantSwatch, {
    this.contrast,
  });

  final RadixColorsSwatch alphaVariantSwatch;
  final Color? contrast;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return super == other && other is RadixOverlayColor &&
          other.alphaVariantSwatch == alphaVariantSwatch &&
          other.contrast == contrast;
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, alphaVariantSwatch, contrast);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'RadixOverlayColor')}(primary value: ${super.toString()})';

  /// Linearly interpolate between two [RadixOverlayColor]es.
  ///
  /// It delegates to [Color.lerp] to interpolate the different colors of the
  /// swatch.
  ///
  /// If either color is null, this function linearly interpolates from a
  /// transparent instance of the other color.
  ///
  /// The `t` argument represents position on the timeline, with 0.0 meaning
  /// that the interpolation has not started, returning `a` (or something
  /// equivalent to `a`), 1.0 meaning that the interpolation has finished,
  /// returning `b` (or something equivalent to `b`), and values in between
  /// meaning that the interpolation is at the relevant point on the timeline
  /// between `a` and `b`. The interpolation can be extrapolated beyond 0.0 and
  /// 1.0, so negative values and values greater than 1.0 are valid (and can
  /// easily be generated by curves such as [Curves.elasticInOut]). Each channel
  /// will be clamped to the range 0 to 255.
  ///
  /// Values for `t` are usually obtained from an [Animation<double>], such as
  /// an [AnimationController].
  static RadixOverlayColor? lerp(
    RadixOverlayColor? a,
    RadixOverlayColor? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }
    final RadixColorsSwatch swatch = RadixColorsSwatch.lerp(a?.alphaVariantSwatch, b?.alphaVariantSwatch, t)!;
    return RadixOverlayColor(Color.lerp(a, b, t)!.value, swatch);
  }
}

class RadixDynamicColorsSwatch {
  const RadixDynamicColorsSwatch({
    String? debugLabel,
    required this.light,
    required this.dark,
  }) : _debugLabel = debugLabel;

  final String? _debugLabel;

  final RadixColorsSwatch light;
  final RadixColorsSwatch dark;

  @override
  String toString() => _debugLabel ?? objectRuntimeType(this, 'RadixDynamicColorsSwatch');
}
