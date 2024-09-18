import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeartIconButton extends StatefulWidget {
  const HeartIconButton({super.key});

  @override
  State<HeartIconButton> createState() => _HeartIconButtonState();
}

class _HeartIconButtonState extends State<HeartIconButton> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isLiked = !_isLiked;
        });
      },
      iconSize: 30,
      icon: Icon(
        _isLiked
        ? CupertinoIcons.heart_fill
        : CupertinoIcons.heart,
      ),
    );
  }
}