import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  // const FadeAnimation({Key? key}) : super(key: key);
  final double delay;
  final Widget child;
  const FadeAnimation({super.key, required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500))
          .thenTween('y', Tween(begin: -30.0, end: 0.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value.get("opacity"),
        child: Transform.translate(
            offset: Offset(0, value.get("y")), child: child),
      ),
    );
    // return ControlledAnimation();
  }
}

class FadeXAnimation extends StatelessWidget {
  // const FadeAnimation({Key? key}) : super(key: key);
  final double delay;
  final Widget child;
  const FadeXAnimation({super.key, required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500))
          .thenTween('x', Tween(begin: -10.0, end: 0.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value.get("opacity"),
        child: Transform.translate(
            offset: Offset(value.get("x"), 0), child: child),
      ),
    );
  }
}
