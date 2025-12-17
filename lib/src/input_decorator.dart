import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:radix_themes/src/button.dart';

import 'colors.dart';
import 'radius.dart';
import 'space.dart';
import 'state.dart';
import 'text_theme.dart';
import 'theme.dart';
import 'theme_data.dart';

// The duration value extracted from:
// https://github.com/material-components/material-components-android/blob/master/lib/java/com/google/android/material/textfield/TextInputLayout.java
const Curve _kTransitionCurve = Curves.fastOutSlowIn;

typedef _SubtextSize = ({double ascent, double bottomHeight, double subtextHeight});
typedef _ChildBaselineGetter = double Function(RenderBox child, BoxConstraints constraints);

// The default duration for hint fade in/out transitions.
//
// Animating hint is not mentioned in the Radix specification.
// The animation is kept for backward compatibility and a short duration
// is used to mitigate the UX impact.
const Duration _kHintFadeTransitionDuration = Duration(milliseconds: 20);

// Defines the gap in the InputDecorator's outline border where the
// floating label will appear.
class _InputBorderGap extends ChangeNotifier {
  double? _start;
  double? get start => _start;
  set start(double? value) {
    if (value != _start) {
      _start = value;
      notifyListeners();
    }
  }

  double _extent = 0.0;
  double get extent => _extent;
  set extent(double value) {
    if (value != _extent) {
      _extent = value;
      notifyListeners();
    }
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes, this class is not used in collection
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _InputBorderGap && other.start == start && other.extent == extent;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes, this class is not used in collection
  int get hashCode => Object.hash(start, extent);

  @override
  String toString() => describeIdentity(this);
}

// Passes the _InputBorderGap parameters along to an InputBorder's paint method.
class _InputBorderPainter extends CustomPainter {
  _InputBorderPainter({
    required this.border,
    required this.gap,
    required this.textDirection,
    required this.fillColor,
  });

  final InputBorder border;
  final _InputBorderGap gap;
  final TextDirection textDirection;
  final Color? fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect canvasRect = Offset.zero & size;
    final Color? fillColor = this.fillColor;
    if (fillColor != null && fillColor.alpha > 0) {
      canvas.drawPath(
        border.getOuterPath(canvasRect, textDirection: textDirection),
        Paint()
          ..color = fillColor
          ..style = PaintingStyle.fill,
      );
    }

    border.paint(
      canvas,
      canvasRect,
      gapStart: gap.start,
      gapExtent: gap.extent,
      textDirection: textDirection,
    );
  }

  @override
  bool shouldRepaint(_InputBorderPainter oldPainter) {
    return border != oldPainter.border ||
        gap != oldPainter.gap ||
        textDirection != oldPainter.textDirection;
  }

  @override
  String toString() => describeIdentity(this);
}

// Display the helper and error text.
class _HelperError extends StatelessWidget {
  const _HelperError({
    this.textAlign,
    this.helper,
    this.helperText,
    this.helperStyle,
    this.helperMaxLines,
    this.error,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
  });

  final TextAlign? textAlign;
  final Widget? helper;
  final String? helperText;
  final TextStyle? helperStyle;
  final int? helperMaxLines;
  final Widget? error;
  final String? errorText;
  final TextStyle? errorStyle;
  final int? errorMaxLines;

  @override
  Widget build(BuildContext context) {
    // If the height of this widget and the counter are zero ("empty") at
    // layout time, no space is allocated for the subtext.
    const Widget empty = SizedBox.shrink();

    final bool hasHelper = helperText != null || helper != null;
    final bool hasError = errorText != null || error != null;

    if (hasError) {
      assert(error != null || errorText != null);
      final Widget? capturedError = error;
      final String? capturedErrorText = errorText;
      return Builder(
        builder: (BuildContext context) {
          return Semantics(
            container: true,
            liveRegion: !MediaQuery.supportsAnnounceOf(context),
            child: capturedError ??
                Text(
                  capturedErrorText!,
                  style: errorStyle,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  maxLines: errorMaxLines,
                ),
          );
        },
      );
    }

    if (hasHelper) {
      assert(helper != null || helperText != null);
      return Semantics(
        container: true,
        child: helper ??
            Text(
              helperText!,
              style: helperStyle,
              textAlign: textAlign,
              overflow: TextOverflow.ellipsis,
              maxLines: helperMaxLines,
            ),
      );
    }

    return empty;
  }
}

// Identifies the children of a _RenderDecorationElement.
enum _DecorationSlot {
  icon,
  input,
  hint,
  prefix,
  suffix,
  prefixIcon,
  suffixIcon,
  helperError,
  counter,
  container,
}

// An analog of InputDecoration for the _Decorator widget.
@immutable
class _Decoration {
  const _Decoration({
    this.contentHeight,
    required this.contentPadding,
    this.border,
    required this.borderGap,
    required this.isEmpty,
    required this.inputGap,
    required this.maintainHintSize,
    this.icon,
    this.input,
    this.hint,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixToInputGap,
    this.inputToSuffixGap,
    this.helperError,
    this.counter,
    this.subtextGap,
    this.container,
  });

  final double? contentHeight;
  final EdgeInsetsDirectional contentPadding;
  final InputBorder? border;
  final _InputBorderGap borderGap;
  final bool isEmpty;
  final double inputGap;
  final bool maintainHintSize;
  final Widget? icon;
  final Widget? input;
  final Widget? hint;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? prefixToInputGap;
  final double? inputToSuffixGap;
  final Widget? helperError;
  final Widget? counter;
  final double? subtextGap;
  final Widget? container;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _Decoration &&
        other.contentPadding == contentPadding &&
        other.border == border &&
        other.borderGap == borderGap &&
        other.isEmpty == isEmpty &&
        other.inputGap == inputGap &&
        other.maintainHintSize == maintainHintSize &&
        other.icon == icon &&
        other.input == input &&
        other.hint == hint &&
        other.prefix == prefix &&
        other.suffix == suffix &&
        other.prefixIcon == prefixIcon &&
        other.suffixIcon == suffixIcon &&
        other.prefixToInputGap == prefixToInputGap &&
        other.inputToSuffixGap == inputToSuffixGap &&
        other.helperError == helperError &&
        other.counter == counter &&
        other.subtextGap == subtextGap &&
        other.container == container;
  }

  @override
  int get hashCode => Object.hash(
    contentPadding,
    border,
    borderGap,
    isEmpty,
    inputGap,
    maintainHintSize,
    icon,
    input,
    hint,
    prefix,
    suffix,
    prefixIcon,
    suffixIcon,
    prefixToInputGap,
    inputToSuffixGap,
    helperError,
    counter,
    subtextGap,
    container,
  );
}

// A container for the layout values computed by _RenderDecoration._layout.
// These values are used by _RenderDecoration.performLayout to position
// all of the renderer children of a _RenderDecoration.
class _RenderDecorationLayout {
  const _RenderDecorationLayout({
    required this.inputConstraints,
    required this.baseline,
    required this.containerHeight,
    required this.subtextSize,
    required this.size,
  });

  final BoxConstraints inputConstraints;
  final double baseline;
  final double containerHeight;
  final _SubtextSize? subtextSize;
  final Size size;
}

// The workhorse: layout and paint a _Decorator widget's _Decoration.
class _RenderDecoration extends RenderBox
    with SlottedContainerRenderObjectMixin<_DecorationSlot, RenderBox> {
  _RenderDecoration({
    required _Decoration decoration,
    required TextDirection textDirection,
    required bool isFocused,
    required bool expands,
    TextAlignVertical? textAlignVertical,
  }) : _decoration = decoration,
       _textDirection = textDirection,
       _textAlignVertical = textAlignVertical,
       _isFocused = isFocused,
       _expands = expands;

  RenderBox? get icon => childForSlot(_DecorationSlot.icon);
  RenderBox? get input => childForSlot(_DecorationSlot.input);
  RenderBox? get hint => childForSlot(_DecorationSlot.hint);
  RenderBox? get prefix => childForSlot(_DecorationSlot.prefix);
  RenderBox? get suffix => childForSlot(_DecorationSlot.suffix);
  RenderBox? get prefixIcon => childForSlot(_DecorationSlot.prefixIcon);
  RenderBox? get suffixIcon => childForSlot(_DecorationSlot.suffixIcon);
  RenderBox get helperError => childForSlot(_DecorationSlot.helperError)!;
  RenderBox? get counter => childForSlot(_DecorationSlot.counter);
  RenderBox? get container => childForSlot(_DecorationSlot.container);

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    final RenderBox? helperError = childForSlot(_DecorationSlot.helperError);
    return <RenderBox>[
      if (icon != null) icon!,
      if (input != null) input!,
      if (prefixIcon != null) prefixIcon!,
      if (suffixIcon != null) suffixIcon!,
      if (prefix != null) prefix!,
      if (suffix != null) suffix!,
      if (hint != null) hint!,
      if (helperError != null) helperError,
      if (counter != null) counter!,
      if (container != null) container!,
    ];
  }

  _Decoration get decoration => _decoration;
  _Decoration _decoration;
  set decoration(_Decoration value) {
    if (_decoration == value) {
      return;
    }
    _decoration = value;
    markNeedsLayout();
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    markNeedsLayout();
  }

  static const TextAlignVertical _defaultTextAlignVertical = TextAlignVertical.center;
  TextAlignVertical get textAlignVertical => _textAlignVertical ?? _defaultTextAlignVertical;
  TextAlignVertical? _textAlignVertical;
  set textAlignVertical(TextAlignVertical? value) {
    if (_textAlignVertical == value) {
      return;
    }
    // No need to relayout if the effective value is still the same.
    if (textAlignVertical.y == (value?.y ?? _defaultTextAlignVertical.y)) {
      _textAlignVertical = value;
      return;
    }
    _textAlignVertical = value;
    markNeedsLayout();
  }

  bool get isFocused => _isFocused;
  bool _isFocused;
  set isFocused(bool value) {
    if (_isFocused == value) {
      return;
    }
    _isFocused = value;
    markNeedsSemanticsUpdate();
  }

  bool get expands => _expands;
  bool _expands = false;
  set expands(bool value) {
    if (_expands == value) {
      return;
    }
    _expands = value;
    markNeedsLayout();
  }

  // Indicates that the decoration should be aligned to accommodate an outline
  // border.
  bool get _isOutlineAligned {
    return decoration.border?.isOutline ?? false;
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (icon != null) {
      visitor(icon!);
    }
    if (prefix != null) {
      visitor(prefix!);
    }
    if (prefixIcon != null) {
      visitor(prefixIcon!);
    }

    if (hint != null) {
      if (isFocused) {
        visitor(hint!);
      }
    }

    if (input != null) {
      visitor(input!);
    }
    if (suffixIcon != null) {
      visitor(suffixIcon!);
    }
    if (suffix != null) {
      visitor(suffix!);
    }
    if (container != null) {
      visitor(container!);
    }
    visitor(helperError);
    if (counter != null) {
      visitor(counter!);
    }
  }

  static double _minWidth(RenderBox? box, double height) =>
      box?.getMinIntrinsicWidth(height) ?? 0.0;
  static double _maxWidth(RenderBox? box, double height) =>
      box?.getMaxIntrinsicWidth(height) ?? 0.0;
  static double _minHeight(RenderBox? box, double width) =>
      box?.getMinIntrinsicHeight(width) ?? 0.0;
  static Size _boxSize(RenderBox? box) => box?.size ?? Size.zero;
  static double _getBaseline(RenderBox box, BoxConstraints boxConstraints) {
    return ChildLayoutHelper.getBaseline(box, boxConstraints, TextBaseline.alphabetic) ??
        box.size.height;
  }

  static double _getDryBaseline(RenderBox box, BoxConstraints boxConstraints) {
    return ChildLayoutHelper.getDryBaseline(box, boxConstraints, TextBaseline.alphabetic) ??
        ChildLayoutHelper.dryLayoutChild(box, boxConstraints).height;
  }

  static BoxParentData _boxParentData(RenderBox box) => box.parentData! as BoxParentData;

  EdgeInsetsDirectional get contentPadding => decoration.contentPadding;

  double get subtextGap => decoration.subtextGap ?? 0.0;
  double get prefixToInputGap => decoration.prefixToInputGap ?? 0.0;
  double get inputToSuffixGap => decoration.inputToSuffixGap ?? 0.0;

  _SubtextSize? _computeSubtextSizes({
    required BoxConstraints constraints,
    required ChildLayouter layoutChild,
    required _ChildBaselineGetter getBaseline,
  }) {
    final (Size counterSize, double counterAscent) = switch (counter) {
      final RenderBox box => (layoutChild(box, constraints), getBaseline(box, constraints)),
      null => (Size.zero, 0.0),
    };

    final BoxConstraints helperErrorConstraints = constraints.deflate(
      EdgeInsets.only(left: counterSize.width),
    );
    final double helperErrorHeight = layoutChild(helperError, helperErrorConstraints).height;

    if (helperErrorHeight == 0.0 && counterSize.height == 0.0) {
      return null;
    }

    // TODO(LongCatIsLooong): the bottomHeight expression doesn't make much sense.
    // Use the real descent and make sure the subtext line box is tall enough for both children.
    // See https://github.com/flutter/flutter/issues/13715
    final double ascent =
        math.max(counterAscent, getBaseline(helperError, helperErrorConstraints)) + subtextGap;
    final double bottomHeight = math.max(counterAscent, helperErrorHeight) + subtextGap;
    final double subtextHeight = math.max(counterSize.height, helperErrorHeight) + subtextGap;
    return (ascent: ascent, bottomHeight: bottomHeight, subtextHeight: subtextHeight);
  }

  // Returns a value used by performLayout to position all of the renderers.
  // This method applies layout to all of the renderers except the container.
  // For convenience, the container is laid out in performLayout().
  _RenderDecorationLayout _layout(
    BoxConstraints constraints, {
    required ChildLayouter layoutChild,
    required _ChildBaselineGetter getBaseline,
  }) {
    assert(
      constraints.maxWidth < double.infinity,
      'An RadixInputDecorator, which is typically created by a RadixTextField, '
      'cannot have an unbounded width.\n'
      'This happens when the parent widget does not provide a finite width '
      'constraint. For example, if the RadixInputDecorator is contained by a Row, '
      'then its width must be constrained. An Expanded widget or a SizedBox '
      'can be used to constrain the width of the RadixInputDecorator or the '
      'RadixTextField that contains it.',
    );

    final BoxConstraints boxConstraints = constraints.loosen();

    // Layout all the widgets used by InputDecorator
    final RenderBox? icon = this.icon;
    final double iconWidth = icon == null ? 0.0 : layoutChild(icon, boxConstraints).width;
    BoxConstraints containerConstraints = boxConstraints.deflate(
      EdgeInsets.only(left: iconWidth),
    );
    BoxConstraints contentConstraints = containerConstraints.deflate(
      EdgeInsets.only(left: contentPadding.horizontal),
    );

    // TODO: allow subtext not align with contentPadding horizontal
    // The helper or error text can occupy the full width less the space
    // occupied by the icon and counter.
    final _SubtextSize? subtextSize = _computeSubtextSizes(
      constraints: contentConstraints,
      layoutChild: layoutChild,
      getBaseline: getBaseline,
    );

    containerConstraints = containerConstraints.tighten(height: decoration.contentHeight);
    contentConstraints = contentConstraints.tighten(height: decoration.contentHeight);

    final RenderBox? prefixIcon = this.prefixIcon;
    final RenderBox? suffixIcon = this.suffixIcon;
    final Size prefixIconSize = prefixIcon == null
        ? Size.zero
        : layoutChild(prefixIcon, containerConstraints);
    final Size suffixIconSize = suffixIcon == null
        ? Size.zero
        : layoutChild(suffixIcon, containerConstraints);
    final RenderBox? prefix = this.prefix;
    final RenderBox? suffix = this.suffix;
    final Size prefixSize = prefix == null ? Size.zero : layoutChild(prefix, contentConstraints);
    final Size suffixSize = suffix == null ? Size.zero : layoutChild(suffix, contentConstraints);

    final EdgeInsetsDirectional accessoryHorizontalInsets = EdgeInsetsDirectional.only(
      start:
          iconWidth +
          prefixSize.width +
          (prefixIcon == null
              ? contentPadding.start + decoration.inputGap
              : prefixIconSize.width + prefixToInputGap),
      end:
          suffixSize.width +
          (suffixIcon == null
              ? contentPadding.end + decoration.inputGap
              : suffixIconSize.width + inputToSuffixGap),
    );

    final double inputWidth = math.max(
      0.0,
      constraints.maxWidth - accessoryHorizontalInsets.horizontal,
    );

    // The height of the input needs to accommodate label above and counter and
    // helperError below, when they exist.
    final double bottomHeight = subtextSize?.bottomHeight ?? 0.0;
    final BoxConstraints inputConstraints = boxConstraints
        .deflate(
          EdgeInsets.only(
            top: contentPadding.vertical + bottomHeight,
          ),
        )
        .tighten(width: inputWidth);

    final BoxConstraints hintConstraints = boxConstraints.tighten(width: inputWidth);

    final RenderBox? input = this.input;
    final RenderBox? hint = this.hint;
    final Size inputSize = input == null
        ? Size.zero
        : layoutChild(input, inputConstraints);
    final Size hintSize = hint == null
        ? Size.zero
        : layoutChild(hint, hintConstraints);
    final double inputBaseline = input == null
        ? 0.0
        : getBaseline(input, inputConstraints);
    final double hintBaseline = hint == null
        ? 0.0
        : getBaseline(hint, hintConstraints);

    // The field can be occupied by a hint or by the input itself.
    final double inputHeight = math.max(
      decoration.isEmpty || decoration.maintainHintSize ? hintSize.height : 0.0,
      inputSize.height,
    );
    final double inputInternalBaseline = math.max(inputBaseline, hintBaseline);

    final double prefixBaseline = prefix == null ? 0.0 : getBaseline(prefix, contentConstraints);
    final double suffixBaseline = suffix == null ? 0.0 : getBaseline(suffix, contentConstraints);

    // Calculate the amount that prefix/suffix affects height above and below
    // the input.
    final double fixHeight = math.max(prefixBaseline, suffixBaseline);
    final double fixAboveInput = math.max(0, fixHeight - inputInternalBaseline);
    final double fixBelowBaseline = math.max(
      prefixSize.height - prefixBaseline,
      suffixSize.height - suffixBaseline,
    );
    // TODO(justinmc): fixBelowInput should have no effect when there is no
    // prefix/suffix below the input.
    // https://github.com/flutter/flutter/issues/66050
    final double fixBelowInput = math.max(
      0,
      fixBelowBaseline - (inputHeight - inputInternalBaseline),
    );

    // Calculate the height of the input text container.
    final double fixIconHeight = math.max(prefixIconSize.height, suffixIconSize.height);
    final double contentHeight = math.max(
      fixIconHeight,
      contentPadding.top +
          fixAboveInput +
          inputHeight +
          fixBelowInput +
          contentPadding.bottom
    );
    final double minContainerHeight = inputHeight;
    /*
    final double minContainerHeight = expands
        ? inputHeight
        : kMinInteractiveDimension;
    */
    final double maxContainerHeight = math.max(0.0, boxConstraints.maxHeight - bottomHeight);
    final double containerHeight = expands
        ? maxContainerHeight
        : math.min(math.max(contentHeight, minContainerHeight), maxContainerHeight);

    // Ensure the text is vertically centered in cases where the content is
    // shorter than kMinInteractiveDimension.
    final double interactiveAdjustment = minContainerHeight > contentHeight
        ? (minContainerHeight - contentHeight) / 2.0
        : 0.0;

    // Try to consider the prefix/suffix as part of the text when aligning it.
    // If the prefix/suffix overflows however, allow it to extend outside of the
    // input and align the remaining part of the text and prefix/suffix.
    final double overflow = math.max(0, contentHeight - maxContainerHeight);
    // Map textAlignVertical from -1:1 to 0:1 so that it can be used to scale
    // the baseline from its minimum to maximum values.
    final double textAlignVerticalFactor = (textAlignVertical.y + 1.0) / 2.0;
    // Adjust to try to fit top overflow inside the input on an inverse scale of
    // textAlignVertical, so that top aligned text adjusts the most and bottom
    // aligned text doesn't adjust at all.
    final double baselineAdjustment = fixAboveInput - overflow * (1 - textAlignVerticalFactor);

    // The baselines that will be used to draw the actual input text content.
    final double topInputBaseline =
        contentPadding.top +
        inputInternalBaseline +
        baselineAdjustment +
        interactiveAdjustment;
    final double maxContentHeight = containerHeight - contentPadding.vertical;
    final double alignableHeight = fixAboveInput + inputHeight + fixBelowInput;
    final double maxVerticalOffset = maxContentHeight - alignableHeight;

    final double baseline;
    if (_isOutlineAligned) {
      // The three main alignments for the baseline when an outline is present are
      //
      //  * top (-1.0): topmost point considering padding.
      //  * center (0.0): the absolute center of the input ignoring padding but
      //      accommodating the border and floating label.
      //  * bottom (1.0): bottommost point considering padding.
      //
      // That means that if the padding is uneven, center is not the exact
      // midpoint of top and bottom. To account for this, the above center and
      // below center alignments are interpolated independently.
      final double outlineCenterBaseline =
          inputInternalBaseline + baselineAdjustment / 2.0 + (containerHeight - inputHeight) / 2.0;
      final double outlineTopBaseline = topInputBaseline;
      final double outlineBottomBaseline = topInputBaseline + maxVerticalOffset;
      baseline = _interpolateThree(
        outlineTopBaseline,
        outlineCenterBaseline,
        outlineBottomBaseline,
        textAlignVertical,
      );
    } else {
      final double textAlignVerticalOffset = maxVerticalOffset * textAlignVerticalFactor;
      baseline = topInputBaseline + textAlignVerticalOffset;
    }

    return _RenderDecorationLayout(
      inputConstraints: inputConstraints,
      containerHeight: containerHeight,
      baseline: baseline,
      subtextSize: subtextSize,
      size: Size(constraints.maxWidth, containerHeight + (subtextSize?.subtextHeight ?? 0.0)),
    );
  }

  // Interpolate between three stops using textAlignVertical. This is used to
  // calculate the outline baseline, which ignores padding when the alignment is
  // middle. When the alignment is less than zero, it interpolates between the
  // centered text box's top and the top of the content padding. When the
  // alignment is greater than zero, it interpolates between the centered box's
  // top and the position that would align the bottom of the box with the bottom
  // padding.
  static double _interpolateThree(
    double begin,
    double middle,
    double end,
    TextAlignVertical textAlignVertical,
  ) {
    // It's possible for begin, middle, and end to not be in order because of
    // excessive padding. Those cases are handled by using middle.
    final double basis = textAlignVertical.y <= 0
        ? math.max(middle - begin, 0)
        : math.max(end - middle, 0);
    return middle + basis * textAlignVertical.y;
  }

  // TOOD: apply decoration.contentHeight to intrinsic calculation

  @override
  double computeMinIntrinsicWidth(double height) {
    final double contentWidth = decoration.isEmpty || decoration.maintainHintSize
        ? math.max(_minWidth(input, height), _minWidth(hint, height))
        : _minWidth(input, height);
    return _minWidth(icon, height) +
        (prefixIcon != null ? prefixToInputGap : contentPadding.start + decoration.inputGap) +
        _minWidth(prefixIcon, height) +
        _minWidth(prefix, height) +
        contentWidth +
        _minWidth(suffix, height) +
        _minWidth(suffixIcon, height) +
        (suffixIcon != null ? inputToSuffixGap : contentPadding.end + decoration.inputGap);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double contentWidth = decoration.isEmpty || decoration.maintainHintSize
        ? math.max(_maxWidth(input, height), _maxWidth(hint, height))
        : _maxWidth(input, height);
    return _maxWidth(icon, height) +
        (prefixIcon != null ? prefixToInputGap : contentPadding.start + decoration.inputGap) +
        _maxWidth(prefixIcon, height) +
        _maxWidth(prefix, height) +
        contentWidth +
        _maxWidth(suffix, height) +
        _maxWidth(suffixIcon, height) +
        (suffixIcon != null ? inputToSuffixGap : contentPadding.end + decoration.inputGap);
  }

  double _lineHeight(double width, List<RenderBox?> boxes) {
    double height = 0.0;
    for (final RenderBox? box in boxes) {
      if (box == null) {
        continue;
      }
      height = math.max(_minHeight(box, width), height);
    }
    return height;
    // TODO(hansmuller): this should compute the overall line height for the
    // boxes when they've been baseline-aligned.
    // See https://github.com/flutter/flutter/issues/13715
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final double iconHeight = _minHeight(icon, width);
    final double iconWidth = _minWidth(icon, iconHeight);

    width = math.max(width - iconWidth, 0.0);

    final double prefixIconHeight = _minHeight(prefixIcon, width);
    final double prefixIconWidth = _minWidth(prefixIcon, prefixIconHeight);

    final double suffixIconHeight = _minHeight(suffixIcon, width);
    final double suffixIconWidth = _minWidth(suffixIcon, suffixIconHeight);

    width = math.max(width - contentPadding.horizontal, 0.0);

    // TODO(LongCatIsLooong): use _computeSubtextSizes for subtext intrinsic sizes.
    // See https://github.com/flutter/flutter/issues/13715.
    final double counterHeight = _minHeight(counter, width);
    final double counterWidth = _minWidth(counter, counterHeight);

    final double helperErrorAvailableWidth = math.max(width - counterWidth, 0.0);
    final double helperErrorHeight = _minHeight(helperError, helperErrorAvailableWidth);
    double subtextHeight = math.max(counterHeight, helperErrorHeight);
    if (subtextHeight > 0.0) {
      subtextHeight += subtextGap;
    }

    final double prefixHeight = _minHeight(prefix, width);
    final double prefixWidth = _minWidth(prefix, prefixHeight);

    final double suffixHeight = _minHeight(suffix, width);
    final double suffixWidth = _minWidth(suffix, suffixHeight);

    final double availableInputWidth = math.max(
      width - prefixWidth - suffixWidth - prefixIconWidth - suffixIconWidth,
      0.0,
    );
    final double inputHeight = _lineHeight(availableInputWidth, <RenderBox?>[
      input,
      if (decoration.isEmpty) hint,
    ]);
    final double inputMaxHeight = <double>[
      inputHeight,
      prefixHeight,
      suffixHeight,
    ].reduce(math.max);

    final double contentHeight =
        contentPadding.top +
        inputMaxHeight +
        contentPadding.bottom;
    final double containerHeight = <double>[
      iconHeight,
      contentHeight,
      prefixIconHeight,
      suffixIconHeight,
    ].reduce(math.max);
    final double minContainerHeight = expands
        ? 0.0
        : kMinInteractiveDimension;

    return math.max(containerHeight, minContainerHeight) + subtextHeight;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return getMinIntrinsicHeight(width);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    final RenderBox? input = this.input;
    if (input == null) {
      return 0.0;
    }
    return _boxParentData(input).offset.dy +
        (input.getDistanceToActualBaseline(baseline) ?? input.size.height);
  }

  @override
  double? computeDryBaseline(covariant BoxConstraints constraints, TextBaseline baseline) {
    final RenderBox? input = this.input;
    if (input == null) {
      return 0.0;
    }
    final _RenderDecorationLayout layout = _layout(
      constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
      getBaseline: _getDryBaseline,
    );
    return switch (baseline) {
          TextBaseline.alphabetic => 0.0,
          TextBaseline.ideographic =>
            (input.getDryBaseline(layout.inputConstraints, TextBaseline.ideographic) ??
                    input.getDryLayout(layout.inputConstraints).height) -
                (input.getDryBaseline(layout.inputConstraints, TextBaseline.alphabetic) ??
                    input.getDryLayout(layout.inputConstraints).height),
        } +
        layout.baseline;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final _RenderDecorationLayout layout = _layout(
      constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
      getBaseline: _getDryBaseline,
    );
    return constraints.constrain(layout.size);
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final _RenderDecorationLayout layout = _layout(
      constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
      getBaseline: _getBaseline,
    );
    size = constraints.constrain(layout.size);
    assert(size.width == constraints.constrainWidth(layout.size.width));
    assert(size.height == constraints.constrainHeight(layout.size.height));

    final double overallWidth = layout.size.width;

    final RenderBox? container = this.container;
    if (container != null) {
      final BoxConstraints containerConstraints = BoxConstraints.tightFor(
        height: layout.containerHeight,
        width: overallWidth - _boxSize(icon).width,
      );
      container.layout(containerConstraints, parentUsesSize: true);
      final double x = switch (textDirection) {
        TextDirection.rtl => 0.0,
        TextDirection.ltr => _boxSize(icon).width,
      };
      _boxParentData(container).offset = Offset(x, 0.0);
    }

    final double height = layout.containerHeight;
    double centerLayout(RenderBox box, double x) {
      _boxParentData(box).offset = Offset(x, (height - box.size.height) / 2.0);
      return box.size.width;
    }

    if (icon != null) {
      final double x = switch (textDirection) {
        TextDirection.rtl => overallWidth - icon!.size.width,
        TextDirection.ltr => 0.0,
      };
      centerLayout(icon!, x);
    }

    final double subtextBaseline = (layout.subtextSize?.ascent ?? 0.0) + layout.containerHeight;
    final RenderBox? counter = this.counter;
    final double helperErrorBaseline = helperError.getDistanceToBaseline(TextBaseline.alphabetic)!;
    final double counterBaseline = counter?.getDistanceToBaseline(TextBaseline.alphabetic)! ?? 0.0;

    double start, end;
    switch (textDirection) {
      case TextDirection.ltr:
        start = contentPadding.start + _boxSize(icon).width;
        end = overallWidth - contentPadding.end;
        _boxParentData(helperError).offset = Offset(
          start + decoration.inputGap,
          subtextBaseline - helperErrorBaseline,
        );
        if (counter != null) {
          _boxParentData(counter).offset = Offset(
            end - counter.size.width - decoration.inputGap,
            subtextBaseline - counterBaseline,
          );
        }
      case TextDirection.rtl:
        start = overallWidth - contentPadding.start - _boxSize(icon).width;
        end = contentPadding.end;
        _boxParentData(helperError).offset = Offset(
          start - helperError.size.width - decoration.inputGap,
          subtextBaseline - helperErrorBaseline,
        );
        if (counter != null) {
          _boxParentData(counter).offset = Offset(
            end + decoration.inputGap,
            subtextBaseline - counterBaseline,
          );
        }
    }

    final double baseline = layout.baseline;
    double baselineLayout(RenderBox box, double x) {
      _boxParentData(box).offset = Offset(
        x,
        baseline - box.getDistanceToBaseline(TextBaseline.alphabetic)!,
      );
      return box.size.width;
    }

    switch (textDirection) {
      case TextDirection.rtl:
        {
          if (prefixIcon != null) {
            start += contentPadding.start;
            start -= centerLayout(prefixIcon!, start - prefixIcon!.size.width);
            start -= prefixToInputGap;
          } else {
            start -= decoration.inputGap;
          }
          if (prefix != null) {
            start -= baselineLayout(prefix!, start - prefix!.size.width);
          }
          if (input != null) {
            baselineLayout(input!, start - input!.size.width);
          }
          if (hint != null) {
            baselineLayout(hint!, start - hint!.size.width);
          }
          if (suffixIcon != null) {
            end -= contentPadding.end;
            end += centerLayout(suffixIcon!, end);
            end += inputToSuffixGap;
          } else {
            end += decoration.inputGap;
          }
          if (suffix != null) {
            end += baselineLayout(suffix!, end);
          }
          break;
        }
      case TextDirection.ltr:
        {
          if (prefixIcon != null) {
            start -= contentPadding.start;
            start += centerLayout(prefixIcon!, start);
            start += prefixToInputGap;
          } else {
            start += decoration.inputGap;
          }
          if (prefix != null) {
            start += baselineLayout(prefix!, start);
          }
          if (input != null) {
            baselineLayout(input!, start);
          }
          if (hint != null) {
            baselineLayout(hint!, start);
          }
          if (suffixIcon != null) {
            end += contentPadding.end;
            end -= centerLayout(suffixIcon!, end - suffixIcon!.size.width);
            end -= inputToSuffixGap;
          } else {
            end -= decoration.inputGap;
          }
          if (suffix != null) {
            end -= baselineLayout(suffix!, end - suffix!.size.width);
          }
          break;
        }
    }

    decoration.borderGap.start = null;
    decoration.borderGap.extent = 0.0;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox? child) {
      if (child != null) {
        context.paintChild(child, _boxParentData(child).offset + offset);
      }
    }

    doPaint(container);
    doPaint(icon);
    doPaint(prefix);
    doPaint(suffix);
    doPaint(prefixIcon);
    doPaint(suffixIcon);
    if (decoration.isEmpty) {
      doPaint(hint);
    }
    doPaint(input);
    doPaint(helperError);
    doPaint(counter);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final RenderBox child in children) {
      // The label must be handled specially since we've transformed it.
      final Offset offset = _boxParentData(child).offset;
      final bool isHit = result.addWithPaintOffset(
        offset: offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
    }
    return false;
  }

  ChildSemanticsConfigurationsResult _childSemanticsConfigurationDelegate(
    List<SemanticsConfiguration> childConfigs,
  ) {
    final ChildSemanticsConfigurationsResultBuilder builder =
        ChildSemanticsConfigurationsResultBuilder();
    List<SemanticsConfiguration>? prefixMergeGroup;
    List<SemanticsConfiguration>? suffixMergeGroup;
    for (final SemanticsConfiguration childConfig in childConfigs) {
      if (childConfig.tagsChildrenWith(_RadixInputDecoratorState._kPrefixSemanticsTag)) {
        prefixMergeGroup ??= <SemanticsConfiguration>[];
        prefixMergeGroup.add(childConfig);
      } else if (childConfig.tagsChildrenWith(_RadixInputDecoratorState._kSuffixSemanticsTag)) {
        suffixMergeGroup ??= <SemanticsConfiguration>[];
        suffixMergeGroup.add(childConfig);
      } else {
        builder.markAsMergeUp(childConfig);
      }
    }
    if (prefixMergeGroup != null) {
      builder.markAsSiblingMergeGroup(prefixMergeGroup);
    }
    if (suffixMergeGroup != null) {
      builder.markAsSiblingMergeGroup(suffixMergeGroup);
    }
    return builder.build();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    config.childConfigurationsDelegate = _childSemanticsConfigurationDelegate;
  }
}

