import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'colors.dart';
import 'radius.dart';
import 'space.dart';
import 'theme.dart';
import 'theme_data.dart';

class RadixSpinnerThemeData {
  const RadixSpinnerThemeData({
    required this.s1,
    required this.s2,
    required this.s3,
    required this.color,
    required this.figmaVersionColor,
  });

  final Size s1;
  final Size s2;
  final Size s3;

  /// Color of the spinner.
  final Color color;

  final RadixColorsSwatch figmaVersionColor;

  static final RadixSpinnerThemeData kLight = RadixSpinnerThemeData(
    s1: Size.square(RadixSpace.kDefault.scale_3),
    s2: Size.square(RadixSpace.kDefault.scale_4),
    s3: Size.square(1.25 * RadixSpace.kDefault.scale_4),
    // The web's spinner color is set to `currentColor`, which is the current
    // text color, typically '--gray-12' in the Light Theme.
    color: RadixColorScheme.kLight.gray.scale_12.withOpacity(0.65),
    // Corresponds to the Figma color Neutral Alpha.
    figmaVersionColor: RadixColorScheme.kLight.neutral,
  );

  static final RadixSpinnerThemeData kDark = RadixSpinnerThemeData(
    s1: Size.square(RadixSpace.kDefault.scale_3),
    s2: Size.square(RadixSpace.kDefault.scale_4),
    s3: Size.square(1.25 * RadixSpace.kDefault.scale_4),
    // The web's spinner color is set to `currentColor`, which is the current
    // text color, typically '--gray-12' in the Dark Theme.
    color: RadixColorScheme.kDark.gray.scale_12.withOpacity(0.65),
    // Corresponds to the Figma color Neutral Alpha.
    figmaVersionColor: RadixColorScheme.kDark.neutral,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return super == other &&
           other is RadixSpinnerThemeData &&
           other.s1 == s1 &&
           other.s2 == s2 &&
           other.s3 == s3 &&
           other.color == color &&
           other.figmaVersionColor == figmaVersionColor;
  }

  @override
  int get hashCode => Object.hash(runtimeType, s1, s2, s3, color);

  /// Linearly interpolate between two [RadixSpinnerThemeData]s.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixSpinnerThemeData lerp(RadixSpinnerThemeData? a, RadixSpinnerThemeData? b, double t) {
    if (identical(a, b) && a != null) {
      return a;
    }
    return RadixSpinnerThemeData(
      s1: Size.lerp(a?.s1, b?.s1, t)!,
      s2: Size.lerp(a?.s2, b?.s2, t)!,
      s3: Size.lerp(a?.s3, b?.s3, t)!,
      color: Color.lerp(a?.color, b?.color, t)!,
      figmaVersionColor: RadixColorsSwatch.lerp(a?.figmaVersionColor, b?.figmaVersionColor, t)!,
    );
  }

  /// The [RadixThemeData.spinnerTheme] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).spinnerTheme`.
  static RadixSpinnerThemeData of(BuildContext context) => RadixTheme.of(context).spinnerTheme;

  /// The [RadixThemeExtension.spinnerTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).spinnerTheme`.
  static RadixSpinnerThemeData fromTheme(BuildContext context) => RadixTheme.fromTheme(context).spinnerTheme;

  /// The [RadixThemeExtension.spinnerTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).spinnerTheme`.
  static RadixSpinnerThemeData extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).spinnerTheme;
}

enum RadixSpinnerSize {
  $1, $2, $3
}

extension on RadixSpinnerSize {
  Size getSize(RadixSpinnerThemeData theme) {
    switch (this) {
      case RadixSpinnerSize.$1:
        return theme.s1;
      case RadixSpinnerSize.$2:
        return theme.s2;
      case RadixSpinnerSize.$3:
        return theme.s3;
    }
  }
}

/// A Radix-style activity indicator similar to the iOS (Cupertino) design.
///
/// The visual style and opacity values of this spinner are derived by 
/// reconciling the Figma design, which corresponds to the Neutral Alpha color.
class RadixSpinner extends StatefulWidget {
  /// Creates an Radix-style activity indicator that spins clockwise.
  const RadixSpinner({
    super.key,
    this.color,
    this.animating = true,
    this.size = RadixSpinnerSize.$2,
    this.leafRadius,
  }) : progress = 1.0;

  /// Creates a non-animated Radix-style activity indicator that displays
  /// a partial count of ticks (spinner leaves) based on the value of [progress].
  ///
  /// When provided, the value of [progress] must be between 0.0 (zero ticks
  /// will be shown) and 1.0 (all ticks will be shown) inclusive. Defaults
  /// to 1.0.
  const RadixSpinner.partiallyRevealed({
    super.key,
    this.color,
    this.size = RadixSpinnerSize.$2,
    this.progress = 1.0,
    this.leafRadius,
  }) : assert(progress >= 0.0),
       assert(progress <= 1.0),
       animating = false;

