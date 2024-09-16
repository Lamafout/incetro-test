import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'А вот на профиль переключения не было ТЗ!',
        style: Platform.isIOS
        ? CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
        : Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}