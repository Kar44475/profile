import 'package:flutter/material.dart';

class MyDescription extends StatelessWidget {
  const MyDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "I am a flutter developer with a passion for creating beautiful and functional applications. I love to explore new technologies and continuously improve my skills. In my free time, I enjoy contributing to open-source projects and learning about the latest trends in mobile development.",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Colors.white.withOpacity(0.9),
          fontSize: 16,
          height: 1.6,
        ),
      ),
    );
  }
}