  /// Color of the spinner.
  final Color? color;

  /// Whether the spinner is running its animation.
  ///
  /// Defaults to true.
  final bool animating;

  /// Defaults to [RadixSpinnerSize.$2].
  final RadixSpinnerSize size;

  /// Defaults to [RadixRadiusFactor.medium.swatch.scale_1].
  final Radius? leafRadius;

  /// Determines the percentage of spinner leaves that will be shown.
  /// Typical usage would display all leaves, however, this allows
  /// for more fine-grained control such as during pull-to-refresh
  /// when the drag-down action shows one leaf at a time as
  /// the user continues to drag down.
  ///
  /// Defaults to one. Must be between zero and one, inclusive.
  final double progress;

  @override
  State<RadixSpinner> createState() => _RadixSpinnerState();
}

class _RadixSpinnerState extends State<RadixSpinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    if (widget.animating) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(RadixSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RadixSpinnerThemeData spinnerTheme;
    final RadixRadiusFactor radiusFactor;

    final RadixThemeData? radixThemeData = RadixTheme.maybeOf(context);
    if (radixThemeData != null) {
      spinnerTheme = radixThemeData.spinnerTheme;
      radiusFactor = radixThemeData.radius;
    } else {
      final ThemeData theme = Theme.of(context);
      spinnerTheme = RadixSpinnerThemeData.extensionFrom(theme);
      radiusFactor = RadixRadiusFactor.extensionFrom(theme);
    }

    final Size size = widget.size.getSize(spinnerTheme);

    return CustomPaint(
      size: size,
      painter: _RadixSpinnerPainter(
        position: _controller,
        activeColor: widget.color ?? spinnerTheme.color,
        height: size.height,
        leafRadius: widget.leafRadius ?? radiusFactor.medium.swatch.scale_1,
        leafWidth: size.width * 0.125,
        leafHeight: size.height * 0.3,
        progress: widget.progress,
      ),
    );
  }
}

const double _kTwoPI = math.pi * 2.0; // a full circle (or 360deg).

/// The opacity values used to draw the spinning ticks.
///
/// These values were calculated by blending the foreground color `#1c2024`
/// over a white background (using the color blending formula
/// $R = \alpha F + (1 - \alpha) B$, calculated with assistance from Gemini).
/// This process replicates the visual effect defined in the web design specifications.
///
/// See also:
///
///  * <https://www.radix-ui.com/themes/docs/components/spinner>
const List<int> _kAlphaValues = <int>[64, 73, 88, 103, 119, 135, 150, 166];

/// The alpha value that is used to draw the partially revealed ticks.
const int _partiallyRevealedAlpha = 166;

class _RadixSpinnerPainter extends CustomPainter {
  _RadixSpinnerPainter({
    required this.position,
    required this.activeColor,
    required double height,
    required Radius leafRadius,
    required double leafHeight,
    required double leafWidth,
    required this.progress,
  }) : tickFundamentalShape = RRect.fromLTRBXY(
         -leafWidth / 2.0,
         (height / 2.0) - leafHeight,
         leafWidth / 2.0,
         (height / 2.0),
         leafRadius.x,
         leafRadius.y,
       ),
       super(repaint: position);

  final Animation<double> position;
  final Color activeColor;
  final double progress;

  // Use a RRect instead of RSuperellipse since this shape is really small
  // and should make little visual difference.
  final RRect tickFundamentalShape;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    final int tickCount = _kAlphaValues.length;

    canvas.save();
    canvas.translate(size.width / 2.0, size.height / 2.0);

    final int activeTick = (tickCount * position.value).floor();

    for (int i = 0; i < tickCount * progress; ++i) {
      final int t = (i - activeTick) % tickCount;
      paint.color = activeColor.withAlpha(
        progress < 1 ? _partiallyRevealedAlpha : _kAlphaValues[t],
      );
      canvas.drawRRect(tickFundamentalShape, paint);
      canvas.rotate(_kTwoPI / tickCount); // rotate 45deg
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_RadixSpinnerPainter oldPainter) {
    return oldPainter.position != position ||
        oldPainter.activeColor != activeColor ||
        oldPainter.progress != progress;
  }
}

/// A Radix-style activity indicator similar to the iOS (Cupertino) design.
///
/// The visual style and opacity values of this spinner are calculated to match 
/// the visual blending of the web specifications over a white background.
class RadixFigmaSpinner extends StatefulWidget {
  /// Creates an Radix-style activity indicator that spins clockwise.
  const RadixFigmaSpinner({
    super.key,
    this.color,
    this.animating = true,
    this.size = RadixSpinnerSize.$2,
    this.leafRadius,
  }) : progress = 1.0;

