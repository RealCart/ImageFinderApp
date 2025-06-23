import 'package:flutter/material.dart';

const _shimmerGradient = LinearGradient(
  colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
  stops: [0.1, 0.3, 0.4],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class Shimmer extends StatefulWidget {
  const Shimmer({
    super.key,
    required this.child,
    this.linearGradient = _shimmerGradient,
    this.enabled = true,
  });

  final Widget child;
  final LinearGradient linearGradient;
  final bool enabled;

  static ShimmerState? of(BuildContext context) =>
      context.findAncestorStateOfType<ShimmerState>();

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController.unbounded(vsync: this);
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    if (widget.enabled && mounted && !_isDisposed) {
      _ctrl.repeat(
          min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
    }
  }

  @override
  void didUpdateWidget(covariant Shimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isDisposed) return;

    if (widget.enabled && !_ctrl.isAnimating && mounted) {
      _ctrl.repeat(
          min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
    } else if (!widget.enabled && _ctrl.isAnimating) {
      _ctrl.stop(canceled: false);
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _ctrl.stop(canceled: true);
    _ctrl.dispose();
    super.dispose();
  }

  LinearGradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform: _SlidingGradientTransform(slide: _ctrl.value),
      );

  bool get _hasSize {
    if (_isDisposed || !mounted) return false;
    try {
      final renderObject = context.findRenderObject() as RenderBox?;
      return renderObject?.hasSize ?? false;
    } catch (e) {
      return false;
    }
  }

  Size get size {
    if (_isDisposed || !mounted) return Size.zero;
    try {
      final renderObject = context.findRenderObject() as RenderBox?;
      return renderObject?.size ?? Size.zero;
    } catch (e) {
      return Size.zero;
    }
  }

  Offset descendantOffset(RenderBox descendant) {
    if (_isDisposed || !mounted) return Offset.zero;
    try {
      final RenderBox? root = context.findRenderObject() as RenderBox?;
      if (root == null) return Offset.zero;
      return descendant.localToGlobal(Offset.zero, ancestor: root);
    } catch (e) {
      return Offset.zero;
    }
  }

  Listenable get changes => _ctrl;

  @override
  Widget build(BuildContext context) => widget.child;
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = Shimmer.of(context);
    if (state == null || state._isDisposed || !state._hasSize) return child;

    return AnimatedBuilder(
      animation: state.changes,
      builder: (_, __) {
        if (state._isDisposed || !state.mounted) return child;

        try {
          final box = context.findRenderObject() as RenderBox?;
          if (box == null || !box.hasSize) return child;

          final offset = state.descendantOffset(box);
          final shader = state.gradient.createShader(Rect.fromLTWH(
            -offset.dx,
            -offset.dy,
            state.size.width,
            state.size.height,
          ));

          return ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (_) => shader,
            child: child,
          );
        } catch (e) {
          return child;
        }
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slide});
  final double slide;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * slide, 0, 0);
}