class _Decorator extends SlottedMultiChildRenderObjectWidget<_DecorationSlot, RenderBox> {
  const _Decorator({
    required this.textAlignVertical,
    required this.decoration,
    required this.textDirection,
    required this.isFocused,
    required this.expands,
  });

  final _Decoration decoration;
  final TextDirection textDirection;
  final TextAlignVertical? textAlignVertical;
  final bool isFocused;
  final bool expands;

  @override
  Iterable<_DecorationSlot> get slots => _DecorationSlot.values;

  @override
  Widget? childForSlot(_DecorationSlot slot) {
    return switch (slot) {
      _DecorationSlot.icon => decoration.icon,
      _DecorationSlot.input => decoration.input,
      _DecorationSlot.hint => decoration.hint,
      _DecorationSlot.prefix => decoration.prefix,
      _DecorationSlot.suffix => decoration.suffix,
      _DecorationSlot.prefixIcon => decoration.prefixIcon,
      _DecorationSlot.suffixIcon => decoration.suffixIcon,
      _DecorationSlot.helperError => decoration.helperError,
      _DecorationSlot.counter => decoration.counter,
      _DecorationSlot.container => decoration.container,
    };
  }

  @override
  _RenderDecoration createRenderObject(BuildContext context) {
    return _RenderDecoration(
      decoration: decoration,
      textDirection: textDirection,
      textAlignVertical: textAlignVertical,
      isFocused: isFocused,
      expands: expands,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderDecoration renderObject) {
    renderObject
      ..decoration = decoration
      ..expands = expands
      ..isFocused = isFocused
      ..textAlignVertical = textAlignVertical
      ..textDirection = textDirection;
  }
}

class _AffixText extends StatelessWidget {
  const _AffixText({
    this.text,
    required this.style,
    this.child,
    this.padding,
    this.semanticsSortKey,
    required this.semanticsTag,
  });

  final String? text;
  final TextStyle style;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final SemanticsSortKey? semanticsSortKey;
  final SemanticsTag semanticsTag;

  @override
  Widget build(BuildContext context) {
    Widget? child = this.child;

    if (child == null) {
      if (text case final String text) {
        child = Text(text, style: style);
      }
    }

    if (padding case final EdgeInsetsGeometry padding) {
      child = Padding(padding: padding, child: child);
    }

    return DefaultTextStyle(
      style: style,
      child: Semantics(
        sortKey: semanticsSortKey,
        tagForChildren: semanticsTag,
        child: child,
      ),
    );
  }
}

/// Defines the appearance of a Radix text field.
///
/// [RadixInputDecorator] displays the visual elements of a Radix text field
/// around its input [child]. The visual elements themselves are defined
/// by an [RadixInputDecoration] object and their layout and appearance depend
/// on the `baseStyle`, `textAlign`, `isFocused`, and `isEmpty` parameters.
///
/// [RadixTextField] uses this widget to decorate its [EditableText] child.
///
/// [RadixInputDecorator] can be used to create widgets that look and behave like a
/// [RadixTextField] but support other kinds of input.
///
/// Requires one of its ancestors to be a [Material] widget. The [child] widget,
/// as well as the decorative widgets specified in [decoration], must have
/// non-negative baselines.
///
/// See also:
///
///  * [RadixTextField], which uses an [RadixInputDecorator] to display a border,
///    labels, and icons, around its [EditableText] child.
///  * [Decoration] and [DecoratedBox], for drawing arbitrary decorations
///    around other widgets.
class RadixInputDecorator extends StatefulWidget {
  /// Creates a widget that displays a border, labels, and icons,
  /// for a [RadixTextField].
  ///
  /// The [isFocused], [isHovering], [expands], and [isEmpty] arguments must not
  /// be null.
  const RadixInputDecorator({
    super.key,
    required this.decoration,
    this.textAlign,
    this.textAlignVertical,
    this.isFocused = false,
    this.isHovering = false,
    this.readOnly = false,
    this.tighContentHeight = true,
    this.expands = false,
    this.isEmpty = false,
    this.child,
  });

  /// The text and styles to use when decorating the child.
  ///
  /// Null [RadixInputDecoration] properties are initialized with the corresponding
  /// values from the ambient [RadixInputDecorationThemeData].
  final RadixInputDecoration decoration;

  /// How the text in the decoration should be aligned horizontally.
  final TextAlign? textAlign;

  /// {@template flutter.material.InputDecorator.textAlignVertical}
  /// How the text should be aligned vertically.
  ///
  /// Determines the alignment of the baseline within the available space of
  /// the input (typically a RadixTextField). For example, TextAlignVertical.top
  /// will place the baseline such that the text, and any attached decoration like
  /// prefix and suffix, is as close to the top of the input as possible without
  /// overflowing. The heights of the prefix and suffix are similarly included
  /// for other alignment values. If the height is greater than the height
  /// available, then the prefix and suffix will be allowed to overflow first
  /// before the text scrolls.
  /// {@endtemplate}
  final TextAlignVertical? textAlignVertical;

  /// Whether the input field has focus.
  ///
  /// Determines the position of the label text and the color and weight of the
  /// border.
  ///
  /// Defaults to false.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecoration.hoverColor], which is also blended into the focus
  ///    color and fill color when the [isHovering] is true to produce the final
  ///    color.
  final bool isFocused;

  /// Whether the input field is being hovered over by a mouse pointer.
  ///
  /// Determines the container fill color, which is a blend of
  /// [RadixInputDecoration.hoverColor] with [RadixInputDecoration.backgroundColor] when
  /// true, and [RadixInputDecoration.backgroundColor] when not.
  ///
  /// Defaults to false.
  final bool isHovering;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  final bool tighContentHeight;

  /// If true, the height of the input field will be as large as possible.
  ///
  /// If wrapped in a widget that constrains its child's height, like Expanded
  /// or SizedBox, the input field will only be affected if [expands] is set to
  /// true.
  ///
  /// See [RadixTextField.minLines] and [RadixTextField.maxLines] for related ways to
  /// affect the height of an input. When [expands] is true, both must be null
  /// in order to avoid ambiguity in determining the height.
  ///
  /// Defaults to false.
  final bool expands;

  /// Whether the input field is empty.
  ///
  /// Determines the position of the label text and whether to display the hint
  /// text.
  ///
  /// Defaults to false.
  final bool isEmpty;

  /// The widget below this widget in the tree.
  ///
  /// Typically an [EditableText], [DropdownButton], or [InkWell].
  final Widget? child;

  @override
  State<RadixInputDecorator> createState() => _RadixInputDecoratorState();

  /// The RenderBox that defines this decorator's "container". That's the
  /// area which is filled if [RadixInputDecoration.filled] is true. It's the area
  /// adjacent to [RadixInputDecoration.icon] and above the widgets that contain
  /// [RadixInputDecoration.helperText], [RadixInputDecoration.errorText], and
  /// [RadixInputDecoration.counterText].
  ///
  /// [RadixTextField] renders ink splashes within the container.
  static RenderBox? containerOf(BuildContext context) {
    final _RenderDecoration? result = context.findAncestorRenderObjectOfType<_RenderDecoration>();
    return result?.container;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<RadixInputDecoration>('decoration', decoration));
    properties.add(DiagnosticsProperty<bool>('isFocused', isFocused));
    properties.add(DiagnosticsProperty<bool>('expands', expands, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('isEmpty', isEmpty));
  }
}

class _RadixInputDecoratorState extends State<RadixInputDecorator> with TickerProviderStateMixin {
  final _InputBorderGap _borderGap = _InputBorderGap();
  // Provide a unique name to avoid mixing up sort order with sibling input
  // decorators.
  late final OrdinalSortKey _prefixSemanticsSortOrder = OrdinalSortKey(
    0,
    name: hashCode.toString(),
  );
  late final OrdinalSortKey _inputSemanticsSortOrder = OrdinalSortKey(1, name: hashCode.toString());
  late final OrdinalSortKey _suffixSemanticsSortOrder = OrdinalSortKey(
    2,
    name: hashCode.toString(),
  );
  static const SemanticsTag _kPrefixSemanticsTag = SemanticsTag('_InputDecoratorState.prefix');
  static const SemanticsTag _kSuffixSemanticsTag = SemanticsTag('_InputDecoratorState.suffix');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _effectiveDecoration = null;
  }

  @override
  void dispose() {
    _borderGap.dispose();
    _curvedAnimation?.dispose();
    super.dispose();
  }

  RadixInputDecoration? _effectiveDecoration;
  RadixInputDecoration get decoration => _effectiveDecoration!;

  RadixInputDecorationThemeData _getDefaultDecoration(ThemeData theme) {
    RadixInputDecorationThemeData? defaultDecoration = RadixInputDecorationTheme.of(context);
    if (defaultDecoration == null) {
      final RadixThemeData? radixThemeData = RadixTheme.maybeOf(context);
      defaultDecoration = radixThemeData?.inputDecorationTheme;
    }
    if (defaultDecoration == null) {
      final RadixInputDecorationThemeData decorationTheme = RadixInputDecorationTheme.extensionFrom(theme);
      defaultDecoration = decorationTheme;
    }
    return defaultDecoration;
  }

