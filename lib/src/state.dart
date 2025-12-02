import 'package:flutter/widgets.dart';

typedef LerpColor = Color? Function(Color? a, Color? b, double t);

typedef LerpProperty<T> = T Function(T? a, T? b, double t);

extension EffectiveWidgetStateColor on WidgetStateColor {
  /// Linearly interpolate between two [WidgetStateProperty]s.
  static WidgetStateColor lerp(
    WidgetStateColor a,
    WidgetStateColor b,
    double t,
    LerpColor lerpFunction,
  ) {
    return _LerpEffectiveStateColor(a, b, t, lerpFunction);
  }
}

class _LerpEffectiveStateColor extends WidgetStateColor {
  _LerpEffectiveStateColor(this.x, this.y, this.t, this.lerpFunction)
      : super(Color.lerp(x, y, t)!.toARGB32());

  final WidgetStateColor x;
  final WidgetStateColor y;
  final double t;
  final LerpColor lerpFunction;

  @override
  Color resolve(Set<WidgetState> states) {
    final Color resolvedA = x.resolve(states);
    final Color resolvedB = y.resolve(states);
    return lerpFunction(resolvedA, resolvedB, t)!;
  }
}

extension WidgetStateExtension on WidgetState {
  static const WidgetStatesConstraint readOnly = _ReadOnlyWidgetState();

  // TODO: rewrite this after the WidgetState has readOnly
  static WidgetStateColor merge(WidgetStateMap<Color> mapper, Color? color) {
    if (color == null) {
      return WidgetStateColor.fromMap(mapper);
    }

    if (color is WidgetStateColor) {
      final WidgetStateMap<Color> overrideMapper = {};

      for (final state in WidgetState.values) {
        overrideMapper[state] = color.resolve({state});
      }

      return WidgetStateColor.fromMap({
        ...mapper,
        ...overrideMapper,
      });
    }

    return WidgetStateColor.fromMap({
      ...mapper,
      WidgetState.any: color,
    });
  }
}

// A private class, used to create [WidgetStateExtension.readOnly].
@immutable
class _ReadOnlyWidgetState implements WidgetStatesConstraint {
  const _ReadOnlyWidgetState();

  @override
  bool isSatisfiedBy(Set<WidgetState> states) => states.contains(this as WidgetStatesConstraint);

  @override
  String toString() => 'WidgetStateExtension.readOnly';
}
