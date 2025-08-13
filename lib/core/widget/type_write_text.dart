import 'dart:async';
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  int _currentLength = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, (timer) {
      if (_currentLength < widget.text.length) {
        setState(() {
          _currentLength++;
        });
      } else {
        _timer?.cancel(); // Stop the timer when done
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String displayText = widget.text.substring(0, _currentLength);
    // Show underscore only while typing
    if (_currentLength < widget.text.length) {
      displayText += "_";
    }
    return Text(
      displayText,
      style: widget.style,
    );
  }
}