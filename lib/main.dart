import 'package:flutter/material.dart';
import 'package:starbucks/common/view/starbucks.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Starbucks(),
    );
  }
}
