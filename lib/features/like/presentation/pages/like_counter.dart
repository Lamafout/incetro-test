import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incetro_test/di/di.dart';

class LikeCounter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: di<ValueNotifier<int>>(),
      builder: (context, value, child) {
        return Stack(
        children: [
          Center(
            child:
              Icon(
                CupertinoIcons.heart,
                color: Theme.of(context).iconTheme.color,
                size: 32,
              ),
          ),
          Center(
            child: Text(
              value.toString(),
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
      }
    );
  }
}