  TextAlign? get textAlign => widget.textAlign;
  bool get isFocused => widget.isFocused;
  bool get _hasError => decoration.errorText != null || decoration.error != null;
  bool get isHovering => widget.isHovering && decoration.enabled;
  bool get isEmpty => widget.isEmpty;

  @override
  void didUpdateWidget(RadixInputDecorator old) {
    super.didUpdateWidget(old);
    if (widget.decoration != old.decoration) {
      _effectiveDecoration = null;
    }
  }

  Color? _getIconColor(RadixInputDecorationThemeData defaults) {
    return WidgetStateProperty.resolveAs(decoration.iconColor, widgetState) ??
        WidgetStateProperty.resolveAs(defaults.iconColor, widgetState);
  }

  // The base style for the inline hint when they're displayed "inline",
  // i.e. when they appear in place of the empty text field.
  TextStyle _getInlineHintStyle(RadixInputDecorationThemeData defaults) {
    final TextStyle defaultStyle = WidgetStateProperty.resolveAs(
      defaults.hintStyle,
      widgetState,
    );

    final TextStyle? style = WidgetStateProperty.resolveAs(decoration.hintStyle, widgetState);

    return defaultStyle.merge(style);
  }

  TextStyle? _getErrorStyle(RadixInputDecorationThemeData defaults) {
    return WidgetStateProperty.resolveAs(
      defaults.errorStyle,
      widgetState,
    )?.merge(decoration.errorStyle);
  }

  TextStyle? _getAffixStyle(TextStyle? decoration, TextStyle? defaults) {
    final TextStyle? defaultStyle = WidgetStateProperty.resolveAs(
      defaults,
      widgetState,
    );

    final TextStyle? style = WidgetStateProperty.resolveAs(decoration, widgetState);

    return defaultStyle?.merge(style) ?? style;
  }

  Set<WidgetState> get widgetState => <WidgetState>{
    if (!decoration.enabled) WidgetState.disabled,
    if (isFocused) WidgetState.focused,
    if (isHovering) WidgetState.hovered,
    if (_hasError) WidgetState.error,
  };

  CurvedAnimation? _curvedAnimation;

  FadeTransition _buildTransition(Widget child, Animation<double> animation) {
    if (_curvedAnimation?.parent != animation) {
      _curvedAnimation?.dispose();
      _curvedAnimation = CurvedAnimation(parent: animation, curve: _kTransitionCurve);
    }

    return FadeTransition(opacity: _curvedAnimation!, child: child);
  }

  static Widget _topStartLayout(Widget? currentChild, List<Widget> previousChildren) {
    return Stack(children: <Widget>[...previousChildren, if (currentChild != null) currentChild]);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    final RadixInputDecorationThemeData defaults = _getDefaultDecoration(themeData);
    _effectiveDecoration ??= widget.decoration.applyDefaults(defaults);

    final Set<WidgetState> widgetState = this.widgetState;

    final TextStyle hintStyle = _getInlineHintStyle(defaults);
    final String? hintText = decoration.hintText;
    final bool maintainHintSize = decoration.maintainHintSize;
    Widget? hint;
    if (decoration.hint != null || hintText != null) {
      final Widget hintWidget =
          decoration.hint ??
          Text(
            hintText!,
            style: hintStyle,
            textDirection: decoration.hintTextDirection,
            overflow:
                hintStyle.overflow ??
                (decoration.hintMaxLines == null ? null : TextOverflow.ellipsis),
            textAlign: textAlign,
            maxLines: decoration.hintMaxLines,
          );
      final bool showHint = isEmpty;
      hint = maintainHintSize
          ? AnimatedOpacity(
              opacity: showHint ? 1.0 : 0.0,
              duration: decoration.hintFadeDuration ?? _kHintFadeTransitionDuration,
              curve: _kTransitionCurve,
              child: hintWidget,
            )
          : AnimatedSwitcher(
              duration: decoration.hintFadeDuration ?? _kHintFadeTransitionDuration,
              transitionBuilder: _buildTransition,
              layoutBuilder: _topStartLayout,
              child: showHint ? hintWidget : const SizedBox.shrink(),
            );
    }

    InputBorder? border;
    if (!decoration.enabled) {
      border = _hasError ? decoration.errorBorder : decoration.disabledBorder;
    } else if (isFocused) {
      border = _hasError ? decoration.focusedErrorBorder : decoration.focusedBorder;
    } else {
      if (!widget.isEmpty && !_hasError) {
        border = decoration.filledBorder;
      }

      border = _hasError ? decoration.errorBorder : decoration.enabledBorder;
    }

    Widget? container;

    final Color? fillColor = widget.readOnly
        ? decoration.readOnlyBackgroundColor ?? defaults.readOnlyBackgroundColor
        : WidgetStateProperty.resolveAs<Color?>(
            decoration.backgroundColor ?? defaults.backgroundColor,
            widgetState,
          );

    final BorderRadius? borderRadius = decoration.borderRadius ?? defaults.borderRadius;

    if (border != null && border != InputBorder.none) {
      container = CustomPaint(
        foregroundPainter: _InputBorderPainter(
          border: border,
          gap: _borderGap,
          textDirection: Directionality.of(context),
          fillColor: fillColor,
        ),
      );
    } else if (fillColor != null) {
      if (borderRadius != null) {
        container = DecoratedBox(
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: borderRadius,
          ),
        );
      } else {
        container = ColoredBox(
          color: fillColor,
        );
      }
    }

    final bool hasPrefix = decoration.prefix != null || decoration.prefixText != null;
    final bool hasSuffix = decoration.suffix != null || decoration.suffixText != null;

    final EdgeInsetsGeometry? prefixPadding = decoration.prefixPadding ?? defaults.prefixPadding;
    final EdgeInsetsGeometry? suffixPadding = decoration.suffixPadding ?? defaults.suffixPadding;

    Widget? input = widget.child;
    // If at least two out of the three are visible, it needs semantics sort
    // order.
    final bool needsSemanticsSortOrder =
        input != null ? (hasPrefix || hasSuffix) : (hasPrefix && hasSuffix);

    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final TextStyle defaultAffixTextStyle = defaultTextStyle.style.copyWith(
      color: decoration.affixColor ?? defaults.affixColor,
    );

    final TextStyle prefixStyle = _getAffixStyle(decoration.prefixStyle, defaults.prefixStyle)
        ?? hintStyle.copyWith(color: decoration.affixColor ?? defaults.affixColor);

    final Widget? prefix = hasPrefix
        ? _AffixText(
            text: decoration.prefixText,
            style: defaultAffixTextStyle.merge(prefixStyle),
            padding: prefixPadding,
            semanticsSortKey: needsSemanticsSortOrder ? _prefixSemanticsSortOrder : null,
            semanticsTag: _kPrefixSemanticsTag,
            child: decoration.prefix,
          )
        : null;

    final TextStyle suffixStyle = _getAffixStyle(decoration.suffixStyle, defaults.suffixStyle)
        ?? hintStyle.copyWith(color: decoration.affixColor ?? defaults.affixColor);

    final Widget? suffix = hasSuffix
        ? _AffixText(
            text: decoration.suffixText,
            style: defaultAffixTextStyle.merge(suffixStyle),
            padding: suffixPadding,
            semanticsSortKey: needsSemanticsSortOrder ? _suffixSemanticsSortOrder : null,
            semanticsTag: _kSuffixSemanticsTag,
            child: decoration.suffix,
          )
        : null;

    if (input != null && needsSemanticsSortOrder) {
      input = Semantics(sortKey: _inputSemanticsSortOrder, child: input);
    }

    // The _Decoration widget and _RenderDecoration assume that contentPadding
    // has been resolved to EdgeInsets.
    final TextDirection textDirection = Directionality.of(context);
    final double? contentHeight = decoration.contentHeight ?? defaults.contentHeight;

    if (contentHeight != null) {
      final BoxConstraints constraints = widget.tighContentHeight
          ? BoxConstraints.tightFor(
              height: contentHeight,
            )
          : BoxConstraints(
              minHeight: contentHeight,
            );

      if (input != null) {
        input = ConstrainedBox(
          constraints:constraints,
          child: Align(
            alignment: decoration.contentAlignment,
            heightFactor: 1,
            child: input,
          ),
        );
      }

      if (input == null && hint != null) {
        hint = ConstrainedBox(
          constraints: constraints,
          child: Align(
            alignment: decoration.contentAlignment,
            heightFactor: 1,
            child: hint,
          ),
        );
      }
    }

    final double? iconSize = decoration.iconSize;

    final Widget? icon = decoration.icon == null
        ? null
        : MouseRegion(
            cursor: SystemMouseCursors.basic,
            child: IconTheme.merge(
              data: IconThemeData(color: _getIconColor(defaults), size: iconSize),
              child: decoration.icon!,
            ),
          );

    Widget? prefixIcon;
    if (decoration.prefixIcon case final Widget icon) {
      if (prefixPadding != null) {
        prefixIcon = Padding(padding: prefixPadding, child: icon);
      }

      final Color? prefixIconColor = WidgetStateProperty.resolveAs(decoration.prefixIconColor, widgetState) ??
          WidgetStateProperty.resolveAs(defaults.prefixIconColor, widgetState);

      prefixIcon = IconTheme.merge(
        data: IconThemeData(
          color: prefixIconColor,
          size: iconSize,
        ),
        child: Semantics(child: prefixIcon ?? icon),
      );

      if (decoration.prefixIconConstraints case final BoxConstraints constraints) {
        prefixIcon = ConstrainedBox(
          constraints: constraints,
          child: prefixIcon,
        );
      }

      prefixIcon = Center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: MouseRegion(
          cursor: SystemMouseCursors.basic,
          child: prefixIcon,
        ),
      );
    }

    Widget? suffixIcon;
    if (decoration.suffixIcon case final Widget icon) {
      if (suffixPadding != null) {
        EdgeInsets padding = suffixPadding.resolve(textDirection);

        if (decoration._suffixGhostIconButtonUniformPadding case final EdgeInsets ghostIconButtonUniformPadding) {
          padding = padding - ghostIconButtonUniformPadding;
          padding = padding.clamp(EdgeInsets.zero, EdgeInsetsGeometry.infinity) as EdgeInsets;
        }

        suffixIcon = Padding(padding: padding, child: icon);
      }

      final Color? suffixIconColor = WidgetStateProperty.resolveAs(decoration.suffixIconColor, widgetState) ??
          WidgetStateProperty.resolveAs(defaults.suffixIconColor, widgetState);

      suffixIcon = IconTheme.merge(
        data: IconThemeData(
          color: suffixIconColor,
          size: iconSize,
        ),
        child: Semantics(child: suffixIcon ?? icon),
      );

      if (decoration.suffixIconConstraints case final BoxConstraints constraints) {
        suffixIcon = ConstrainedBox(
          constraints: constraints,
          child: suffixIcon,
        );
      }

      suffixIcon = Center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: MouseRegion(
          cursor: SystemMouseCursors.basic,
          child: suffixIcon,
        ),
      );
    }

    final TextStyle? helperStyle = WidgetStateProperty.resolveAs(
      defaults.helperStyle,
      widgetState,
    )?.merge(WidgetStateProperty.resolveAs(decoration.helperStyle, widgetState));

    final Widget helperError = _HelperError(
      textAlign: textAlign,
      helper: decoration.helper,
      helperText: decoration.helperText,
      helperStyle: helperStyle,
      helperMaxLines: decoration.helperMaxLines,
      error: decoration.error,
      errorText: decoration.errorText,
      errorStyle: _getErrorStyle(defaults),
      errorMaxLines: decoration.errorMaxLines,
    );

    Widget? counter;
    if (decoration.counter != null) {
      counter = decoration.counter;
    } else if (decoration.counterText != null && decoration.counterText != '') {
      final TextStyle? style = WidgetStateProperty.resolveAs(decoration.counterStyle, widgetState);

      counter = Semantics(
        container: true,
        liveRegion: isFocused,
        child: Text(
          decoration.counterText!,
          style: helperStyle?.merge(style) ?? style,
          overflow: TextOverflow.ellipsis,
          semanticsLabel: decoration.semanticCounterText,
        ),
      );
    }

    final bool flipHorizontal = switch (textDirection) {
      TextDirection.ltr => false,
      TextDirection.rtl => true,
    };
    final EdgeInsets? resolvedPadding = decoration.contentPadding?.resolve(textDirection);
    final EdgeInsetsDirectional? decorationContentPadding;
    if (resolvedPadding == null) {
      decorationContentPadding = null;
    } else {
      final double right = resolvedPadding.right - (prefix == null && prefixIcon == null ? 0.0 : decoration._variantContentPadding.right);
      final double left = resolvedPadding.left - (suffix == null && suffixIcon == null ? 0.0 : decoration._variantContentPadding.left);

      decorationContentPadding = EdgeInsetsDirectional.fromSTEB(
        flipHorizontal ? right : left,
        resolvedPadding.top,
        flipHorizontal ? left : right,
        resolvedPadding.bottom,
      );
    }

    final EdgeInsetsDirectional contentPadding = decorationContentPadding ?? EdgeInsetsDirectional.zero;

    double inputGap = 0.0;
    if (border is OutlineInputBorder) {
      inputGap = border.gapPadding;
    }

    final double? prefixToInputGap = decoration.prefixToInputGap ?? defaults.prefixToInputGap;
    final double? inputToSuffixGap = decoration.inputToSuffixGap ?? defaults.inputToSuffixGap;

    final double? subtextGap = decoration.subtextGap ?? defaults.subtextGap;

    final _Decorator decorator = _Decorator(
      decoration: _Decoration(
        contentHeight: contentHeight,
        contentPadding: contentPadding,
        inputGap: inputGap,
        border: border,
        borderGap: _borderGap,
        isEmpty: isEmpty,
        maintainHintSize: maintainHintSize,
        icon: icon,
        input: input,
        hint: hint,
        prefix: prefix,
        suffix: suffix,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixToInputGap: prefixToInputGap,
        inputToSuffixGap: inputToSuffixGap,
        helperError: helperError,
        counter: counter,
        subtextGap: subtextGap,
        container: container,
      ),
      textDirection: textDirection,
      textAlignVertical: widget.textAlignVertical,
      isFocused: isFocused,
      expands: widget.expands,
    );

    final BoxConstraints? constraints = decoration.constraints;
    if (constraints != null) {
      return ConstrainedBox(constraints: constraints, child: decorator);
    }
    return decorator;
  }
}

enum RadixInputSize {
  $1, $2, $3
}

/// Radix uses inner shadow for classic variant,
/// but Flutter doesn't support inner shadow, so the classic variant
/// isn't defined.
enum RadixInputVariant {
  surface, soft
}

class RadixInputDecorationVariantFactor {
  RadixInputDecorationVariantFactor({
    required this.height,
    required this.padding,
    required this.textIndent,
    required this.textStyle,
    this.gap = 0.0,
    this.borderRadius,
    required this.slotPadding,
  })  : assert(
          !(!textStyle.inherit && (textStyle.fontSize == null || textStyle.textBaseline == null)),
          'inherit false textStyle must supply fontSize and textBaseline',
        );

  final double height;

  /// The padding for the input decoration's container. 
  /// 
  /// The padding is conditionally applied based on
  /// the presence of prefix and suffix widgets.
  ///
  /// * If [RadixInputDecoration.prefixIcon], [RadixInputDecoration.prefix],
  ///    or [RadixInputDecoration.prefixText] is present,
  ///    the left padding inset is excluded.
  /// * If [RadixInputDecoration.suffixIcon], [RadixInputDecoration.suffix],
  ///   or [RadixInputDecoration.suffixText] is present,
  ///   the right padding inset is excluded.
  final EdgeInsets padding;

  final double textIndent;

  final TextStyle textStyle;

  final double gap;

  final BorderRadius? borderRadius;

  final EdgeInsets slotPadding;

