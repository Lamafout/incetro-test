import 'package:flutter/material.dart';
import 'package:incetro_test/di/di.dart';

void main() {
  setupDi();
  runApp(MyCyprus());
}

class MyCyprus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyCyprus',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyCyprus'),
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}