import 'dart:async';
import 'package:flutter/material.dart';

class RainbowShimmerText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration shimmerDuration;
  final Duration pauseDuration;

  const RainbowShimmerText({
    super.key,
    required this.text,
    required this.style,
    this.shimmerDuration = const Duration(seconds: 1),
    this.pauseDuration = const Duration(seconds: 2),
  });

  @override
  State<RainbowShimmerText> createState() => _RainbowShimmerTextState();
}

class _RainbowShimmerTextState extends State<RainbowShimmerText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPaused = false;
  Timer? _pauseTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.shimmerDuration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _isPaused = true);
          _pauseTimer = Timer(widget.pauseDuration, () {
            if (mounted) {
              setState(() => _isPaused = false);
              _controller.forward(from: 0);
            }
          });
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pauseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isPaused) {
      // Show blue text during pause
      return Text(
        widget.text,
        style: widget.style.copyWith(color: const Color(0xFF113771)),
      );
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: const [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
                Colors.red,
              ],
              stops: const [0.0, 0.16, 0.33, 0.5, 0.66, 0.83, 1.0, 1.0],
              begin: Alignment(-1.0 + 2.0 * _controller.value, 0),
              end: Alignment(1.0 + 2.0 * _controller.value, 0),
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style.copyWith(color: Colors.white),
          ),
        );
      },
    );
  }
}