  /// Linearly interpolate between two [RadixInputDecorationVariantFactor]s.
  ///
  /// {@macro dart.ui.shadow.lerp}
  RadixInputDecorationVariantFactor lerp(RadixInputDecorationVariantFactor other, double t) {
    return RadixInputDecorationVariantFactor(
      height: lerpDouble(height, other.height, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      textIndent: lerpDouble(textIndent, other.textIndent, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      slotPadding: EdgeInsets.lerp(slotPadding, other.slotPadding, t)!,
    );
  }
}

class RadixInputDecorationVariant {
  RadixInputDecorationVariant({
    this.debugVariant,
    this.debugSize,
    required this.backgroundColor,
    Color? focusedBackgroundColor,
    required this.disabledBackgroundColor,
    required this.readOnlyBackgroundColor,
    required this.textColor,
    required this.disabledTextColor,
    required this.readOnlyTextColor,
    required this.hintColor,
    this.side,
    BorderSide? filledSide,
    required this.focusedSide,
    this.disabledSide,
    this.readOnlySide,
    required this.slotColor,
    required this.selectionColor,
    required this.disabledSelectionColor,
    required this.readOnlySelectionColor,
  }) : filledSide = filledSide ?? side,
       focusedBackgroundColor = focusedBackgroundColor ?? backgroundColor;

  final RadixInputVariant? debugVariant;
  final RadixInputSize? debugSize;
  final Color backgroundColor;
  final Color focusedBackgroundColor;
  final Color disabledBackgroundColor;
  final Color readOnlyBackgroundColor;
  final Color textColor;
  final Color disabledTextColor;
  final Color readOnlyTextColor;
  final Color hintColor;
  final BorderSide? side;

  /// The state of a form field that is not empty.
  final BorderSide? filledSide;

  final BorderSide focusedSide;
  final BorderSide? disabledSide;
  final BorderSide? readOnlySide;

  /// The Color to use for the [RadixInputDecoration.prefixIcon],
  /// [RadixInputDecoration.prefixText], [RadixInputDecoration.suffixIcon],
  /// and the [RadixInputDecoration.suffixText].
  final Color slotColor;

  /// The background color of selected text.
  final Color selectionColor;
  final Color disabledSelectionColor;
  final Color readOnlySelectionColor;
}

class RadixInputDecorationSurfaceVariant extends RadixInputDecorationVariant {
  RadixInputDecorationSurfaceVariant({
    super.debugSize,
    required super.backgroundColor,
    required super.disabledBackgroundColor,
    required super.readOnlyBackgroundColor,
    required super.textColor,
    required super.disabledTextColor,
    required super.readOnlyTextColor,
    required super.hintColor,
    required BorderSide super.side,
    super.filledSide,
    required super.focusedSide,
    required BorderSide super.disabledSide,
    required BorderSide super.readOnlySide,
    required super.slotColor,
    required super.selectionColor,
    required super.disabledSelectionColor,
    required super.readOnlySelectionColor,
  }) : super(debugVariant: RadixInputVariant.surface);

  factory RadixInputDecorationSurfaceVariant.from({
    required RadixColorsSwatch graySwatch,
    required RadixColorsSwatch accentColorSwatch,
    RadixColorsSwatch? focusColorSwatch,
    required Color surfaceColor,
  }) {
    assert(focusColorSwatch != graySwatch);

    return RadixInputDecorationSurfaceVariant(
      backgroundColor: surfaceColor,
      disabledBackgroundColor: graySwatch.radixScale_2.alphaVariant,
      readOnlyBackgroundColor: graySwatch.radixScale_2.alphaVariant,
      textColor: graySwatch.scale_12,
      disabledTextColor: graySwatch.radixScale_11.alphaVariant,
      readOnlyTextColor: graySwatch.radixScale_11.alphaVariant,
      hintColor: graySwatch.radixScale_10.alphaVariant,
      side: BorderSide(
        width: 1.0,
        color: graySwatch.radixScale_7.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      focusedSide: BorderSide(
        width: 2.0,
        color: (focusColorSwatch ?? accentColorSwatch).scale_8,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
      disabledSide: BorderSide(
        width: 1.0,
        color: accentColorSwatch.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      readOnlySide: BorderSide(
        width: 1.0,
        color: accentColorSwatch.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      slotColor: graySwatch.radixScale_11.alphaVariant,
      selectionColor: (focusColorSwatch ?? accentColorSwatch).radixScale_5.alphaVariant,
      disabledSelectionColor: graySwatch.radixScale_5.alphaVariant,
      readOnlySelectionColor: graySwatch.radixScale_5.alphaVariant,
    );
  }

  factory RadixInputDecorationSurfaceVariant.figmaDesign({
    required RadixColorsSwatch neutralSwatch,
    required RadixColorsSwatch accentColorSwatch,
    required Color surfaceColor,
  }) {
    return RadixInputDecorationSurfaceVariant(
      backgroundColor: surfaceColor,
      disabledBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      textColor: neutralSwatch.scale_12,
      disabledTextColor: neutralSwatch.scale_12,
      readOnlyTextColor: neutralSwatch.scale_12,
      hintColor: neutralSwatch.radixScale_9.alphaVariant,
      side: BorderSide(
        width: 1.0,
        color: neutralSwatch.radixScale_5.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      filledSide: BorderSide(
        width: 1.0,
        color: neutralSwatch.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      focusedSide: BorderSide(
        width: 1.0,
        color: accentColorSwatch.radixScale_8.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      disabledSide: BorderSide(
        width: 1.0,
        color: neutralSwatch.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      readOnlySide: BorderSide(
        width: 1.0,
        color: neutralSwatch.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      // The Figma design does not specify slot or selection colors,
      // so we fall back to the web spec instead.
      slotColor: neutralSwatch.radixScale_11.alphaVariant,
      selectionColor: accentColorSwatch.radixScale_5.alphaVariant,
      disabledSelectionColor: neutralSwatch.radixScale_5.alphaVariant,
      readOnlySelectionColor: neutralSwatch.radixScale_5.alphaVariant,
    );
  }
}

class RadixInputDecorationSoftVariant extends RadixInputDecorationVariant {
  RadixInputDecorationSoftVariant({
    super.debugSize,
    required super.backgroundColor,
    required super.disabledBackgroundColor,
    required super.readOnlyBackgroundColor,
    required super.textColor,
    required super.disabledTextColor,
    required super.readOnlyTextColor,
    required super.hintColor,
    required super.focusedSide,
    required super.slotColor,
    required super.selectionColor,
    required super.disabledSelectionColor,
    required super.readOnlySelectionColor,
  }) : super(debugVariant: RadixInputVariant.soft);

  factory RadixInputDecorationSoftVariant.from({
    required RadixColorsSwatch graySwatch,
    required RadixColorsSwatch accentColorSwatch,
  }) {
    return RadixInputDecorationSoftVariant(
      backgroundColor: accentColorSwatch.radixScale_3.alphaVariant,
      disabledBackgroundColor: graySwatch.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: graySwatch.radixScale_3.alphaVariant,
      textColor: graySwatch.scale_12,
      disabledTextColor: graySwatch.radixScale_11.alphaVariant,
      readOnlyTextColor: graySwatch.radixScale_11.alphaVariant,
      hintColor: graySwatch.scale_12.withOpacity(0.6),
      focusedSide: BorderSide(
        width: 2.0,
        color: accentColorSwatch.scale_8,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
      slotColor: graySwatch.scale_12,
      selectionColor: accentColorSwatch.radixScale_5.alphaVariant,
      disabledSelectionColor: graySwatch.radixScale_5.alphaVariant,
      readOnlySelectionColor: graySwatch.radixScale_5.alphaVariant,
    );
  }

  factory RadixInputDecorationSoftVariant.figmaDesign({
    required RadixColorsSwatch neutralSwatch,
    required RadixColorsSwatch accentColorSwatch,
  }) {
    return RadixInputDecorationSoftVariant(
      backgroundColor: accentColorSwatch.radixScale_3.alphaVariant,
      disabledBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: neutralSwatch.radixScale_3.alphaVariant,
      textColor: neutralSwatch.scale_12,
      disabledTextColor: neutralSwatch.scale_12,
      readOnlyTextColor: neutralSwatch.scale_12,
      hintColor: neutralSwatch.radixScale_9.alphaVariant,
      focusedSide: BorderSide(
        width: 1.0,
        color: accentColorSwatch.radixScale_8.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      // The Figma design does not specify slot or selection colors,
      // so we fall back to the web spec instead.
      slotColor: neutralSwatch.scale_12,
      selectionColor: accentColorSwatch.radixScale_5.alphaVariant,
      disabledSelectionColor: neutralSwatch.radixScale_5.alphaVariant,
      readOnlySelectionColor: neutralSwatch.radixScale_5.alphaVariant,
    );
  }
}

class RadixInputSizeSwatch {
  const RadixInputSizeSwatch({
    required this.s1,
    required this.s2,
    required this.s3,
  });

  final RadixInputDecorationVariantFactor s1;
  final RadixInputDecorationVariantFactor s2;
  final RadixInputDecorationVariantFactor s3;

  /// The value of [RadixInputDecorationVariantFactor.textIndent]
  /// does not account with border width (i.e., it is not subtracted by
  /// `--text-field-border-width`). This difference exists because the Flutter 
  /// implementation deviates from the original web behavior.
  static final RadixInputSizeSwatch kDefault = RadixInputSizeSwatch(
    s1: RadixInputDecorationVariantFactor(
      height: RadixSpace.kDefault.scale_5,
      padding: EdgeInsets.all(1.0),
      textIndent: RadixSpace.kDefault.scale_1 * 1.5,
      textStyle: RadixTextTheme.kDefault.scale_1,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_2,
      ),
      slotPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_1,
      ),
    ),
    s2: RadixInputDecorationVariantFactor(
      height: RadixSpace.kDefault.scale_6,
      padding: EdgeInsets.all(1.0),
      textIndent: RadixSpace.kDefault.scale_2,
      textStyle: RadixTextTheme.kDefault.scale_2,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_2,
      ),
      slotPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_2,
      ),
    ),
    s3: RadixInputDecorationVariantFactor(
      height: RadixSpace.kDefault.scale_7,
      padding: EdgeInsets.all(1.0),
      textIndent: RadixSpace.kDefault.scale_3,
      textStyle: RadixTextTheme.kDefault.scale_3,
      borderRadius: BorderRadius.all(
        RadixRadiusFactor.kDefault.medium.swatch.scale_3,
      ),
      slotPadding: EdgeInsets.symmetric(
        horizontal: RadixSpace.kDefault.scale_3,
      ),
    ),
  );

  /// Linearly interpolate between two [RadixInputSizeSwatch]es.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static RadixInputSizeSwatch lerp(RadixInputSizeSwatch a, RadixInputSizeSwatch b, double t) {
    return RadixInputSizeSwatch(
      s1: a.s1.lerp(b.s1, t),
      s2: a.s2.lerp(b.s2, t),
      s3: a.s3.lerp(b.s3, t),
    );
  }
}

/// Radix uses inner shadow for classic variant,
/// but Flutter doesn't support inner shadow, so the classic variant
/// isn't defined.
class RadixInputDecorationVariantTheme {
  RadixInputDecorationVariantTheme({
    required this.surface,
    required this.soft,
    required this.sizeSwatch,
  });

  final RadixInputDecorationVariant surface;
  final RadixInputDecorationVariant soft;

  final RadixInputSizeSwatch sizeSwatch;

  static RadixInputDecorationVariantTheme kLight = RadixInputDecorationVariantTheme(
    surface: RadixInputDecorationVariant(
      debugVariant: RadixInputVariant.surface,
      backgroundColor: RadixColorScheme.kLight.surfaceColor,
      disabledBackgroundColor: RadixColorScheme.kLight.gray.radixScale_2.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kLight.gray.radixScale_2.alphaVariant,
      textColor: RadixColorScheme.kLight.gray.scale_12,
      disabledTextColor: RadixColorScheme.kLight.gray.radixScale_11.alphaVariant,
      readOnlyTextColor: RadixColorScheme.kLight.gray.radixScale_11.alphaVariant,
      hintColor: RadixColorScheme.kLight.gray.radixScale_10.alphaVariant,
      side: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kLight.gray.radixScale_7.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      focusedSide: BorderSide(
        width: 2.0,
        color: RadixColorScheme.kLight.focus.scale_8,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
      disabledSide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kLight.gray.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      readOnlySide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kLight.gray.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      slotColor: RadixColorScheme.kLight.gray.radixScale_11.alphaVariant,
      selectionColor: RadixColorScheme.kLight.focus.radixScale_5.alphaVariant,
      disabledSelectionColor: RadixColorScheme.kLight.gray.radixScale_5.alphaVariant,
      readOnlySelectionColor: RadixColorScheme.kLight.gray.radixScale_5.alphaVariant,
    ),
    soft: RadixInputDecorationVariant(
      debugVariant: RadixInputVariant.soft,
      backgroundColor: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
      disabledBackgroundColor: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kLight.gray.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kLight.accent.scale_12,
      disabledTextColor: RadixColorScheme.kLight.gray.radixScale_11.alphaVariant,
      readOnlyTextColor: RadixColorScheme.kLight.gray.radixScale_11.alphaVariant,
      hintColor: RadixColorScheme.kLight.gray.scale_12.withOpacity(0.6),
      focusedSide: BorderSide(
        width: 2.0,
        color: RadixColorScheme.kLight.accent.scale_8,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
      slotColor: RadixColorScheme.kLight.gray.scale_12,
      selectionColor: RadixColorScheme.kLight.accent.radixScale_5.alphaVariant,
      disabledSelectionColor: RadixColorScheme.kLight.gray.radixScale_5.alphaVariant,
      readOnlySelectionColor: RadixColorScheme.kLight.gray.radixScale_5.alphaVariant,
    ),
    sizeSwatch: RadixInputSizeSwatch.kDefault,
  );

  /// The visual styles are derived by reconciling the Figma design.
  /// They use a neutral color instead of gray for disabled state,
  /// when widgets cannot be interacted with.
  static RadixInputDecorationVariantTheme kFigmaLight = RadixInputDecorationVariantTheme(
    surface: RadixInputDecorationVariant(
      debugVariant: RadixInputVariant.surface,
      backgroundColor: RadixColorScheme.kLight.surfaceColor,
      disabledBackgroundColor: RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kLight.neutral.scale_12,
      disabledTextColor: RadixColorScheme.kLight.neutral.scale_12,
      readOnlyTextColor: RadixColorScheme.kLight.neutral.scale_12,
      hintColor: RadixColorScheme.kLight.neutral.radixScale_9.alphaVariant,
      side: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kLight.neutral.radixScale_5.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      filledSide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kLight.neutral.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      focusedSide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kLight.accent.radixScale_8.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      disabledSide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kLight.neutral.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      readOnlySide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kLight.neutral.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      // The Figma design does not specify slot or selection colors,
      // so we fall back to the web spec instead.
      slotColor: RadixColorScheme.kLight.neutral.radixScale_11.alphaVariant,
      selectionColor: RadixColorScheme.kLight.focus.radixScale_5.alphaVariant,
      disabledSelectionColor: RadixColorScheme.kLight.neutral.radixScale_5.alphaVariant,
      readOnlySelectionColor: RadixColorScheme.kLight.neutral.radixScale_5.alphaVariant,
    ),
    soft: RadixInputDecorationVariant(
      debugVariant: RadixInputVariant.soft,
      backgroundColor: RadixColorScheme.kLight.accent.radixScale_3.alphaVariant,
      focusedBackgroundColor: RadixColorScheme.kLight.accent.radixScale_5.alphaVariant,
      disabledBackgroundColor: RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kLight.neutral.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kLight.neutral.scale_12,
      disabledTextColor: RadixColorScheme.kLight.neutral.scale_12,
      readOnlyTextColor: RadixColorScheme.kLight.neutral.scale_12,
      hintColor: RadixColorScheme.kLight.neutral.radixScale_9.alphaVariant,
      focusedSide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kLight.accent.radixScale_8.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      // The Figma design does not specify slot or selection colors,
      // so we fall back to the web spec instead.
      slotColor: RadixColorScheme.kLight.neutral.scale_12,
      selectionColor: RadixColorScheme.kLight.accent.radixScale_5.alphaVariant,
      disabledSelectionColor: RadixColorScheme.kLight.neutral.radixScale_5.alphaVariant,
      readOnlySelectionColor: RadixColorScheme.kLight.neutral.radixScale_5.alphaVariant,
    ),
    sizeSwatch: RadixInputSizeSwatch.kDefault,
  );

  static RadixInputDecorationVariantTheme kDark = RadixInputDecorationVariantTheme(
    surface: RadixInputDecorationVariant(
      debugVariant: RadixInputVariant.surface,
      backgroundColor: RadixColorScheme.kDark.surfaceColor,
      disabledBackgroundColor: RadixColorScheme.kDark.gray.radixScale_2.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kDark.gray.radixScale_2.alphaVariant,
      textColor: RadixColorScheme.kDark.gray.scale_12,
      disabledTextColor: RadixColorScheme.kDark.gray.radixScale_11.alphaVariant,
      readOnlyTextColor: RadixColorScheme.kDark.gray.radixScale_11.alphaVariant,
      hintColor: RadixColorScheme.kDark.gray.radixScale_10.alphaVariant,
      side: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kDark.gray.radixScale_7.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      focusedSide: BorderSide(
        width: 2.0,
        color: RadixColorScheme.kDark.focus.scale_8,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
      disabledSide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kDark.gray.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      readOnlySide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kDark.gray.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      slotColor: RadixColorScheme.kDark.gray.radixScale_11.alphaVariant,
      selectionColor: RadixColorScheme.kDark.focus.radixScale_5.alphaVariant,
      disabledSelectionColor: RadixColorScheme.kDark.gray.radixScale_5.alphaVariant,
      readOnlySelectionColor: RadixColorScheme.kDark.gray.radixScale_5.alphaVariant,
    ),
    soft: RadixInputDecorationVariant(
      debugVariant: RadixInputVariant.soft,
      backgroundColor: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
      disabledBackgroundColor: RadixColorScheme.kDark.gray.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kDark.gray.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kDark.accent.scale_12,
      disabledTextColor: RadixColorScheme.kDark.gray.radixScale_11.alphaVariant,
      readOnlyTextColor: RadixColorScheme.kDark.gray.radixScale_11.alphaVariant,
      hintColor: RadixColorScheme.kDark.gray.scale_12.withOpacity(0.6),
      focusedSide: BorderSide(
        width: 2.0,
        color: RadixColorScheme.kDark.accent.scale_8,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
      slotColor: RadixColorScheme.kDark.gray.scale_12,
      selectionColor: RadixColorScheme.kDark.accent.radixScale_5.alphaVariant,
      disabledSelectionColor: RadixColorScheme.kDark.gray.radixScale_5.alphaVariant,
      readOnlySelectionColor: RadixColorScheme.kDark.gray.radixScale_5.alphaVariant,
    ),
    sizeSwatch: RadixInputSizeSwatch.kDefault,
  );

  /// The visual styles are derived by reconciling the Figma design.
  /// They use a neutral color instead of gray for disabled state,
  /// when widgets cannot be interacted with.
  static RadixInputDecorationVariantTheme kFigmaDark = RadixInputDecorationVariantTheme(
    surface: RadixInputDecorationVariant(
      debugVariant: RadixInputVariant.surface,
      backgroundColor: RadixColorScheme.kDark.surfaceColor,
      disabledBackgroundColor: RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kDark.neutral.scale_12,
      disabledTextColor: RadixColorScheme.kDark.neutral.scale_12,
      readOnlyTextColor: RadixColorScheme.kDark.neutral.scale_12,
      hintColor: RadixColorScheme.kDark.neutral.radixScale_9.alphaVariant,
      side: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kDark.neutral.radixScale_5.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      filledSide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kDark.neutral.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      focusedSide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kDark.accent.radixScale_8.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      disabledSide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kDark.neutral.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      readOnlySide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kDark.neutral.radixScale_6.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      // The Figma design does not specify slot or selection colors,
      // so we fall back to the web spec instead.
      slotColor: RadixColorScheme.kDark.neutral.radixScale_11.alphaVariant,
      selectionColor: RadixColorScheme.kDark.focus.radixScale_5.alphaVariant,
      disabledSelectionColor: RadixColorScheme.kDark.neutral.radixScale_5.alphaVariant,
      readOnlySelectionColor: RadixColorScheme.kDark.neutral.radixScale_5.alphaVariant,
    ),
    soft: RadixInputDecorationVariant(
      debugVariant: RadixInputVariant.soft,
      backgroundColor: RadixColorScheme.kDark.accent.radixScale_3.alphaVariant,
      focusedBackgroundColor: RadixColorScheme.kDark.accent.radixScale_5.alphaVariant,
      disabledBackgroundColor: RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
      readOnlyBackgroundColor: RadixColorScheme.kDark.neutral.radixScale_3.alphaVariant,
      textColor: RadixColorScheme.kDark.neutral.scale_12,
      disabledTextColor: RadixColorScheme.kDark.neutral.scale_12,
      readOnlyTextColor: RadixColorScheme.kDark.neutral.scale_12,
      hintColor: RadixColorScheme.kDark.neutral.radixScale_9.alphaVariant,
      focusedSide: BorderSide(
        width: 1.0,
        color: RadixColorScheme.kDark.accent.radixScale_8.alphaVariant,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
      // The Figma design does not specify slot or selection colors,
      // so we fall back to the web spec instead.
      slotColor: RadixColorScheme.kDark.neutral.scale_12,
      selectionColor: RadixColorScheme.kDark.accent.radixScale_5.alphaVariant,
      disabledSelectionColor: RadixColorScheme.kDark.neutral.radixScale_5.alphaVariant,
      readOnlySelectionColor: RadixColorScheme.kDark.neutral.radixScale_5.alphaVariant,
    ),
    sizeSwatch: RadixInputSizeSwatch.kDefault,
  );

  /// The [RadixThemeData.inputDecorationVariantTheme] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).inputDecorationVariantTheme`.
  static RadixInputDecorationVariantTheme? of(BuildContext context) => RadixTheme.of(context).inputDecorationVariantTheme;

  /// The [RadixThemeExtension.inputDecorationVariantTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).inputDecorationVariantTheme`.
  static RadixInputDecorationVariantTheme? fromTheme(BuildContext context) => RadixTheme.fromTheme(context).inputDecorationVariantTheme;

  /// The [RadixThemeExtension.inputDecorationVariantTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).inputDecorationVariantTheme`.
  static RadixInputDecorationVariantTheme? extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).inputDecorationVariantTheme;
}

/// The border, icons, and styles used to decorate a Radix text field.
///
/// The [RadixTextField] and [RadixInputDecorator] classes use [RadixInputDecoration] objects
/// to describe their decoration. (In fact, this class is merely the
/// configuration of an [RadixInputDecorator], which does all the heavy lifting.)
///
/// ## Limitation
///
/// Flutter does not implement the `text-indent` feature found in CSS,
/// which means the exact Web behavior cannot be achieved:
/// (i.e., achieving the effect of padding-left without cutting off long 
/// values when the cursor is at the end).
///
/// {@tool dartpad}
/// This sample shows how to style a `RadixTextField` using an `RadixInputDecorator`.
/// The RadixTextField displays a "send message" icon to the left of the input area,
/// which is surrounded by a border an all sides. It displays the `hintText`
/// inside the input area to help the user understand what input is required. It
/// displays the `helperText` and `counterText` below the input area.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/input_decoration.png)
///
/// ** See code in examples/api/lib/input_decorator/input_decoration.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This sample shows how to create a `RadixTextField` with hint text, a red border
/// on all sides, and an error message.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/input_decoration_error.png)
///
/// ** See code in examples/api/lib/input_decorator/input_decoration.1.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This sample shows how to style a `RadixTextField` with a round border and
/// additional text before and after the input area. It displays "Prefix" before
/// the input area, and "Suffix" after the input area.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/input_decoration_prefix_suffix.png)
///
/// ** See code in examples/api/lib/input_decorator/input_decoration.2.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This sample shows how to style a `RadixTextField` with a prefixIcon that changes color
/// based on the `WidgetState`. The color defaults to gray and is green while focused.
///
/// ** See code in examples/api/lib/input_decorator/input_decoration.widget_state.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This sample shows how to style a `RadixTextField` with a prefixIcon that changes color
/// based on the `WidgetState` through the use of `RadixInputDecorationThemeData`.
/// The color defaults to gray, be blue while focused and red if in an error state.
///
/// ** See code in examples/api/lib/input_decorator/input_decoration.widget_state.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * [RadixTextField], which is a text input widget that uses an
///    [RadixInputDecoration].
///  * [RadixInputDecorator], which is a widget that draws an [RadixInputDecoration]
///    around an input child widget.
///  * [Decoration] and [DecoratedBox], for drawing borders and backgrounds
///    around a child widget.
@immutable
class RadixInputDecoration {
  /// Creates a bundle of the border, icons, and styles used to
  /// decorate a Radix text field.
  ///
  /// Only one of [prefix] and [prefixText] can be specified.
  ///
  /// Similarly, only one of [suffix] and [suffixText] can be specified.
  const RadixInputDecoration({
    this.textStyle,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.helper,
    this.helperText,
    this.helperStyle,
    this.helperMaxLines,
    this.hintText,
    this.hint,
    this.hintStyle,
    this.hintTextDirection,
    this.hintMaxLines,
    this.hintFadeDuration,
    this.maintainHintSize = true,
    this.error,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.subtextGap,
    this.contentPadding,
    this.contentAlignment = AlignmentDirectional.centerStart,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.prefixPadding,
    this.prefixToInputGap,
    this.prefix,
    this.prefixText,
    this.prefixStyle,
    this.prefixIconColor,
    this.suffixIcon,
    this.suffix,
    this.suffixText,
    this.suffixStyle,
    this.suffixIconColor,
    this.suffixIconConstraints,
    this.suffixPadding,
    this.inputToSuffixGap,
    this.affixColor,
    this.counter,
    this.counterText,
    this.counterStyle,
    this.backgroundColor,
    this.readOnlyBackgroundColor,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.filledBorder,
    this.enabledBorder,
    this.borderRadius,
    this.enabled = true,
    this.semanticCounterText,
    this.contentHeight,
    this.constraints,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.selectionColor,
  }) : assert(
         hint == null || hintText == null,
         'Declaring both hint and hintText is not supported.',
       ),
       assert(
         !(helper != null && helperText != null),
         'Declaring both helper and helperText is not supported.',
       ),
       assert(
         !(prefix != null && prefixText != null),
         'Declaring both prefix and prefixText is not supported.',
       ),
       assert(
         !(suffix != null && suffixText != null),
         'Declaring both suffix and suffixText is not supported.',
       ),
       assert(
         !(error != null && errorText != null),
         'Declaring both error and errorText is not supported.',
       ),
       _variantContentPadding = EdgeInsets.zero,
       _suffixGhostIconButtonUniformPadding = null;

  const RadixInputDecoration._withVariant({
    this.textStyle,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.helper,
    this.helperText,
    this.helperStyle,
    this.helperMaxLines,
    this.hintText,
    this.hint,
    this.hintStyle,
    this.hintTextDirection,
    this.hintMaxLines,
    this.hintFadeDuration,
    this.maintainHintSize = true,
    this.error,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.subtextGap,
    this.contentPadding,
    this.contentAlignment = AlignmentDirectional.centerStart,
    EdgeInsets variantContentPadding = EdgeInsets.zero,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.prefixPadding,
    this.prefixToInputGap,
    this.prefix,
    this.prefixText,
    this.prefixStyle,
    this.prefixIconColor,
    this.suffixIcon,
    EdgeInsets? suffixGhostIconButtonUniformPadding,
    this.suffix,
    this.suffixText,
    this.suffixStyle,
    this.suffixIconColor,
    this.suffixIconConstraints,
    this.suffixPadding,
    this.inputToSuffixGap,
    this.affixColor,
    this.counter,
    this.counterText,
    this.counterStyle,
    this.backgroundColor,
    this.readOnlyBackgroundColor,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.filledBorder,
    this.enabledBorder,
    this.borderRadius,
    this.enabled = true,
    this.semanticCounterText,
    this.contentHeight,
    this.constraints,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.selectionColor,
  }) : assert(
         hint == null || hintText == null,
         'Declaring both hint and hintText is not supported.',
       ),
       assert(
         !(helper != null && helperText != null),
         'Declaring both helper and helperText is not supported.',
       ),
       assert(
         !(prefix != null && prefixText != null),
         'Declaring both prefix and prefixText is not supported.',
       ),
       assert(
         !(suffix != null && suffixText != null),
         'Declaring both suffix and suffixText is not supported.',
       ),
       assert(
         !(error != null && errorText != null),
         'Declaring both error and errorText is not supported.',
       ),
       _variantContentPadding = variantContentPadding,
       _suffixGhostIconButtonUniformPadding = suffixGhostIconButtonUniformPadding;

  /// Creates a bundle of the border, icons, and styles used to
  /// decorate a Radix text field, based on the default appearance
  /// of a specific [variant] and [size]. It can then be used to override
  /// the default appearance.
  ///
  /// Flutter does not implement the `text-indent` feature found in CSS,
  /// which means the exact Web behavior cannot be achieved. The value of
  /// [RadixInputDecorationVariantFactor.textIndent] will be added to
  /// [RadixInputDecorationVariantFactor.padding] to form the final
  /// horizontal padding for the input decoration's container.
  /// This will result in a slightly different UI compared to the Web.
  factory RadixInputDecoration.from({
    required RadixInputDecorationVariant variant,
    required RadixInputDecorationVariantFactor size,
    TextStyle? textStyle,
    Widget? icon,
    double? iconSize,
    Color? iconColor,
    Widget? helper,
    String? helperText,
    TextStyle? helperStyle,
    int? helperMaxLines,
    String? hintText,
    Widget? hint,
    TextStyle? hintStyle,
    TextDirection? hintTextDirection,
    int? hintMaxLines,
    Duration? hintFadeDuration,
    bool maintainHintSize = true,
    Widget? error,
    String? errorText,
    TextStyle? errorStyle,
    int? errorMaxLines,
    double? subtextGap,
    double? contentHeight,
    EdgeInsetsGeometry? contentPadding,
    AlignmentDirectional contentAlignment = AlignmentDirectional.centerStart,
    Widget? prefixIcon,
    Widget? prefix,
    String? prefixText,
    BoxConstraints? prefixIconConstraints,
    EdgeInsetsGeometry? prefixPadding,
    double? prefixToInputGap,
    TextStyle? prefixStyle,
    Color? prefixIconColor,
    Widget? suffixIcon,
    RadixButtonStyleFactor? suffixGhostIconButtonStyleFactor,
    Widget? suffix,
    String? suffixText,
    TextStyle? suffixStyle,
    Color? suffixIconColor,
    BoxConstraints? suffixIconConstraints,
    EdgeInsetsGeometry? suffixPadding,
    double? inputToSuffixGap,
    Color? affixColor,
    Widget? counter,
    String? counterText,
    TextStyle? counterStyle,
    Color? fillColor,
    InputBorder? errorBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? disabledBorder,
    InputBorder? filledBorder,
    InputBorder? enabledBorder,
    BorderRadius? borderRadius,
    bool enabled = true,
    String? semanticCounterText,
    BoxConstraints? constraints,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    bool? cursorOpacityAnimates,
    Color? cursorColor,
    Color? cursorErrorColor,
    Color? selectionColor,
  }) {
    TextStyle? effectiveTextStyle = textStyle;
    effectiveTextStyle ??= size.textStyle.copyWith(
      color: enabled ? variant.textColor : variant.disabledTextColor,
    );

    assert(
      suffixIcon is! RadixGhostButton || !suffixIcon.isIconButton ||  suffixGhostIconButtonStyleFactor != null,
    );

    final WidgetStateMap<Color> fillColorMapper = {
      WidgetState.focused   : variant.focusedBackgroundColor,
      WidgetState.disabled  : variant.disabledBackgroundColor,
      WidgetState.any       : variant.backgroundColor,
    };

    final WidgetStateColor efffectiveFillColor = WidgetStateExtension.merge(fillColorMapper, fillColor);

    InputBorder? effectiveEnabledBorder = enabledBorder;
    if (variant.side case final BorderSide side) {
      effectiveEnabledBorder ??= OutlineInputBorder(
        borderSide: side,
        borderRadius: size.borderRadius ?? BorderRadius.zero,
        gapPadding: 0.0,
      );
    }
    if (effectiveEnabledBorder == null && variant.debugVariant == RadixInputVariant.soft) {
      // Prevent the RadixInputDecorationThemeData from applying the enabled border.
      effectiveEnabledBorder = InputBorder.none;
    }

    InputBorder? effectiveFilledBorder = filledBorder;
    if (variant.filledSide case final BorderSide side) {
      effectiveFilledBorder ??= OutlineInputBorder(
        borderSide: side,
        borderRadius: size.borderRadius ?? BorderRadius.zero,
        gapPadding: 0.0,
      );
    }
    if (effectiveFilledBorder == null && variant.debugVariant == RadixInputVariant.soft) {
      // Prevent the RadixInputDecorationThemeData from applying the filled border.
      effectiveFilledBorder = InputBorder.none;
    }

    InputBorder effectiveFocusedBorder;
    if (focusedBorder != null) {
      effectiveFocusedBorder = focusedBorder;
    } else {
      effectiveFocusedBorder = OutlineInputBorder(
        borderSide: variant.focusedSide,
        borderRadius: size.borderRadius ?? BorderRadius.zero,
        gapPadding: 0.0,
      );
    }

    InputBorder? effectiveDisabledBorder = disabledBorder;
    if (variant.disabledSide case final BorderSide side) {
      effectiveDisabledBorder ??= OutlineInputBorder(
        borderSide: side,
        borderRadius: size.borderRadius ?? BorderRadius.zero,
        gapPadding: 0.0,
      );
    }
    if (effectiveDisabledBorder == null && variant.debugVariant == RadixInputVariant.soft) {
      // Prevent the RadixInputDecorationThemeData from applying the enabled border.
      effectiveDisabledBorder = InputBorder.none;
    }

    return RadixInputDecoration._withVariant(
      textStyle: effectiveTextStyle,
      icon: icon,
      iconSize: iconSize,
      iconColor: iconColor,
      helper: helper,
      helperText: helperText,
      helperStyle: helperStyle,
      helperMaxLines: helperMaxLines,
      hintText: hintText,
      hint: hint,
      hintStyle: hintStyle ?? size.textStyle.copyWith(color: variant.hintColor),
      hintTextDirection: hintTextDirection,
      hintMaxLines: hintMaxLines,
      hintFadeDuration: hintFadeDuration,
      maintainHintSize: maintainHintSize,
      error: error,
      errorText: errorText,
      errorStyle: errorStyle,
      errorMaxLines: errorMaxLines,
      subtextGap: subtextGap,
      contentHeight: contentHeight ?? size.height,
      contentPadding: contentPadding ?? size.padding + EdgeInsets.symmetric(horizontal: size.textIndent),
      contentAlignment: contentAlignment,
      variantContentPadding: size.padding,
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIconConstraints,
      prefixPadding: prefixPadding ?? size.slotPadding,
      prefixToInputGap: prefixToInputGap ?? size.gap,
      prefix: prefix,
      prefixText: prefixText,
      prefixStyle: prefixStyle,
      prefixIconColor: prefixIconColor ?? variant.slotColor,
      suffixIcon: suffixIcon,
      suffixGhostIconButtonUniformPadding: suffixGhostIconButtonStyleFactor?.uniformPadding,
      suffix: suffix,
      suffixText: suffixText,
      suffixStyle: suffixStyle,
      suffixIconColor: suffixIconColor ?? variant.slotColor,
      suffixIconConstraints: suffixIconConstraints,
      suffixPadding: suffixPadding ?? size.slotPadding,
      inputToSuffixGap: inputToSuffixGap ?? size.gap,
      affixColor: affixColor ?? variant.slotColor,
      counter: counter,
      counterText: counterText,
      counterStyle: counterStyle,
      backgroundColor: efffectiveFillColor,
      readOnlyBackgroundColor: variant.readOnlyBackgroundColor,
      errorBorder: errorBorder,
      focusedBorder: effectiveFocusedBorder,
      focusedErrorBorder: focusedErrorBorder,
      disabledBorder: effectiveDisabledBorder,
      filledBorder: effectiveFilledBorder,
      enabledBorder: effectiveEnabledBorder,
      borderRadius: borderRadius ?? size.borderRadius,
      enabled: enabled,
      semanticCounterText: semanticCounterText,
      constraints: constraints,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorOpacityAnimates: cursorOpacityAnimates,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      selectionColor: selectionColor ?? variant.selectionColor,
    );
  }

  /// The style to use for the text being edited.
  final TextStyle? textStyle;

  /// An icon to show before the input field and outside of the decoration's
  /// container.
  ///
  /// The size and color of the icon is configured automatically using an
  /// [IconTheme] and therefore does not need to be explicitly given in the
  /// icon widget.
  ///
  /// The trailing edge of the icon is padded by 16dps.
  ///
  /// The decoration's container is the area which is filled if [filled] is
  /// true and bordered per the [border]. It's the area adjacent to
  /// [icon] and above the widgets that contain [helperText],
  /// [errorText], and [counterText].
  ///
  /// See [Icon], [ImageIcon].
  final Widget? icon;

  final double? iconSize;

  /// The color of the [icon].
  ///
  /// If [iconColor] is a [WidgetStateColor], then the effective
  /// color can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  final Color? iconColor;

  /// Optional widget that appears below the [RadixInputDecorator.child].
  ///
  /// If non-null, the [helper] is displayed below the [RadixInputDecorator.child], in
  /// the same location as [error]. If a non-null [error] or [errorText] value is
  /// specified then the [helper] is not shown.
  ///
  /// {@tool dartpad}
  /// This example shows a `RadixTextField` with a [Text.rich] widget
  /// as the [helper]. The widget contains [Text] and [Icon] widgets
  /// with different styles.
  ///
  /// ** See code in examples/api/lib/input_decorator/input_decoration.helper.0.dart **
  /// {@end-tool}
  ///
  /// Only one of [helper] and [helperText] can be specified.
  final Widget? helper;

  /// Text that provides context about the [RadixInputDecorator.child]'s value, such
  /// as how the value will be used.
  ///
  /// If non-null, the text is displayed below the [RadixInputDecorator.child], in
  /// the same location as [errorText]. If a non-null [errorText] value is
  /// specified then the helper text is not shown.
  ///
  /// If a more elaborate helper text is required, consider using [helper] instead.
  ///
  /// Only one of [helper] and [helperText] can be specified.
  final String? helperText;

  /// The style to use for the [helperText].
  ///
  /// If [helperStyle] is a [WidgetStateTextStyle], then the effective
  /// text style can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  final TextStyle? helperStyle;

  /// The maximum number of lines the [helperText] can occupy.
  ///
  /// Defaults to null, which means that soft line breaks in [helperText] are
  /// truncated with an ellipse while hard line breaks are respected.
  /// For example, a [helperText] that overflows the width of the field will be
  /// truncated with an ellipse. However, a [helperText] with explicit linebreak
  /// characters (\n) will display on multiple lines.
  ///
  /// To cause a long [helperText] to wrap, either set [helperMaxLines] or use
  /// [helper] which offers more flexibility. For instance, it can be set to a
  /// [Text] widget with a specific overflow value.
  ///
  /// This value is passed along to the [Text.maxLines] attribute
  /// of the [Text] widget used to display the helper.
  ///
  /// See also:
  ///
  ///  * [errorMaxLines], the equivalent but for the [errorText].
  final int? helperMaxLines;

  /// Text that suggests what sort of input the field accepts.
  ///
  /// Displayed on top of the [RadixInputDecorator.child] (i.e., at the same location
  /// on the screen where text may be entered in the [RadixInputDecorator.child]),
  /// when [RadixInputDecorator.isEmpty] is true and either (a) [labelText] is null
  /// or (b) the input has the focus.
  final String? hintText;

  /// The widget to use in place of the [hintText].
  ///
  /// Either [hintText] or [hint] can be specified, but not both.
  final Widget? hint;

  /// The style to use for the [hintText].
  ///
  /// If [hintStyle] is a [WidgetStateTextStyle], then the effective
  /// text style can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  ///
  /// Also used for the [labelText] when the [labelText] is displayed on
  /// top of the input field (i.e., at the same location on the screen where
  /// text may be entered in the [RadixInputDecorator.child]).
  ///
  /// If null, defaults to a value derived from the base [TextStyle] for the
  /// input field and the current [Theme].
  final TextStyle? hintStyle;

  /// The direction to use for the [hintText].
  ///
  /// If null, defaults to a value derived from [Directionality] for the
  /// input field and the current context.
  final TextDirection? hintTextDirection;

  /// The maximum number of lines the [hintText] can occupy.
  ///
  /// Defaults to the value of [RadixTextField.maxLines] attribute.
  ///
  /// This value is passed along to the [Text.maxLines] attribute
  /// of the [Text] widget used to display the hint text. [TextOverflow.ellipsis] is
  /// used to handle the overflow when it is limited to single line.
  final int? hintMaxLines;

  /// The duration of the [hintText] fade in and fade out animations.
  ///
  /// If null, defaults to [RadixInputDecorationThemeData.hintFadeDuration].
  /// If [RadixInputDecorationThemeData.hintFadeDuration] is null defaults to 20ms.
  final Duration? hintFadeDuration;

  /// Whether the input field's size should always be greater than or equal to
  /// the size of the [hintText], even if the [hintText] is not visible.
  ///
  /// The [RadixInputDecorator] widget ignores [hintText] during layout when
  /// it's not visible, if this flag is set to false.
  ///
  /// Defaults to true.
  final bool maintainHintSize;

  /// Optional widget that appears below the [RadixInputDecorator.child] and the border.
  ///
  /// If non-null, the border's color animates to red and the [helperText] is not shown.
  ///
  /// Only one of [error] and [errorText] can be specified.
  final Widget? error;

  /// Text that appears below the [RadixInputDecorator.child] and the border.
  ///
  /// If non-null, the border's color animates to red and the [helperText] is
  /// not shown.
  ///
  /// In a [TextFormField], this is overridden by the value returned from
  /// [TextFormField.validator], if that is not null.
  ///
  /// If a more elaborate error is required, consider using [error] instead.
  ///
  /// Only one of [error] and [errorText] can be specified.
  final String? errorText;

  /// {@template flutter.material.inputDecoration.errorStyle}
  /// The style to use for the [RadixInputDecoration.errorText].
  ///
  /// If null, defaults of a value derived from the base [TextStyle] for the
  /// input field and the current [Theme].
  ///
  /// By default the color of style will be used by the label of
  /// [RadixInputDecoration] if [RadixInputDecoration.errorText] is not null. See
  /// [RadixInputDecoration.labelStyle] or [RadixInputDecoration.floatingLabelStyle] for
  /// an example of how to replicate this behavior when specifying those
  /// styles.
  /// {@endtemplate}
  final TextStyle? errorStyle;

  /// The maximum number of lines the [errorText] can occupy.
  ///
  /// Defaults to null, which means that soft line breaks in [errorText] are
  /// truncated with an ellipse while hard line breaks are respected.
  /// For example, an [errorText] that overflows the width of the field will be
  /// truncated with an ellipse. However, an [errorText] with explicit linebreak
  /// characters (\n) will display on multiple lines.
  ///
  /// To cause a long [errorText] to wrap, either set [errorMaxLines] or use
  /// [error] which offers more flexibility. For instance, it can be set to a
  /// [Text] widget with a specific overflow value.
  ///
  /// This value is passed along to the [Text.maxLines] attribute
  /// of the [Text] widget used to display the error.
  ///
  /// See also:
  ///
  ///  * [helperMaxLines], the equivalent but for the [helperText].
  final int? errorMaxLines;

  final double? subtextGap;

  /// The height for the input decoration's container.
  final double? contentHeight;

  /// The padding for the input decoration's container.
  ///
  /// {@macro flutter.material.input_decorator.container_description}
  ///
  /// By default the [contentPadding] reflects the type of the [border].
  final EdgeInsetsGeometry? contentPadding;

  /// The alignment of the input fieldwithin the input decoration's container.
  ///
  /// Always defaults to [AlignmentDirectional.centerStart].
  final AlignmentDirectional contentAlignment;

  final EdgeInsets _variantContentPadding;

  /// An icon that appears before the [prefix] or [prefixText] and before
  /// the editable part of the text field, within the decoration's container.
  ///
  /// The size and color of the prefix icon is configured automatically using an
  /// [IconTheme] and therefore does not need to be explicitly given in the
  /// icon widget.
  ///
  /// {@macro flutter.material.input_decorator.container_description}
  ///
  /// The prefix icon alignment can be changed using [Align] with a fixed `widthFactor` and
  /// `heightFactor`.
  ///
  /// {@tool dartpad}
  /// This example shows how the prefix icon alignment can be changed using [Align] with
  /// a fixed `widthFactor` and `heightFactor`.
  ///
  /// ** See code in examples/api/lib/input_decorator/input_decoration.prefix_icon.0.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [Icon] and [ImageIcon], which are typically used to show icons.
  ///  * [prefix] and [prefixText], which are other ways to show content
  ///    before the text field (but after the icon).
  ///  * [suffixIcon], which is the same but on the trailing edge.
  ///  * [Align] A widget that aligns its child within itself and optionally
  ///    sizes itself based on the child's size.
  final Widget? prefixIcon;

  /// The constraints for the prefix icon.
  ///
  /// This can be used to modify the [BoxConstraints] surrounding [prefixIcon].
  final BoxConstraints? prefixIconConstraints;

  /// The padding for the [prefixIcon], [prefix] and [prefixText].
  final EdgeInsetsGeometry? prefixPadding;

  final double? prefixToInputGap;

  /// Optional widget to place on the line before the input.
  ///
  /// This can be used, for example, to add some padding to text that would
  /// otherwise be specified using [prefixText], or to add a custom widget in
  /// front of the input. The widget's baseline is lined up with the input
  /// baseline.
  ///
  /// Only one of [prefix] and [prefixText] can be specified.
  ///
  /// The [prefix] appears after the [prefixIcon], if both are specified.
  ///
  /// See also:
  ///
  ///  * [suffix], the equivalent but on the trailing edge.
  final Widget? prefix;

  /// Optional text prefix to place on the line before the input.
  ///
  /// Uses the [prefixStyle]. Uses [hintStyle] if [prefixStyle] isn't specified.
  /// The prefix text is not returned as part of the user's input.
  ///
  /// If a more elaborate prefix is required, consider using [prefix] instead.
  /// Only one of [prefix] and [prefixText] can be specified.
  ///
  /// The [prefixText] appears after the [prefixIcon], if both are specified.
  ///
  /// See also:
  ///
  ///  * [suffixText], the equivalent but on the trailing edge.
  final String? prefixText;

  /// The style to use for the [prefixText].
  ///
  /// If [prefixStyle] is a [WidgetStateTextStyle], then the effective
  /// text style can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  ///
  /// If null, defaults to the [hintStyle].
  ///
  /// See also:
  ///
  ///  * [suffixStyle], the equivalent but on the trailing edge.
  final TextStyle? prefixStyle;

  /// Optional color of the [prefixIcon]
  ///
  /// Defaults to [iconColor]
  ///
  /// If [prefixIconColor] is a [WidgetStateColor], then the effective
  /// color can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  final Color? prefixIconColor;

  /// An icon that appears after the editable part of the text field and
  /// after the [suffix] or [suffixText], within the decoration's container.
  ///
  /// The size and color of the suffix icon is configured automatically using an
  /// [IconTheme] and therefore does not need to be explicitly given in the
  /// icon widget.
  ///
  /// The suffix icon alignment can be changed using [Align] with a fixed `widthFactor` and
  /// `heightFactor`.
  ///
  /// {@tool dartpad}
  /// This example shows how the suffix icon alignment can be changed using [Align] with
  /// a fixed `widthFactor` and `heightFactor`.
  ///
  /// ** See code in examples/api/lib/input_decorator/input_decoration.suffix_icon.0.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [Icon] and [ImageIcon], which are typically used to show icons.
  ///  * [suffix] and [suffixText], which are other ways to show content
  ///    after the text field (but before the icon).
  ///  * [prefixIcon], which is the same but on the leading edge.
  ///  * [Align] A widget that aligns its child within itself and optionally
  ///    sizes itself based on the child's size.
  final Widget? suffixIcon;

  /// The padding that is only applied to icon ghost buttons.
  final EdgeInsets? _suffixGhostIconButtonUniformPadding;

  /// Optional widget to place on the line after the input.
  ///
  /// This can be used, for example, to add some padding to the text that would
  /// otherwise be specified using [suffixText], or to add a custom widget after
  /// the input. The widget's baseline is lined up with the input baseline.
  ///
  /// Only one of [suffix] and [suffixText] can be specified.
  ///
  /// The [suffix] appears before the [suffixIcon], if both are specified.
  ///
  /// See also:
  ///
  ///  * [prefix], the equivalent but on the leading edge.
  final Widget? suffix;

  /// Optional text suffix to place on the line after the input.
  ///
  /// Uses the [suffixStyle]. Uses [hintStyle] if [suffixStyle] isn't specified.
  /// The suffix text is not returned as part of the user's input.
  ///
  /// If a more elaborate suffix is required, consider using [suffix] instead.
  /// Only one of [suffix] and [suffixText] can be specified.
  ///
  /// The [suffixText] appears before the [suffixIcon], if both are specified.
  ///
  /// See also:
  ///
  ///  * [prefixText], the equivalent but on the leading edge.
  final String? suffixText;

  /// The style to use for the [suffixText].
  ///
  /// If [suffixStyle] is a [WidgetStateTextStyle], then the effective text
  /// style can depend on the [WidgetState.focused] state, i.e. if the
  /// [RadixTextField] is focused or not.
  ///
  /// If null, defaults to the [hintStyle].
  ///
  /// See also:
  ///
  ///  * [prefixStyle], the equivalent but on the leading edge.
  final TextStyle? suffixStyle;

  /// Optional color of the [suffixIcon].
  ///
  /// Defaults to [iconColor]
  ///
  /// If [suffixIconColor] is a [WidgetStateColor], then the effective
  /// color can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  final Color? suffixIconColor;

  /// The constraints for the suffix icon.
  ///
  /// This can be used to modify the [BoxConstraints] surrounding [suffixIcon].
  final BoxConstraints? suffixIconConstraints;

  /// The padding for the [suffixIcon], [suffix] and [suffixText].
  final EdgeInsetsGeometry? suffixPadding;

  final double? inputToSuffixGap;

  /// The Color to use for the [prefix], [prefixText], [suffix] and [suffixText].
  final Color? affixColor;

  /// Optional text to place below the line as a character count.
  ///
  /// Rendered using [counterStyle]. Uses [helperStyle] if [counterStyle] is
  /// null.
  ///
  /// The semantic label can be replaced by providing a [semanticCounterText].
  ///
  /// If null or an empty string and [counter] isn't specified, then nothing
  /// will appear in the counter's location.
  final String? counterText;

  /// Optional custom counter widget to go in the place otherwise occupied by
  /// [counterText]. If this property is non null, then [counterText] is
  /// ignored.
  final Widget? counter;

  /// The style to use for the [counterText].
  ///
  /// If [counterStyle] is a [WidgetStateTextStyle], then the effective
  /// text style can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  ///
  /// If null, defaults to the [helperStyle].
  final TextStyle? counterStyle;

  /// The base fill color of the decoration's container color.
  ///
  /// By default the [backgroundColor] is based on the current
  /// [RadixInputDecorationThemeData.backgroundColor].
  ///
  /// {@macro flutter.material.input_decorator.container_description}
  final Color? backgroundColor;

  /// The base fill color of the decoration's container color
  /// when the input is read-only.
  final Color? readOnlyBackgroundColor;

  /// The border to display when the [RadixInputDecorator] does not have the focus and
  /// is showing an error.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecorator.isFocused], which is true if
  ///    the [RadixInputDecorator]'s child has the focus.
  ///  * [RadixInputDecoration.errorText], the error shown by
  ///    the [RadixInputDecorator], if non-null.
  ///  * [border], for a description of where the [RadixInputDecorator] border appears.
  ///  * [UnderlineInputBorder], an [RadixInputDecorator] border which draws a
  ///    horizontal line at the bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [RadixInputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [focusedBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [focusedErrorBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [disabledBorder], displayed when [RadixInputDecoration.enabled] is false
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [enabledBorder], displayed when [RadixInputDecoration.enabled] is true
  ///    and [RadixInputDecoration.errorText] is null.
  final InputBorder? errorBorder;

  /// The border to display when the [RadixInputDecorator] has the focus and is not
  /// showing an error.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecorator.isFocused], which is true if
  ///    the [RadixInputDecorator]'s child has the focus.
  ///  * [RadixInputDecoration.errorText], the error shown by
  ///    the [RadixInputDecorator], if non-null.
  ///  * [border], for a description of where the [RadixInputDecorator] border appears.
  ///  * [UnderlineInputBorder], an [RadixInputDecorator] border which draws a horizontal
  ///    line at the bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [RadixInputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [errorBorder], displayed when [RadixInputDecorator.isFocused] is false
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [focusedErrorBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [disabledBorder], displayed when [RadixInputDecoration.enabled] is false
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [enabledBorder], displayed when [RadixInputDecoration.enabled] is true
  ///    and [RadixInputDecoration.errorText] is null.
  final InputBorder? focusedBorder;

  /// The border to display when the [RadixInputDecorator] has the focus and is
  /// showing an error.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecorator.isFocused], which is true if
  ///    the [RadixInputDecorator]'s child has the focus.
  ///  * [RadixInputDecoration.errorText], the error shown by
  ///    the [RadixInputDecorator], if non-null.
  ///  * [border], for a description of where the [RadixInputDecorator] border appears.
  ///  * [UnderlineInputBorder], an [RadixInputDecorator] border which draws a horizontal
  ///    line at the bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [RadixInputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [errorBorder], displayed when [RadixInputDecorator.isFocused] is false
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [focusedBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [disabledBorder], displayed when [RadixInputDecoration.enabled] is false
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [enabledBorder], displayed when [RadixInputDecoration.enabled] is true
  ///    and [RadixInputDecoration.errorText] is null.
  final InputBorder? focusedErrorBorder;

  /// The border to display when the [RadixInputDecorator] is disabled and is not
  /// showing an error.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecoration.enabled], which is false if
  ///    the [RadixInputDecorator] is disabled.
  ///  * [RadixInputDecoration.errorText], the error shown by
  ///    the [RadixInputDecorator], if non-null.
  ///  * [border], for a description of where the [RadixInputDecorator] border appears.
  ///  * [UnderlineInputBorder], an [RadixInputDecorator] border which draws a horizontal
  ///    line at the bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [RadixInputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [errorBorder], displayed when [RadixInputDecorator.isFocused] is false
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [focusedBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [focusedErrorBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [enabledBorder], displayed when [RadixInputDecoration.enabled] is true
  ///    and [RadixInputDecoration.errorText] is null.
  final InputBorder? disabledBorder;

  /// The border to display when the [RadixInputDecorator] is enabled, is not
  /// showing an error, and the editable part of the text field is filled.
  final InputBorder? filledBorder;

  /// The border to display when the [RadixInputDecorator] is enabled and is not
  /// showing an error.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecoration.enabled], which is false if
  ///    the [RadixInputDecorator] is disabled.
  ///  * [RadixInputDecoration.errorText], the error shown by
  ///    the [RadixInputDecorator], if non-null.
  ///  * [border], for a description of where the [RadixInputDecorator] border appears.
  ///  * [UnderlineInputBorder], an [RadixInputDecorator] border which draws a horizontal
  ///    line at the bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [RadixInputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [errorBorder], displayed when [RadixInputDecorator.isFocused] is false
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [focusedBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [focusedErrorBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [disabledBorder], displayed when [RadixInputDecoration.enabled] is false
  ///    and [RadixInputDecoration.errorText] is null.
  final InputBorder? enabledBorder;

  final BorderRadius? borderRadius;

  /// This property is true by default.
  final bool enabled;

  /// A semantic label for the [counterText].
  ///
  /// Defaults to null.
  ///
  /// If provided, this replaces the semantic label of the [counterText].
  final String? semanticCounterText;

  /// Defines minimum and maximum sizes for the [RadixInputDecorator].
  ///
  /// Typically the decorator will fill the horizontal space it is given. For
  /// larger screens, it may be useful to have the maximum width clamped to
  /// a given value so it doesn't fill the whole screen. This property
  /// allows you to control how big the decorator will be in its available
  /// space.
  ///
  /// If null, then the ambient [RadixInputDecorationThemeData.constraints] will be used.
  /// If that is null then the decorator will fill the available width with
  /// a default height based on text size.
  final BoxConstraints? constraints;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius? cursorRadius;

  /// {@macro flutter.widgets.editableText.cursorOpacityAnimates}
  final bool? cursorOpacityAnimates;

  /// The color of the cursor.
  ///
  /// The cursor indicates the current location of text insertion point in
  /// the field.
  ///
  /// If this is null it will default to the ambient
  /// [DefaultSelectionStyle.cursorColor]. If that is null, and the
  /// [ThemeData.platform] is [TargetPlatform.iOS] or [TargetPlatform.macOS]
  /// it will use [CupertinoThemeData.primaryColor]. Otherwise it will use
  /// the value of [RadixColorScheme.accent] of [RadixThemeData.colorScheme].
  final Color? cursorColor;

  /// The color of the cursor when the [InputDecorator] is showing an error.
  ///
  /// If this is null it will default to [TextStyle.color] of
  /// [InputDecoration.errorStyle]. If that is null, it will use
  /// [RadixColorScheme.error] of [RadixThemeData.colorScheme].
  final Color? cursorErrorColor;

  /// The background color of selected text.
  final Color? selectionColor;

  /// Creates a copy of this input decoration with the given fields replaced
  /// by the new values.
  RadixInputDecoration copyWith({
    TextStyle? textStyle,
    Widget? icon,
    double? iconSize,
    Color? iconColor,
    Widget? helper,
    String? helperText,
    TextStyle? helperStyle,
    int? helperMaxLines,
    String? hintText,
    Widget? hint,
    TextStyle? hintStyle,
    TextDirection? hintTextDirection,
    Duration? hintFadeDuration,
    int? hintMaxLines,
    bool? maintainHintSize,
    Widget? error,
    String? errorText,
    TextStyle? errorStyle,
    int? errorMaxLines,
    double? subtextGap,
    double? contentHeight,
    EdgeInsetsGeometry? contentPadding,
    AlignmentDirectional? contentAlignment,
    Widget? prefixIcon,
    Widget? prefix,
    String? prefixText,
    BoxConstraints? prefixIconConstraints,
    EdgeInsetsGeometry? prefixPadding,
    double? prefixToInputGap,
    TextStyle? prefixStyle,
    Color? prefixIconColor,
    Widget? suffixIcon,
    Widget? suffix,
    String? suffixText,
    TextStyle? suffixStyle,
    Color? suffixIconColor,
    BoxConstraints? suffixIconConstraints,
    EdgeInsetsGeometry? suffixPadding,
    double? inputToSuffixGap,
    Color? affixColor,
    Widget? counter,
    String? counterText,
    TextStyle? counterStyle,
    bool? filled,
    Color? backgroundColor,
    Color? readOnlyBackgroundColor,
    InputBorder? errorBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? disabledBorder,
    InputBorder? filledBorder,
    InputBorder? enabledBorder,
    BorderRadius? borderRadius,
    bool? enabled,
    String? semanticCounterText,
    BoxConstraints? constraints,
    double? cursorWidth,
    double? cursorHeight,
    Radius? cursorRadius,
    bool? cursorOpacityAnimates,
    Color? cursorColor,
    Color? cursorErrorColor,
    Color? selectionColor,
  }) {
    return RadixInputDecoration._withVariant(
      textStyle: textStyle ?? this.textStyle,
      icon: icon ?? this.icon,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
      helper: helper ?? this.helper,
      helperText: helperText ?? this.helperText,
      helperStyle: helperStyle ?? this.helperStyle,
      helperMaxLines: helperMaxLines ?? this.helperMaxLines,
      hintText: hintText ?? this.hintText,
      hint: hint ?? this.hint,
      hintStyle: hintStyle ?? this.hintStyle,
      hintTextDirection: hintTextDirection ?? this.hintTextDirection,
      hintMaxLines: hintMaxLines ?? this.hintMaxLines,
      hintFadeDuration: hintFadeDuration ?? this.hintFadeDuration,
      maintainHintSize: maintainHintSize ?? this.maintainHintSize,
      error: error ?? this.error,
      errorText: errorText ?? this.errorText,
      errorStyle: errorStyle ?? this.errorStyle,
      errorMaxLines: errorMaxLines ?? this.errorMaxLines,
      subtextGap: subtextGap ?? this.subtextGap,
      contentHeight: contentHeight ?? this.contentHeight,
      contentPadding: contentPadding ?? this.contentPadding,
      contentAlignment: contentAlignment ?? this.contentAlignment,
      variantContentPadding: _variantContentPadding,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      prefix: prefix ?? this.prefix,
      prefixText: prefixText ?? this.prefixText,
      prefixStyle: prefixStyle ?? this.prefixStyle,
      prefixIconColor: prefixIconColor ?? this.prefixIconColor,
      prefixIconConstraints: prefixIconConstraints ?? this.prefixIconConstraints,
      prefixPadding: prefixPadding ?? this.prefixPadding,
      prefixToInputGap: prefixToInputGap ?? this.prefixToInputGap,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      suffixGhostIconButtonUniformPadding: _suffixGhostIconButtonUniformPadding,
      suffix: suffix ?? this.suffix,
      suffixText: suffixText ?? this.suffixText,
      suffixStyle: suffixStyle ?? this.suffixStyle,
      suffixIconColor: suffixIconColor ?? this.suffixIconColor,
      suffixIconConstraints: suffixIconConstraints ?? this.suffixIconConstraints,
      suffixPadding: suffixPadding ?? this.suffixPadding,
      inputToSuffixGap: inputToSuffixGap ?? this.inputToSuffixGap,
      affixColor: affixColor ?? this.affixColor,
      counter: counter ?? this.counter,
      counterText: counterText ?? this.counterText,
      counterStyle: counterStyle ?? this.counterStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      readOnlyBackgroundColor: readOnlyBackgroundColor ?? this.readOnlyBackgroundColor,
      errorBorder: errorBorder ?? this.errorBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      focusedErrorBorder: focusedErrorBorder ?? this.focusedErrorBorder,
      disabledBorder: disabledBorder ?? this.disabledBorder,
      filledBorder: filledBorder ?? this.filledBorder,
      enabledBorder: enabledBorder ?? this.enabledBorder,
      borderRadius: borderRadius ?? this.borderRadius,
      enabled: enabled ?? this.enabled,
      semanticCounterText: semanticCounterText ?? this.semanticCounterText,
      constraints: constraints ?? this.constraints,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorOpacityAnimates: cursorOpacityAnimates ?? this.cursorOpacityAnimates,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorErrorColor: cursorErrorColor ?? this.cursorErrorColor,
      selectionColor: selectionColor ?? this.selectionColor,
    );
  }

  /// Used by widgets like [RadixTextField] and [RadixInputDecorator] to create a new
  /// [RadixInputDecoration] with default values taken from the [theme].
  ///
  /// Only null valued properties from this [RadixInputDecoration] are replaced
  /// by the corresponding values from [theme].
  RadixInputDecoration applyDefaults(RadixInputDecorationThemeData theme) {
    return copyWith(
      textStyle: textStyle ?? theme.textStyle,
      helperStyle: helperStyle ?? theme.helperStyle,
      helperMaxLines: helperMaxLines ?? theme.helperMaxLines,
      hintStyle: hintStyle ?? theme.hintStyle,
      hintFadeDuration: hintFadeDuration ?? theme.hintFadeDuration,
      hintMaxLines: hintMaxLines ?? theme.hintMaxLines,
      errorStyle: errorStyle ?? theme.errorStyle,
      errorMaxLines: errorMaxLines ?? theme.errorMaxLines,
      subtextGap: subtextGap ?? theme.subtextGap,
      contentHeight: contentHeight ?? theme.contentHeight,
      contentPadding: contentPadding ?? theme.contentPadding,
      iconColor: iconColor ?? theme.iconColor,
      prefixStyle: prefixStyle ?? theme.prefixStyle,
      prefixIconColor: prefixIconColor ?? theme.prefixIconColor,
      prefixIconConstraints: prefixIconConstraints ?? theme.prefixIconConstraints,
      prefixPadding: prefixPadding ?? theme.prefixPadding,
      prefixToInputGap: prefixToInputGap ?? theme.prefixToInputGap,
      suffixStyle: suffixStyle ?? theme.suffixStyle,
      suffixIconColor: suffixIconColor ?? theme.suffixIconColor,
      suffixIconConstraints: suffixIconConstraints ?? theme.suffixIconConstraints,
      suffixPadding: suffixPadding ?? theme.suffixPadding,
      inputToSuffixGap: inputToSuffixGap ?? theme.inputToSuffixGap,
      affixColor: affixColor ?? theme.affixColor,
      counterStyle: counterStyle ?? theme.counterStyle,
      backgroundColor: backgroundColor ?? theme.backgroundColor,
      readOnlyBackgroundColor: readOnlyBackgroundColor ?? theme.readOnlyBackgroundColor,
      errorBorder: errorBorder ?? theme.errorBorder,
      focusedBorder: focusedBorder ?? theme.focusedBorder,
      focusedErrorBorder: focusedErrorBorder ?? theme.focusedErrorBorder,
      disabledBorder: disabledBorder ?? theme.disabledBorder,
      filledBorder: filledBorder ?? theme.filledBorder,
      enabledBorder: enabledBorder ?? theme.enabledBorder,
      borderRadius: borderRadius ?? theme.borderRadius,
      constraints: constraints ?? theme.constraints,
      cursorHeight: cursorHeight ?? theme.cursorHeight,
      cursorRadius: cursorRadius ?? theme.cursorRadius,
      cursorOpacityAnimates: cursorOpacityAnimates ?? theme.cursorOpacityAnimates,
      cursorColor: cursorColor ?? theme.cursorColor,
      cursorErrorColor: cursorErrorColor ?? theme.cursorErrorColor,
      selectionColor: selectionColor ?? theme.selectionColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RadixInputDecoration &&
        other.textStyle == textStyle &&
        other.icon == icon &&
        other.iconSize == iconSize &&
        other.iconColor == iconColor &&
        other.helper == helper &&
        other.helperText == helperText &&
        other.helperStyle == helperStyle &&
        other.helperMaxLines == helperMaxLines &&
        other.hintText == hintText &&
        other.hint == hint &&
        other.hintStyle == hintStyle &&
        other.hintTextDirection == hintTextDirection &&
        other.hintMaxLines == hintMaxLines &&
        other.hintFadeDuration == hintFadeDuration &&
        other.maintainHintSize == maintainHintSize &&
        other.error == error &&
        other.errorText == errorText &&
        other.errorStyle == errorStyle &&
        other.errorMaxLines == errorMaxLines &&
        other.subtextGap == subtextGap &&
        other.contentHeight == contentHeight &&
        other.contentPadding == contentPadding &&
        other.contentAlignment == contentAlignment &&
        other._variantContentPadding == _variantContentPadding &&
        other.prefixIcon == prefixIcon &&
        other.prefixIconColor == prefixIconColor &&
        other.prefix == prefix &&
        other.prefixText == prefixText &&
        other.prefixStyle == prefixStyle &&
        other.prefixIconConstraints == prefixIconConstraints &&
        other.prefixPadding == prefixPadding &&
        other.prefixToInputGap == prefixToInputGap &&
        other.suffixIcon == suffixIcon &&
        other._suffixGhostIconButtonUniformPadding == _suffixGhostIconButtonUniformPadding &&
        other.suffixIconColor == suffixIconColor &&
        other.suffix == suffix &&
        other.suffixText == suffixText &&
        other.suffixStyle == suffixStyle &&
        other.suffixIconConstraints == suffixIconConstraints &&
        other.suffixPadding == suffixPadding &&
        other.inputToSuffixGap == inputToSuffixGap &&
        other.affixColor == affixColor &&
        other.counter == counter &&
        other.counterText == counterText &&
        other.counterStyle == counterStyle &&
        other.backgroundColor == backgroundColor &&
        other.readOnlyBackgroundColor == readOnlyBackgroundColor &&
        other.errorBorder == errorBorder &&
        other.focusedBorder == focusedBorder &&
        other.focusedErrorBorder == focusedErrorBorder &&
        other.disabledBorder == disabledBorder &&
        other.filledBorder == filledBorder &&
        other.enabledBorder == enabledBorder &&
        other.borderRadius == borderRadius &&
        other.enabled == enabled &&
        other.semanticCounterText == semanticCounterText &&
        other.constraints == constraints &&
        other.cursorWidth == cursorWidth &&
        other.cursorHeight == cursorHeight &&
        other.cursorRadius == cursorRadius &&
        other.cursorOpacityAnimates == cursorOpacityAnimates &&
        other.cursorColor == cursorColor &&
        other.cursorErrorColor == cursorErrorColor &&
        other.selectionColor == selectionColor;
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      textStyle,
      icon,
      iconSize,
      iconColor,
      helper,
      helperText,
      helperStyle,
      helperMaxLines,
      hintText,
      hint,
      hintStyle,
      hintTextDirection,
      hintMaxLines,
      hintFadeDuration,
      maintainHintSize,
      error,
      errorText,
      errorStyle,
      errorMaxLines,
      subtextGap,
      contentHeight,
      contentPadding,
      contentAlignment,
      _variantContentPadding,
      backgroundColor,
      readOnlyBackgroundColor,
      prefixIcon,
      prefixIconColor,
      prefix,
      prefixText,
      prefixStyle,
      prefixIconConstraints,
      prefixPadding,
      prefixToInputGap,
      suffixIcon,
      _suffixGhostIconButtonUniformPadding,
      suffixIconColor,
      suffix,
      suffixText,
      suffixStyle,
      suffixIconConstraints,
      suffixPadding,
      inputToSuffixGap,
      affixColor,
      counter,
      counterText,
      counterStyle,
      errorBorder,
      focusedBorder,
      focusedErrorBorder,
      disabledBorder,
      filledBorder,
      enabledBorder,
      borderRadius,
      enabled,
      semanticCounterText,
      constraints,
      cursorWidth,
      cursorHeight,
      cursorRadius,
      cursorOpacityAnimates,
      cursorColor,
      cursorErrorColor,
      selectionColor,
    ];
    return Object.hashAll(values);
  }

  @override
  String toString() {
    final List<String> description = <String>[
      if (textStyle != null) 'textStyle: $textStyle',
      if (icon != null) 'icon: $icon',
      if (iconSize != null) 'iconSize: $iconSize',
      if (iconColor != null) 'iconColor: $iconColor',
      if (helper != null) 'helper: "$helper"',
      if (helperText != null) 'helperText: "$helperText"',
      if (helperMaxLines != null) 'helperMaxLines: "$helperMaxLines"',
      if (hintText != null) 'hintText: "$hintText"',
      if (hint != null) 'hint: $hint',
      if (hintStyle != null) 'hintStyle: $hintStyle',
      if (hintTextDirection != null) 'hintTextDirection: $hintTextDirection',
      if (hintMaxLines != null) 'hintMaxLines: "$hintMaxLines"',
      if (hintFadeDuration != null) 'hintFadeDuration: "$hintFadeDuration"',
      if (!maintainHintSize) 'maintainHintSize: false',
      if (error != null) 'error: "$error"',
      if (errorText != null) 'errorText: "$errorText"',
      if (errorStyle != null) 'errorStyle: "$errorStyle"',
      if (errorMaxLines != null) 'errorMaxLines: "$errorMaxLines"',
      if (subtextGap != null) 'subtextGap: "$subtextGap"',
      if (contentHeight != null) 'contentHeight: $contentHeight',
      if (contentPadding != null) 'contentPadding: $contentPadding',
      'contentAlignment: $contentAlignment',
      if (prefixIcon != null) 'prefixIcon: $prefixIcon',
      if (prefixIconColor != null) 'prefixIconColor: $prefixIconColor',
      if (prefix != null) 'prefix: $prefix',
      if (prefixText != null) 'prefixText: $prefixText',
      if (prefixStyle != null) 'prefixStyle: $prefixStyle',
      if (prefixIconConstraints != null) 'prefixIconConstraints: $prefixIconConstraints',
      if (prefixPadding != null) 'prefixPadding: $prefixPadding',
      if (prefixToInputGap != null) 'prefixToInputGap: $prefixToInputGap',
      if (suffixIcon != null) 'suffixIcon: $suffixIcon',
      if (suffixIconColor != null) 'suffixIconColor: $suffixIconColor',
      if (suffix != null) 'suffix: $suffix',
      if (suffixText != null) 'suffixText: $suffixText',
      if (suffixStyle != null) 'suffixStyle: $suffixStyle',
      if (suffixIconConstraints != null) 'suffixIconConstraints: $suffixIconConstraints',
      if (suffixPadding != null) 'suffixPadding: $suffixPadding',
      if (inputToSuffixGap != null) 'inputToSuffixGap: $inputToSuffixGap',
      if (affixColor != null) 'affixColor: $affixColor',
      if (counter != null) 'counter: $counter',
      if (counterText != null) 'counterText: $counterText',
      if (counterStyle != null) 'counterStyle: $counterStyle',
      if (backgroundColor != null) 'backgroundColor: $backgroundColor',
      if (readOnlyBackgroundColor != null) 'readOnlyBackgroundColor: $readOnlyBackgroundColor',
      if (errorBorder != null) 'errorBorder: $errorBorder',
      if (focusedBorder != null) 'focusedBorder: $focusedBorder',
      if (focusedErrorBorder != null) 'focusedErrorBorder: $focusedErrorBorder',
      if (disabledBorder != null) 'disabledBorder: $disabledBorder',
      if (filledBorder != null) 'filledBorder: $filledBorder',
      if (enabledBorder != null) 'enabledBorder: $enabledBorder',
      if (borderRadius != null) 'borderRadius: $borderRadius',
      if (!enabled) 'enabled: false',
      if (semanticCounterText != null) 'semanticCounterText: $semanticCounterText',
      if (constraints != null) 'constraints: $constraints',
      'cursorWidth: $cursorWidth',
      if (cursorHeight != null) 'cursorHeight: $cursorHeight',
      if (cursorRadius != null) 'cursorRadius: $cursorRadius',
      if (cursorOpacityAnimates != null) 'cursorOpacityAnimates: $cursorOpacityAnimates',
      if (cursorColor != null) 'cursorColor: $cursorColor',
      if (cursorErrorColor != null) 'cursorErrorColor: $cursorErrorColor',
      if (selectionColor != null) 'selectionColor: $selectionColor',
    ];
    return 'RadixInputDecoration(${description.join(', ')})';
  }
}

/// Defines the default appearance of [RadixInputDecorator]s.
///
/// See also:
///
///  * [RadixInputDecorationThemeData], which describes the actual configuration of an
///    input decoration theme.
///  * [ThemeData.inputDecorationTheme], which specifies an input decoration theme as
///    part of the overall Material theme.
class RadixInputDecorationTheme extends InheritedTheme with Diagnosticable {
  /// Creates a [RadixInputDecorationTheme] that controls visual parameters for
  /// descendant [RadixInputDecorator]s.
  const RadixInputDecorationTheme({
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
    final RadixInputDecorationTheme? inputDecorationTheme = context
        .dependOnInheritedWidgetOfExactType<RadixInputDecorationTheme>();
    final RadixInputDecorationThemeData? theme = inputDecorationTheme?.data;
    return theme;
  }

  /// The [RadixThemeData.inputDecorationTheme] property of the ambient [RadixTheme].
  ///
  /// Equivalent to `RadixTheme.of(context).inputDecorationTheme`.
  static RadixInputDecorationThemeData globalOf(BuildContext context) => RadixTheme.of(context).inputDecorationTheme;

  /// The [RadixThemeExtension.inputDecorationTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.fromTheme(context).inputDecorationTheme`.
  static RadixInputDecorationThemeData fromTheme(BuildContext context) => RadixTheme.fromTheme(context).inputDecorationTheme;

  /// The [RadixThemeExtension.inputDecorationTheme] of the ambient [Theme].
  ///
  /// Equivalent to `RadixTheme.extensionFrom(themeData).inputDecorationTheme`.
  static RadixInputDecorationThemeData extensionFrom(ThemeData themeData) => RadixTheme.extensionFrom(themeData).inputDecorationTheme;

  @override
  bool updateShouldNotify(RadixInputDecorationTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return RadixInputDecorationTheme(data: data, child: child);
  }
}

/// Defines the default appearance of [RadixInputDecorator]s.
///
/// Descendant widgets obtain the current theme's [RadixInputDecorationThemeData] using
/// [RadixInputDecorationTheme.fromTheme]. When a widget uses [RadixInputDecorationTheme.fromTheme], it is
/// automatically rebuilt if the theme later changes.
///
/// The [RadixInputDecoration.applyDefaults] method is used to combine an input
/// decoration theme with an [RadixInputDecoration] object.
///
/// ## Limitation
///
/// Flutter does not implement the `text-indent` feature found in CSS,
/// which means the exact Web behavior cannot be achieved:
/// (i.e., achieving the effect of padding-left without cutting off long 
/// values when the cursor is at the end).
@immutable
class RadixInputDecorationThemeData with Diagnosticable {
  /// Creates a [RadixInputDecorationThemeData] that can be used to override default
  /// properties in a [RadixInputDecorationTheme] widget.
  const RadixInputDecorationThemeData({
    required this.textStyle,
    this.helperStyle,
    this.helperMaxLines,
    required this.hintStyle,
    this.hintFadeDuration,
    this.hintMaxLines,
    this.errorStyle,
    this.errorMaxLines,
    this.subtextGap,
    this.contentHeight,
    this.contentPadding,
    this.iconColor,
    this.prefixStyle,
    this.prefixIconColor,
    this.prefixIconConstraints,
    this.prefixPadding,
    this.prefixToInputGap,
    this.suffixStyle,
    this.suffixIconColor,
    this.suffixIconConstraints,
    this.suffixPadding,
    this.inputToSuffixGap,
    this.affixColor,
    this.counterStyle,
    this.backgroundColor,
    this.readOnlyBackgroundColor,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.filledBorder,
    this.enabledBorder,
    this.borderRadius,
    this.constraints,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.selectionColor,
  }) : _variantContentPadding = EdgeInsets.zero;

  const RadixInputDecorationThemeData._withVariant({
    required this.textStyle,
    this.helperStyle,
    this.helperMaxLines,
    required this.hintStyle,
    this.hintFadeDuration,
    this.hintMaxLines,
    this.errorStyle,
    this.errorMaxLines,
    this.subtextGap,
    this.contentHeight,
    this.contentPadding,
    EdgeInsets variantContentPadding = EdgeInsets.zero,
    this.iconColor,
    this.prefixStyle,
    this.prefixIconColor,
    this.prefixIconConstraints,
    this.prefixPadding,
    this.prefixToInputGap,
    this.suffixStyle,
    this.suffixIconColor,
    this.suffixIconConstraints,
    this.suffixPadding,
    this.inputToSuffixGap,
    this.affixColor,
    this.counterStyle,
    this.backgroundColor,
    this.readOnlyBackgroundColor,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.filledBorder,
    this.enabledBorder,
    this.borderRadius,
    this.constraints,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.selectionColor,
  }) : _variantContentPadding = variantContentPadding;

  /// Creates a [RadixInputDecorationThemeData] based on the default appearance
  /// of a specific [variant] and [size], which can then be used to override 
  /// default properties in a [RadixInputDecorationTheme] widget.
  ///
  /// Flutter does not implement the `text-indent` feature found in CSS,
  /// which means the exact Web behavior cannot be achieved. The value of
  /// [RadixInputDecorationVariantFactor.textIndent] will be added to
  /// [RadixInputDecorationVariantFactor.padding] to form the final
  /// horizontal padding for the input decoration's container.
  /// This will result in a slightly different UI compared to the Web.
  factory RadixInputDecorationThemeData.from({
    required RadixInputDecorationVariant variant,
    required RadixInputDecorationVariantFactor size,
    TextStyle? textStyle,
    TextStyle? helperStyle,
    int? helperMaxLines,
    String? hintText,
    TextStyle? hintStyle,
    Duration? hintFadeDuration,
    int? hintMaxLines,
    TextStyle? errorStyle,
    int? errorMaxLines,
    double? subtextGap,
    double? contentHeight,
    EdgeInsetsGeometry? contentPadding,
    Color? iconColor,
    BoxConstraints? prefixIconConstraints,
    EdgeInsetsGeometry? prefixPadding,
    double? prefixToInputGap,
    TextStyle? prefixStyle,
    Color? prefixIconColor,
    TextStyle? suffixStyle,
    Color? suffixIconColor,
    BoxConstraints? suffixIconConstraints,
    EdgeInsetsGeometry? suffixPadding,
    double? inputToSuffixGap,
    Color? affixColor,
    TextStyle? counterStyle,
    Color? fillColor,
    InputBorder? errorBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? disabledBorder,
    InputBorder? filledBorder,
    InputBorder? enabledBorder,
    BorderRadius? borderRadius,
    BoxConstraints? constraints,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    bool? cursorOpacityAnimates,
    Color? cursorColor,
    Color? cursorErrorColor,
    Color? selectionColor,
  }) {
    TextStyle? effectiveTextStyle = textStyle;
    effectiveTextStyle ??= size.textStyle.copyWith(
      color: variant.textColor,
    );

    final WidgetStateMap<Color> fillColorMapper = {
      WidgetState.focused     : variant.focusedBackgroundColor,
      WidgetState.disabled    : variant.disabledBackgroundColor,
      WidgetState.any         : variant.backgroundColor,
    };

    final WidgetStateColor efffectiveFillColor = WidgetStateExtension.merge(fillColorMapper, fillColor);

    InputBorder? effectiveEnabledBorder = enabledBorder;
    if (variant.side case final BorderSide side) {
      effectiveEnabledBorder ??= OutlineInputBorder(
        borderSide: side,
        borderRadius: size.borderRadius ?? BorderRadius.zero,
        gapPadding: 0.0,
      );
    }

    InputBorder? effectiveFilledBorder = filledBorder;
    if (variant.filledSide case final BorderSide side) {
      effectiveFilledBorder ??= OutlineInputBorder(
        borderSide: side,
        borderRadius: size.borderRadius ?? BorderRadius.zero,
        gapPadding: 0.0,
      );
    }

    InputBorder? effectiveFocusedBorder = focusedBorder;
    if (variant.focusedSide case final BorderSide side) {
      effectiveFocusedBorder ??= OutlineInputBorder(
        borderSide: side,
        borderRadius: size.borderRadius ?? BorderRadius.zero,
        gapPadding: 0.0,
      );
    }

    InputBorder? effectiveDisabledBorder = disabledBorder;
    if (variant.disabledSide case final BorderSide side) {
      effectiveDisabledBorder ??= OutlineInputBorder(
        borderSide: side,
        borderRadius: size.borderRadius ?? BorderRadius.zero,
        gapPadding: 0.0,
      );
    }

    return RadixInputDecorationThemeData._withVariant(
      textStyle: effectiveTextStyle,
      iconColor: iconColor,
      helperStyle: helperStyle,
      helperMaxLines: helperMaxLines,
      hintStyle: hintStyle ?? size.textStyle.copyWith(color: variant.hintColor),
      hintMaxLines: hintMaxLines,
      hintFadeDuration: hintFadeDuration,
      errorStyle: errorStyle,
      errorMaxLines: errorMaxLines,
      subtextGap: subtextGap,
      contentHeight: contentHeight ?? size.height,
      contentPadding: contentPadding ?? size.padding + EdgeInsets.symmetric(horizontal: size.textIndent),
      variantContentPadding: size.padding,
      prefixIconConstraints: prefixIconConstraints,
      prefixPadding: prefixPadding ?? size.slotPadding,
      prefixToInputGap: prefixToInputGap ?? size.gap,
      prefixStyle: prefixStyle,
      prefixIconColor: prefixIconColor ?? variant.slotColor,
      suffixStyle: suffixStyle,
      suffixIconColor: suffixIconColor ?? variant.slotColor,
      suffixIconConstraints: suffixIconConstraints,
      suffixPadding: suffixPadding ?? size.slotPadding,
      inputToSuffixGap: inputToSuffixGap ?? size.gap,
      affixColor: affixColor ?? variant.slotColor,
      counterStyle: counterStyle,
      backgroundColor: efffectiveFillColor,
      readOnlyBackgroundColor: variant.readOnlyBackgroundColor,
      errorBorder: errorBorder,
      focusedBorder: effectiveFocusedBorder,
      focusedErrorBorder: focusedErrorBorder,
      disabledBorder: effectiveDisabledBorder,
      filledBorder: effectiveFilledBorder,
      enabledBorder: effectiveEnabledBorder,
      borderRadius: borderRadius ?? size.borderRadius,
      constraints: constraints,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorOpacityAnimates: cursorOpacityAnimates,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      selectionColor: selectionColor ?? variant.selectionColor,
    );
  }

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [RadixInputDecoration].
  final TextStyle textStyle;

  /// The style to use for [RadixInputDecoration.helperText].
  ///
  /// If [helperStyle] is a [WidgetStateTextStyle], then the effective
  /// text style can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  final TextStyle? helperStyle;

  /// The maximum number of lines the [RadixInputDecoration.helperText] can occupy.
  ///
  /// Defaults to null, which means that the [RadixInputDecoration.helperText] will
  /// be limited to a single line with [TextOverflow.ellipsis].
  ///
  /// This value is passed along to the [Text.maxLines] attribute
  /// of the [Text] widget used to display the helper.
  ///
  /// See also:
  ///
  ///  * [errorMaxLines], the equivalent but for the [RadixInputDecoration.errorText].
  final int? helperMaxLines;

  /// The style to use for the [RadixInputDecoration.hintText].
  ///
  /// If [hintStyle] is a [WidgetStateTextStyle], then the effective
  /// text style can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  ///
  /// Also used for the [RadixInputDecoration.labelText] when the
  /// [RadixInputDecoration.labelText] is displayed on top of the input field (i.e.,
  /// at the same location on the screen where text may be entered in the input
  /// field).
  ///
  /// If null, defaults to a value derived from the base [TextStyle] for the
  /// input field and the current [Theme].
  final TextStyle hintStyle;

  /// The duration of the [RadixInputDecoration.hintText] fade in and fade out animations.
  final Duration? hintFadeDuration;

  /// The maximum number of lines the [RadixInputDecoration.hintText] can occupy.
  ///
  /// Defaults to null, which means that the [RadixInputDecoration.hintText] will
  /// be limited to a single line with [TextOverflow.ellipsis].
  ///
  /// This value is passed along to the [Text.maxLines] attribute
  /// of the [Text] widget used to display the hint text.
  final int? hintMaxLines;

  /// {@macro flutter.material.inputDecoration.errorStyle}
  final TextStyle? errorStyle;

  /// The maximum number of lines the [RadixInputDecoration.errorText] can occupy.
  ///
  /// Defaults to null, which means that the [RadixInputDecoration.errorText] will be
  /// limited to a single line with [TextOverflow.ellipsis].
  ///
  /// This value is passed along to the [Text.maxLines] attribute
  /// of the [Text] widget used to display the error.
  ///
  /// See also:
  ///
  ///  * [helperMaxLines], the equivalent but for the [RadixInputDecoration.helperText].
  final int? errorMaxLines;

  final double? subtextGap;

  /// The height for the input decoration's container.
  final double? contentHeight;

  /// The padding for the input decoration's container.
  ///
  /// The decoration's container is the area which is filled with
  /// [RadixInputDecoration.backgroundColor] and bordered per the [border].
  /// It's the area adjacent to [RadixInputDecoration.icon] and above the
  /// [RadixInputDecoration.icon] and above the widgets that contain
  /// [RadixInputDecoration.helperText], [RadixInputDecoration.errorText], and
  /// [RadixInputDecoration.counterText].
  ///
  /// By default the [contentPadding] reflects the type of the [border].
  final EdgeInsetsGeometry? contentPadding;

  final EdgeInsets _variantContentPadding;

  /// The Color to use for the [RadixInputDecoration.icon].
  ///
  /// If [iconColor] is a [WidgetStateColor], then the effective
  /// color can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  final Color? iconColor;

  /// The style to use for the [RadixInputDecoration.prefixText].
  ///
  /// If [prefixStyle] is a [WidgetStateTextStyle], then the effective
  /// text style can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  ///
  /// If null, defaults to the [hintStyle].
  final TextStyle? prefixStyle;

  /// The Color to use for the [RadixInputDecoration.prefixIcon].
  ///
  /// If [prefixIconColor] is a [WidgetStateColor], then the effective
  /// color can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  final Color? prefixIconColor;

  /// The constraints to use for [RadixInputDecoration.prefixIconConstraints].
  ///
  /// This can be used to modify the [BoxConstraints] surrounding
  /// [RadixInputDecoration.prefixIcon].
  ///
  /// This property is particularly useful for getting the decoration's height
  /// less than the minimum tappable height (which is 48px when the visual
  /// density is set to [VisualDensity.standard]). This can be achieved by
  /// setting [isDense] to true and setting the constraints' minimum height
  /// and width to a value lower than the minimum tappable size.
  ///
  /// If null, [BoxConstraints] with a minimum width and height of 48px is
  /// used.
  final BoxConstraints? prefixIconConstraints;

  /// The padding for the [prefixIcon], [prefix] and [prefixText].
  final EdgeInsetsGeometry? prefixPadding;

  final double? prefixToInputGap;

  /// The style to use for the [RadixInputDecoration.suffixText].
  ///
  /// If [suffixStyle] is a [WidgetStateTextStyle], then the effective
  /// color can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  ///
  /// If null, defaults to the [hintStyle].
  final TextStyle? suffixStyle;

  /// The Color to use for the [RadixInputDecoration.suffixIcon].
  ///
  /// If [suffixIconColor] is a [WidgetStateColor], then the effective
  /// color can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  final Color? suffixIconColor;

  /// The constraints to use for [RadixInputDecoration.suffixIconConstraints].
  ///
  /// This can be used to modify the [BoxConstraints] surrounding
  /// [RadixInputDecoration.suffixIcon].
  final BoxConstraints? suffixIconConstraints;

  /// The padding for the [suffixIcon], [suffix] and [suffixText].
  final EdgeInsetsGeometry? suffixPadding;

  final double? inputToSuffixGap;

  /// The Color to use for the [RadixInputDecoration.prefix],
  /// [RadixInputDecoration.prefixText], [RadixInputDecoration.suffix]
  /// and [RadixInputDecoration.suffixText].
  final Color? affixColor;

  /// The style to use for the [RadixInputDecoration.counterText].
  ///
  /// If [counterStyle] is a [WidgetStateTextStyle], then the effective
  /// text style can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  ///
  /// If null, defaults to the [helperStyle].
  final TextStyle? counterStyle;

  /// The color to fill the decoration's container with.
  ///
  /// If [backgroundColor] is a [WidgetStateColor], then the effective
  /// color can depend on the [WidgetState.focused] state, i.e.
  /// if the [RadixTextField] is focused or not.
  ///
  /// The decoration's container is the area, defined by the border's
  /// [InputBorder.getOuterPath], which is filled and bordered per the [border].
  final Color? backgroundColor;

  final Color? readOnlyBackgroundColor;

  /// The border to display when the [RadixInputDecorator] does not have the focus and
  /// is showing an error.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecorator.isFocused], which is true if
  ///    the [RadixInputDecorator]'s child has the focus.
  ///  * [RadixInputDecoration.errorText], the error shown by
  ///    the [RadixInputDecorator], if non-null.
  ///  * [border], for a description of where the [RadixInputDecorator] border appears.
  ///  * [UnderlineInputBorder], an [RadixInputDecorator] border which draws a horizontal
  ///    line at the bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [RadixInputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [focusedBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [focusedErrorBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [disabledBorder], displayed when [RadixInputDecoration.enabled] is false
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [enabledBorder], displayed when [RadixInputDecoration.enabled] is true
  ///    and [RadixInputDecoration.errorText] is null.
  final InputBorder? errorBorder;

  /// The border to display when the [RadixInputDecorator] has the focus and is not
  /// showing an error.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecorator.isFocused], which is true if
  ///    the [RadixInputDecorator]'s child has the focus.
  ///  * [RadixInputDecoration.errorText], the error shown by
  ///    the [RadixInputDecorator], if non-null.
  ///  * [border], for a description of where the [RadixInputDecorator] border appears.
  ///  * [UnderlineInputBorder], an [RadixInputDecorator] border which draws a horizontal
  ///    line at the bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [RadixInputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [errorBorder], displayed when [RadixInputDecorator.isFocused] is false
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [focusedErrorBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [disabledBorder], displayed when [RadixInputDecoration.enabled] is false
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [enabledBorder], displayed when [RadixInputDecoration.enabled] is true
  ///    and [RadixInputDecoration.errorText] is null.
  final InputBorder? focusedBorder;

  /// The border to display when the [RadixInputDecorator] has the focus and is
  /// showing an error.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecorator.isFocused], which is true if
  ///    the [RadixInputDecorator]'s child has the focus.
  ///  * [RadixInputDecoration.errorText], the error shown by
  ///    the [RadixInputDecorator], if non-null.
  ///  * [border], for a description of where the [RadixInputDecorator] border appears.
  ///  * [UnderlineInputBorder], an [RadixInputDecorator] border which draws a horizontal
  ///    line at the bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [RadixInputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [errorBorder], displayed when [RadixInputDecorator.isFocused] is false
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [focusedBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [disabledBorder], displayed when [RadixInputDecoration.enabled] is false
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [enabledBorder], displayed when [RadixInputDecoration.enabled] is true
  ///    and [RadixInputDecoration.errorText] is null.
  final InputBorder? focusedErrorBorder;

  /// The border to display when the [RadixInputDecorator] is disabled and is not
  /// showing an error.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecoration.enabled], which is false if
  ///    the [RadixInputDecorator] is disabled.
  ///  * [RadixInputDecoration.errorText], the error shown by
  ///    the [RadixInputDecorator], if non-null.
  ///  * [border], for a description of where the [RadixInputDecorator] border appears.
  ///  * [UnderlineInputBorder], an [RadixInputDecorator] border which draws a horizontal
  ///    line at the bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [RadixInputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [errorBorder], displayed when [RadixInputDecorator.isFocused] is false
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [focusedBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [focusedErrorBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [enabledBorder], displayed when [RadixInputDecoration.enabled] is true
  ///    and [RadixInputDecoration.errorText] is null.
  final InputBorder? disabledBorder;

  /// The border to display when the [RadixInputDecorator] is enabled, is not
  /// showing an error, and the editable part of the text field is filled.
  final InputBorder? filledBorder;

  /// The border to display when the [RadixInputDecorator] is enabled and is not
  /// showing an error.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecoration.enabled], which is false if
  ///    the [RadixInputDecorator] is disabled.
  ///  * [RadixInputDecoration.errorText], the error shown by
  ///    the [RadixInputDecorator], if non-null.
  ///  * [border], for a description of where the [RadixInputDecorator] border appears.
  ///  * [UnderlineInputBorder], an [RadixInputDecorator] border which draws a horizontal
  ///    line at the bottom of the input decorator's container.
  ///  * [OutlineInputBorder], an [RadixInputDecorator] border which draws a
  ///    rounded rectangle around the input decorator's container.
  ///  * [InputBorder.none], which doesn't draw a border.
  ///  * [errorBorder], displayed when [RadixInputDecorator.isFocused] is false
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [focusedBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is null.
  ///  * [focusedErrorBorder], displayed when [RadixInputDecorator.isFocused] is true
  ///    and [RadixInputDecoration.errorText] is non-null.
  ///  * [disabledBorder], displayed when [RadixInputDecoration.enabled] is false
  ///    and [RadixInputDecoration.errorText] is null.
  final InputBorder? enabledBorder;

  final BorderRadius? borderRadius;

  /// Defines minimum and maximum sizes for the [RadixInputDecorator].
  ///
  /// Typically the decorator will fill the horizontal space it is given. For
  /// larger screens, it may be useful to have the maximum width clamped to
  /// a given value so it doesn't fill the whole screen. This property
  /// allows you to control how big the decorator will be in its available
  /// space.
  ///
  /// If null, then the decorator will fill the available width with
  /// a default height based on text size.
  ///
  /// See also:
  ///
  ///  * [RadixInputDecoration.constraints], which can override this setting for a
  ///    given decorator.
  final BoxConstraints? constraints;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius? cursorRadius;

  /// {@macro flutter.widgets.editableText.cursorOpacityAnimates}
  final bool? cursorOpacityAnimates;

  /// The color of the cursor.
  ///
  /// The cursor indicates the current location of text insertion point in
  /// the field.
  ///
  /// If this is null it will default to the ambient
  /// [DefaultSelectionStyle.cursorColor]. If that is null, and the
  /// [ThemeData.platform] is [TargetPlatform.iOS] or [TargetPlatform.macOS]
  /// it will use [CupertinoThemeData.primaryColor]. Otherwise it will use
  /// the value of [RadixColorScheme.accent] of [RadixThemeData.colorScheme].
  final Color? cursorColor;

  /// The color of the cursor when the [InputDecorator] is showing an error.
  ///
  /// If this is null it will default to [TextStyle.color] of
  /// [InputDecoration.errorStyle]. If that is null, it will use
  /// [RadixColorScheme.error] of [RadixThemeData.colorScheme].
  final Color? cursorErrorColor;

  /// The background color of selected text.
  final Color? selectionColor;

  /// Creates a copy of this object but with the given fields replaced with the
  /// new values.
  RadixInputDecorationThemeData copyWith({
    TextStyle? textStyle,
    TextStyle? helperStyle,
    int? helperMaxLines,
    TextStyle? hintStyle,
    Duration? hintFadeDuration,
    int? hintMaxLines,
    TextStyle? errorStyle,
    int? errorMaxLines,
    double? subtextGap,
    double? contentHeight,
    EdgeInsetsGeometry? contentPadding,
    Color? iconColor,
    TextStyle? prefixStyle,
    Color? prefixIconColor,
    BoxConstraints? prefixIconConstraints,
    EdgeInsetsGeometry? prefixPadding,
    double? prefixToInputGap,
    TextStyle? suffixStyle,
    Color? suffixIconColor,
    BoxConstraints? suffixIconConstraints,
    EdgeInsetsGeometry? suffixPadding,
    double? inputToSuffixGap,
    Color? affixColor,
    TextStyle? counterStyle,
    Color? backgroundColor,
    Color? readOnlyBackgroundColor,
    InputBorder? errorBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? disabledBorder,
    InputBorder? filledBorder,
    InputBorder? enabledBorder,
    BorderRadius? borderRadius,
    BoxConstraints? constraints,
    double? cursorWidth,
    double? cursorHeight,
    Radius? cursorRadius,
    bool? cursorOpacityAnimates,
    Color? cursorColor,
    Color? cursorErrorColor,
    Color? selectionColor,
  }) {
    return RadixInputDecorationThemeData._withVariant(
      textStyle: textStyle ?? this.textStyle,
      helperStyle: helperStyle ?? this.helperStyle,
      helperMaxLines: helperMaxLines ?? this.helperMaxLines,
      hintStyle: hintStyle ?? this.hintStyle,
      hintFadeDuration: hintFadeDuration ?? this.hintFadeDuration,
      hintMaxLines: hintMaxLines ?? this.hintMaxLines,
      errorStyle: errorStyle ?? this.errorStyle,
      errorMaxLines: errorMaxLines ?? this.errorMaxLines,
      subtextGap: subtextGap ?? this.subtextGap,
      contentHeight: contentHeight ?? this.contentHeight,
      contentPadding: contentPadding ?? this.contentPadding,
      variantContentPadding: _variantContentPadding,
      iconColor: iconColor ?? this.iconColor,
      prefixStyle: prefixStyle ?? this.prefixStyle,
      prefixIconColor: prefixIconColor ?? this.prefixIconColor,
      prefixIconConstraints: prefixIconConstraints ?? this.prefixIconConstraints,
      prefixPadding: prefixPadding ?? this.prefixPadding,
      prefixToInputGap: prefixToInputGap ?? this.prefixToInputGap,
      suffixStyle: suffixStyle ?? this.suffixStyle,
      suffixIconColor: suffixIconColor ?? this.suffixIconColor,
      suffixIconConstraints: suffixIconConstraints ?? this.suffixIconConstraints,
      suffixPadding: suffixPadding ?? this.suffixPadding,
      inputToSuffixGap: inputToSuffixGap ?? this.inputToSuffixGap,
      affixColor: affixColor ?? this.affixColor,
      counterStyle: counterStyle ?? this.counterStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      readOnlyBackgroundColor: readOnlyBackgroundColor ?? this.readOnlyBackgroundColor,
      errorBorder: errorBorder ?? this.errorBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      focusedErrorBorder: focusedErrorBorder ?? this.focusedErrorBorder,
      disabledBorder: disabledBorder ?? this.disabledBorder,
      filledBorder: filledBorder ?? this.filledBorder,
      enabledBorder: enabledBorder ?? this.enabledBorder,
      borderRadius: borderRadius ?? this.borderRadius,
      constraints: constraints ?? this.constraints,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorOpacityAnimates: cursorOpacityAnimates ?? this.cursorOpacityAnimates,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorErrorColor: cursorErrorColor ?? this.cursorErrorColor,
      selectionColor: selectionColor ?? this.selectionColor,
    );
  }

  /// Returns a copy of this RadixInputDecorationThemeData where the non-null fields in
  /// the given RadixInputDecorationThemeData override the corresponding nullable fields
  /// in this RadixInputDecorationThemeData.
  ///
  /// The non-nullable fields of RadixInputDecorationThemeData, such as
  /// [hintStyle], [filled] and [cursorWidth] cannot be overridden.
  ///
  /// In other words, the fields of the provided [RadixInputDecorationThemeData]
  /// are used to fill in the unspecified and nullable fields of this
  /// RadixInputDecorationThemeData.
  RadixInputDecorationThemeData merge(RadixInputDecorationThemeData? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      helperStyle: helperStyle ?? other.helperStyle,
      helperMaxLines: helperMaxLines ?? other.helperMaxLines,
      hintFadeDuration: hintFadeDuration ?? other.hintFadeDuration,
      hintMaxLines: hintMaxLines ?? other.hintMaxLines,
      errorStyle: errorStyle ?? other.errorStyle,
      errorMaxLines: errorMaxLines ?? other.errorMaxLines,
      subtextGap: subtextGap ?? other.subtextGap,
      contentHeight: contentHeight ?? other.contentHeight,
      contentPadding: contentPadding ?? other.contentPadding,
      iconColor: iconColor ?? other.iconColor,
      prefixStyle: prefixStyle ?? other.prefixStyle,
      prefixIconColor: prefixIconColor ?? other.prefixIconColor,
      prefixIconConstraints: prefixIconConstraints ?? other.prefixIconConstraints,
      prefixPadding: prefixPadding ?? other.prefixPadding,
      prefixToInputGap: prefixToInputGap ?? other.prefixToInputGap,
      suffixStyle: suffixStyle ?? other.suffixStyle,
      suffixIconColor: suffixIconColor ?? other.suffixIconColor,
      suffixIconConstraints: suffixIconConstraints ?? other.suffixIconConstraints,
      suffixPadding: suffixPadding ?? other.suffixPadding,
      inputToSuffixGap: inputToSuffixGap ?? other.inputToSuffixGap,
      affixColor: affixColor ?? other.affixColor,
      counterStyle: counterStyle ?? other.counterStyle,
      backgroundColor: backgroundColor ?? other.backgroundColor,
      readOnlyBackgroundColor: readOnlyBackgroundColor ?? other.readOnlyBackgroundColor,
      errorBorder: errorBorder ?? other.errorBorder,
      focusedBorder: focusedBorder ?? other.focusedBorder,
      focusedErrorBorder: focusedErrorBorder ?? other.focusedErrorBorder,
      disabledBorder: disabledBorder ?? other.disabledBorder,
      filledBorder: filledBorder ?? other.filledBorder,
      enabledBorder: enabledBorder ?? other.enabledBorder,
      borderRadius: borderRadius ?? other.borderRadius,
      constraints: constraints ?? other.constraints,
      cursorHeight: cursorHeight ?? other.cursorHeight,
      cursorRadius: cursorRadius ?? other.cursorRadius,
      cursorOpacityAnimates: cursorOpacityAnimates ?? other.cursorOpacityAnimates,
      cursorColor: cursorColor ?? other.cursorColor,
      cursorErrorColor: cursorErrorColor ?? other.cursorErrorColor,
      selectionColor: selectionColor ?? other.selectionColor,
    );
  }

  @override
  int get hashCode => Object.hash(
    textStyle,
    helperStyle,
    helperMaxLines,
    hintStyle,
    hintFadeDuration,
    hintMaxLines,
    errorStyle,
    errorMaxLines,
    subtextGap,
    contentHeight,
    contentPadding,
    _variantContentPadding,
    iconColor,
    prefixStyle,
    prefixIconColor,
    prefixIconConstraints,
    prefixPadding,
    prefixToInputGap,
    suffixStyle,
    Object.hash(
      suffixIconColor,
      suffixIconConstraints,
      suffixPadding,
      inputToSuffixGap,
      affixColor,
      counterStyle,
      backgroundColor,
      readOnlyBackgroundColor,
      errorBorder,
      focusedBorder,
      focusedErrorBorder,
      disabledBorder,
      filledBorder,
      enabledBorder,
      borderRadius,
      constraints,
      cursorWidth,
      cursorHeight,
      cursorRadius,
      Object.hash(
        cursorOpacityAnimates,
        cursorColor,
        cursorErrorColor,
        selectionColor,
      ),
    ),
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RadixInputDecorationThemeData &&
        other.textStyle == textStyle &&
        other.helperStyle == helperStyle &&
        other.helperMaxLines == helperMaxLines &&
        other.hintStyle == hintStyle &&
        other.hintFadeDuration == hintFadeDuration &&
        other.errorStyle == errorStyle &&
        other.errorMaxLines == errorMaxLines &&
        other.subtextGap == subtextGap &&
        other.contentHeight == contentHeight &&
        other.contentPadding == contentPadding &&
        other._variantContentPadding == _variantContentPadding &&
        other.iconColor == iconColor &&
        other.prefixStyle == prefixStyle &&
        other.prefixIconColor == prefixIconColor &&
        other.prefixIconConstraints == prefixIconConstraints &&
        other.prefixPadding == prefixPadding &&
        other.prefixToInputGap == prefixToInputGap &&
        other.suffixStyle == suffixStyle &&
        other.suffixIconColor == suffixIconColor &&
        other.suffixIconConstraints == suffixIconConstraints &&
        other.suffixPadding == suffixPadding &&
        other.inputToSuffixGap == inputToSuffixGap &&
        other.affixColor == affixColor &&
        other.counterStyle == counterStyle &&
        other.backgroundColor == backgroundColor &&
        other.readOnlyBackgroundColor == readOnlyBackgroundColor &&
        other.errorBorder == errorBorder &&
        other.focusedBorder == focusedBorder &&
        other.focusedErrorBorder == focusedErrorBorder &&
        other.disabledBorder == disabledBorder &&
        other.filledBorder == filledBorder &&
        other.enabledBorder == enabledBorder &&
        other.borderRadius == borderRadius &&
        other.hintMaxLines == hintMaxLines &&
        other.constraints == constraints &&
        other.cursorWidth == cursorWidth &&
        other.cursorHeight == cursorHeight &&
        other.cursorRadius == cursorRadius &&
        other.cursorOpacityAnimates == cursorOpacityAnimates &&
        other.cursorColor == cursorColor &&
        other.cursorErrorColor == cursorErrorColor &&
        other.selectionColor == selectionColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    const RadixInputDecorationThemeData defaultTheme = RadixInputDecorationThemeData(
      textStyle: TextStyle(),
      hintStyle: TextStyle(),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'textStyle',
        textStyle,
        defaultValue: defaultTheme.textStyle,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'helperStyle',
        helperStyle,
        defaultValue: defaultTheme.helperStyle,
      ),
    );
    properties.add(
      IntProperty('helperMaxLines', helperMaxLines, defaultValue: defaultTheme.helperMaxLines),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>('hintStyle', hintStyle, defaultValue: defaultTheme.hintStyle),
    );
    properties.add(
      DiagnosticsProperty<Duration>(
        'hintFadeDuration',
        hintFadeDuration,
        defaultValue: defaultTheme.hintFadeDuration,
      ),
    );
    properties.add(
      IntProperty('hintMaxLines', hintMaxLines, defaultValue: defaultTheme.hintMaxLines),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'errorStyle',
        errorStyle,
        defaultValue: defaultTheme.errorStyle,
      ),
    );
    properties.add(
      IntProperty('errorMaxLines', errorMaxLines, defaultValue: defaultTheme.errorMaxLines),
    );
    properties.add(
      DoubleProperty('subtextGap', subtextGap, defaultValue: defaultTheme.subtextGap),
    );
    properties.add(
      DoubleProperty('contentHeight', contentHeight, defaultValue: defaultTheme.contentHeight),
    );
    properties.add(
      DiagnosticsProperty<EdgeInsetsGeometry>(
        'contentPadding',
        contentPadding,
        defaultValue: defaultTheme.contentPadding,
      ),
    );
    properties.add(
      DiagnosticsProperty<Color>('iconColor', iconColor, defaultValue: defaultTheme.iconColor),
    );
    properties.add(
      DiagnosticsProperty<Color>(
        'prefixIconColor',
        prefixIconColor,
        defaultValue: defaultTheme.prefixIconColor,
      ),
    );
    properties.add(
      DiagnosticsProperty<BoxConstraints>(
        'prefixIconConstraints',
        prefixIconConstraints,
        defaultValue: defaultTheme.prefixIconConstraints,
      ),
    );
    properties.add(
      DiagnosticsProperty<EdgeInsetsGeometry>(
        'prefixPadding',
        prefixPadding,
        defaultValue: defaultTheme.prefixPadding,
      ),
    );
    properties.add(
      DoubleProperty(
        'prefixToInputGap',
        prefixToInputGap,
        defaultValue: defaultTheme.prefixToInputGap,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'prefixStyle',
        prefixStyle,
        defaultValue: defaultTheme.prefixStyle,
      ),
    );
    properties.add(
      DiagnosticsProperty<Color>(
        'suffixIconColor',
        suffixIconColor,
        defaultValue: defaultTheme.suffixIconColor,
      ),
    );
    properties.add(
      DiagnosticsProperty<BoxConstraints>(
        'suffixIconConstraints',
        suffixIconConstraints,
        defaultValue: defaultTheme.suffixIconConstraints,
      ),
    );
    properties.add(
      DiagnosticsProperty<EdgeInsetsGeometry>(
        'suffixPadding',
        suffixPadding,
        defaultValue: defaultTheme.suffixPadding,
      ),
    );
    properties.add(
      DoubleProperty(
        'inputToSuffixGap',
        inputToSuffixGap,
        defaultValue: defaultTheme.inputToSuffixGap,
      ),
    );
    properties.add(
      DiagnosticsProperty<Color>('affixColor', affixColor, defaultValue: defaultTheme.affixColor),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'suffixStyle',
        suffixStyle,
        defaultValue: defaultTheme.suffixStyle,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle>(
        'counterStyle',
        counterStyle,
        defaultValue: defaultTheme.counterStyle,
      ),
    );
    properties.add(
      ColorProperty(
        'backgroundColor',
        backgroundColor,
        defaultValue: defaultTheme.backgroundColor,
      ),
    );
    properties.add(
      ColorProperty(
        'readOnlyBackgroundColor',
        readOnlyBackgroundColor,
        defaultValue: defaultTheme.readOnlyBackgroundColor,
      ),
    );
    properties.add(
      DiagnosticsProperty<InputBorder>(
        'errorBorder',
        errorBorder,
        defaultValue: defaultTheme.errorBorder,
      ),
    );
    properties.add(
      DiagnosticsProperty<InputBorder>(
        'focusedBorder',
        focusedBorder,
        defaultValue: defaultTheme.focusedErrorBorder,
      ),
    );
    properties.add(
      DiagnosticsProperty<InputBorder>(
        'focusedErrorBorder',
        focusedErrorBorder,
        defaultValue: defaultTheme.focusedErrorBorder,
      ),
    );
    properties.add(
      DiagnosticsProperty<InputBorder>(
        'disabledBorder',
        disabledBorder,
        defaultValue: defaultTheme.disabledBorder,
      ),
    );
    properties.add(
      DiagnosticsProperty<InputBorder>(
        'filledBorder',
        filledBorder,
        defaultValue: defaultTheme.filledBorder,
      ),
    );
    properties.add(
      DiagnosticsProperty<InputBorder>(
        'enabledBorder',
        enabledBorder,
        defaultValue: defaultTheme.enabledBorder,
      ),
    );
    properties.add(
      DiagnosticsProperty<BorderRadius>(
        'borderRadius',
        borderRadius,
        defaultValue: defaultTheme.borderRadius,
      ),
    );
    properties.add(
      DiagnosticsProperty<BoxConstraints>(
        'constraints',
        constraints,
        defaultValue: defaultTheme.constraints,
      ),
    );
    properties.add(
      DoubleProperty(
        'cursorWidth',
        cursorWidth,
        defaultValue: defaultTheme.cursorWidth,
      ),
    );
    properties.add(
      DoubleProperty(
        'cursorHeight',
        cursorHeight,
        defaultValue: defaultTheme.cursorHeight,
      ),
    );
    properties.add(
      DiagnosticsProperty<Radius>(
        'cursorRadius',
        cursorRadius,
        defaultValue: defaultTheme.cursorRadius,
      ),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'cursorOpacityAnimates',
        cursorOpacityAnimates,
        defaultValue: defaultTheme.cursorOpacityAnimates,
      ),
    );
    properties.add(
      ColorProperty(
        'cursorColor',
        cursorColor,
        defaultValue: defaultTheme.cursorColor,
      ),
    );
    properties.add(
      ColorProperty(
        'cursorErrorColor',
        cursorErrorColor,
        defaultValue: defaultTheme.cursorErrorColor,
      ),
    );
    properties.add(
      ColorProperty(
        'selectionColor',
        selectionColor,
        defaultValue: defaultTheme.selectionColor,
      ),
    );
  }
}
