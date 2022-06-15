import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText(
      {Key? key,
      required this.text,
      this.textStyle = const TextStyle(),
      this.turnOfAnimation = false,
      this.textAnimationDuration = const Duration(milliseconds: 1000),
      this.textGradientColor = const [
        Colors.grey,
        Colors.white,
      ]})
      : super(key: key);
  final String text;
  final TextStyle textStyle;
  final bool turnOfAnimation;
  final Duration textAnimationDuration;
  final List<Color> textGradientColor;
  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: widget.textAnimationDuration);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        _animationController.repeat();
      });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.turnOfAnimation) {
     _animationController.forward();
    }
    return widget.turnOfAnimation
        ? Text(
            widget.text,
            style: widget.textStyle,
          )
        : AnimatedBuilder(
            animation: _animationController,
            child: Text(
              widget.text,
              style: widget.textStyle,
            ),
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(stops: [
                    _animationController.value,
                    _animationController.value
                  ], colors: widget.textGradientColor)
                      .createShader(rect);
                },
                child: child,
              );
            });
  }
}
