import 'package:flutter/material.dart';

import 'colors.dart';
import 'radius.dart';
import 'space.dart';
import 'theme.dart';
import 'theme_data.dart';

/// A placeholder that indicates a loading state.
///
/// If [height] or [width] are not provided, the widget's width will be
/// [double.infinity] and its height will be determined by
/// the Radix spacing scale 3.
///
/// If [borderRadius] is not provided, the corners of this placeholder
/// are rounded using the Radix radius scale 1.
///
/// The skeleton visually pulsates by transitioning its color back and forth
/// between two colors (analogous to `var(--gray-a3)` and `var(--gray-a4)`
/// in the web version) to clearly indicate that content is currently loading.
class RadixSkeleton extends StatefulWidget {
  /// Creates a skeleton to replace content with a placeholder shape 
  /// that indicates a loading state.
  ///
  /// The [borderRadius] argument must be null if [shape] is [BoxShape.circle].
  const RadixSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  /// If non-null, requires the child to have exactly this width.
  ///
  /// Default to [double.infinity].
  final double? width;

  /// If non-null, requires the child to have exactly this height.
  ///
  /// Default to [RadixSpace.scale_3].
  final double? height;

  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  ///
  /// Applies only to boxes with rectangular shapes; ignored if [shape] is not
  /// [BoxShape.rectangle].
  ///
  /// Default to [RadixRadiusFactor.medium.swatch.scale_1].
  final BorderRadiusGeometry? borderRadius;

  /// The shape to fill the background color.
  ///
  /// If this is [BoxShape.circle] then the default border radius is ignored.
  final BoxShape shape;

  @override
  State<RadixSkeleton> createState() => _RadixSkeletonState();
}

class _RadixSkeletonState extends State<RadixSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late ColorTween colorTween;

  late RadixRadiusFactor radiusFactor;
  late RadixSpace space;

  double width = double.infinity;
  double height = RadixSpace.kDefault.scale_3;
  BoxShape shape = BoxShape.rectangle;
  BorderRadiusGeometry? borderRadius;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      value: 1.0,
      vsync: this,
    );

    controller.addListener(_handleChange);

    controller.repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final RadixColorScheme colorScheme;

    final RadixThemeData? radixThemeData = RadixTheme.maybeOf(context);
    if (radixThemeData != null) {
      colorScheme = radixThemeData.colorScheme;
      radiusFactor = radixThemeData.radius;
      space = radixThemeData.space;
    } else {
      final ThemeData theme = Theme.of(context);
      colorScheme = RadixColorScheme.extensionFrom(theme);
      radiusFactor = RadixRadiusFactor.extensionFrom(theme);
      space = RadixSpace.extensionFrom(theme);
    }

    _update();

    colorTween = ColorTween(
      begin: colorScheme.gray.radixScale_3.alphaVariant,
      end: colorScheme.gray.radixScale_4.alphaVariant,
    );
  }

  @override
  void didUpdateWidget(covariant RadixSkeleton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _update();
  }

  void _update() {
    width = widget.width ?? double.infinity;
    height = widget.height ?? space.scale_3;

    shape = widget.shape;

    if (shape != BoxShape.rectangle) {
      borderRadius = null;
    } else {
      borderRadius = widget.borderRadius ?? BorderRadius.all(
        radiusFactor.medium.swatch.scale_1,
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(_handleChange);
    controller.dispose();
    super.dispose();
  }

  void _handleChange() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorTween.evaluate(controller),
        borderRadius: borderRadius,
        shape: shape,
      ),
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}

/// A placeholder that indicates a loading state.
///
/// If [height] or [width] are not provided, the widget's width will be
/// [double.infinity] and its height will be determined by
/// the Radix spacing scale 3.
///
/// If [borderRadius] is not provided, the corners of this placeholder
/// are rounded using the Radix radius scale 1.
///
/// The skeleton visually pulsates by transitioning its color back and forth
/// between two colors (analogous to `Neutral/Neutral Alpha/3` and
/// `Neutral/Neutral Alpha/4)` in the Figma version)
/// to clearly indicate that content is currently loading.
class RadixFigmaSkeleton extends StatefulWidget {
  /// Creates a skeleton to replace content with a placeholder shape 
  /// that indicates a loading state.
  ///
  /// The [borderRadius] argument must be null if [shape] is [BoxShape.circle].
  const RadixFigmaSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  /// If non-null, requires the child to have exactly this width.
  ///
  /// Default to [double.infinity].
  final double? width;

  /// If non-null, requires the child to have exactly this height.
  ///
  /// Default to [RadixSpace.scale_3].
  final double? height;

  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  ///
  /// Applies only to boxes with rectangular shapes; ignored if [shape] is not
  /// [BoxShape.rectangle].
  ///
  /// Default to [RadixRadiusFactor.medium.swatch.scale_1].
  final BorderRadiusGeometry? borderRadius;

  /// The shape to fill the background color.
  ///
  /// If this is [BoxShape.circle] then the default border radius is ignored.
  final BoxShape shape;

  @override
  State<RadixFigmaSkeleton> createState() => _RadixFigmaSkeletonState();
}

class _RadixFigmaSkeletonState extends State<RadixFigmaSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation animation;
  late ColorTween colorTween;

  late RadixRadiusFactor radiusFactor;
  late RadixSpace space;

  double width = double.infinity;
  double height = RadixSpace.kDefault.scale_3;
  BoxShape shape = BoxShape.rectangle;
  BorderRadiusGeometry? borderRadius;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      value: 1.0,
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    controller.addListener(_handleChange);

    controller.repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final RadixColorScheme colorScheme;

    final RadixThemeData? radixThemeData = RadixTheme.maybeOf(context);
    if (radixThemeData != null) {
      colorScheme = radixThemeData.colorScheme;
      radiusFactor = radixThemeData.radius;
      space = radixThemeData.space;
    } else {
      final ThemeData theme = Theme.of(context);
      colorScheme = RadixColorScheme.extensionFrom(theme);
      radiusFactor = RadixRadiusFactor.extensionFrom(theme);
      space = RadixSpace.extensionFrom(theme);
    }

    _update();

    colorTween = ColorTween(
      begin: colorScheme.neutral.radixScale_3.alphaVariant,
      end: colorScheme.neutral.radixScale_4.alphaVariant,
    );
  }

  @override
  void didUpdateWidget(covariant RadixFigmaSkeleton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _update();
  }

  void _update() {
    width = widget.width ?? double.infinity;
    height = widget.height ?? space.scale_3;

    shape = widget.shape;

    if (shape != BoxShape.rectangle) {
      borderRadius = null;
    } else {
      borderRadius = widget.borderRadius ?? BorderRadius.all(
        radiusFactor.medium.swatch.scale_1,
      );
    }
  }

  @override
  void dispose() {
    animation.dispose();
    controller.removeListener(_handleChange);
    controller.dispose();
    super.dispose();
  }

  void _handleChange() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorTween.evaluate(animation),
        borderRadius: borderRadius,
        shape: shape,
      ),
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}