  /// Creates a non-animated Radix-style activity indicator that displays
  /// a partial count of ticks (spinner leaves) based on the value of [progress].
  ///
  /// When provided, the value of [progress] must be between 0.0 (zero ticks
  /// will be shown) and 1.0 (all ticks will be shown) inclusive. Defaults
  /// to 1.0.
  const RadixFigmaSpinner.partiallyRevealed({
    super.key,
    this.color,
    this.size = RadixSpinnerSize.$2,
    this.progress = 1.0,
    this.leafRadius,
  }) : assert(progress >= 0.0),
       assert(progress <= 1.0),
       animating = false;

  /// Color of the spinner.
  final RadixColorsSwatch? color;

  /// Whether the spinner is running its animation.
  ///
  /// Defaults to true.
  final bool animating;

  /// Defaults to [RadixSpinnerSize.$2].
  final RadixSpinnerSize size;

  /// Defaults to [RadixRadiusFactor.medium.swatch.scale_1].
  final Radius? leafRadius;

  /// Determines the percentage of spinner leaves that will be shown.
  /// Typical usage would display all leaves, however, this allows
  /// for more fine-grained control such as during pull-to-refresh
  /// when the drag-down action shows one leaf at a time as
  /// the user continues to drag down.
  ///
  /// Defaults to one. Must be between zero and one, inclusive.
  final double progress;

  @override
  State<RadixFigmaSpinner> createState() => _RadixFigmaSpinnerState();
}

class _RadixFigmaSpinnerState extends State<RadixFigmaSpinner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    if (widget.animating) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(RadixFigmaSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RadixSpinnerThemeData spinnerTheme;

    final RadixColorScheme colorScheme;
    final RadixRadiusFactor radiusFactor;

    final RadixThemeData? radixThemeData = RadixTheme.maybeOf(context);
    if (radixThemeData != null) {
      spinnerTheme = radixThemeData.spinnerTheme;
      colorScheme = radixThemeData.colorScheme;
      radiusFactor = radixThemeData.radius;
    } else {
      final ThemeData theme = Theme.of(context);
      spinnerTheme = RadixSpinnerThemeData.extensionFrom(theme);
      colorScheme = RadixColorScheme.extensionFrom(theme);
      radiusFactor = RadixRadiusFactor.extensionFrom(theme);
    }

    final Size size = widget.size.getSize(spinnerTheme);
    final RadixColorsSwatch color = widget.color ?? colorScheme.neutral;

    return CustomPaint(
      size: size,
      painter: _RadixFigmaSpinnerPainter(
        position: _controller,
        colors: [
          color.scale_4,
          color.scale_5,
          color.scale_6,
          color.scale_7,
          color.scale_8,
          color.scale_9,
          color.scale_10,
          color.scale_11,
        ],
        partiallyRevealedColor: color.scale_11,
        height: size.height,
        leafRadius: widget.leafRadius ?? radiusFactor.medium.swatch.scale_1,
        leafWidth: size.width * 0.125,
        leafHeight: size.height * 0.3,
        progress: widget.progress,
      ),
    );
  }
}

class _RadixFigmaSpinnerPainter extends CustomPainter {
  _RadixFigmaSpinnerPainter({
    required this.position,
    required this.colors,
    required this.partiallyRevealedColor,
    required double height,
    required Radius leafRadius,
    required double leafHeight,
    required double leafWidth,
    required this.progress,
  }) : tickFundamentalShape = RRect.fromLTRBXY(
         -leafWidth / 2.0,
         (height / 2.0) - leafHeight,
         leafWidth / 2.0,
         (height / 2.0),
         leafRadius.x,
         leafRadius.y,
       ),
       super(repaint: position);

  final Animation<double> position;
  final List<Color> colors;
  final Color partiallyRevealedColor;

  final double progress;

  // Use a RRect instead of RSuperellipse since this shape is really small
  // and should make little visual difference.
  final RRect tickFundamentalShape;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    final int tickCount = _kAlphaValues.length;

    canvas.save();
    canvas.translate(size.width / 2.0, size.height / 2.0);

    final int activeTick = (tickCount * position.value).floor();

    for (int i = 0; i < tickCount * progress; ++i) {
      final int t = (i - activeTick) % tickCount;
      paint.color = progress < 1 ? partiallyRevealedColor : colors[t];
      canvas.drawRRect(tickFundamentalShape, paint);
      canvas.rotate(_kTwoPI / tickCount); // rotate 45deg
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_RadixFigmaSpinnerPainter oldPainter) {
    return oldPainter.position != position ||
        oldPainter.colors != colors ||
        oldPainter.partiallyRevealedColor != partiallyRevealedColor ||
        oldPainter.progress != progress;
  }
}
