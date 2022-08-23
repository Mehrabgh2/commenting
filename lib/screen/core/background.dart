import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      child: child,
    );
  }
}
