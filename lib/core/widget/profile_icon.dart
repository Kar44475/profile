import 'package:flutter/material.dart';
class ProfileIcon extends StatelessWidget{
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: Image.asset('assets/profilecirlce.gif'),
        ),
        Positioned(
          left: 25,
          top: 25,
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset('assets/myPhoto.png'),
          ),
        ),
      ],
    );
  }
}