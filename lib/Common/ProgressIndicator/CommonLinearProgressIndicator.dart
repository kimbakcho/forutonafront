import 'package:flutter/material.dart';

class CommonLinearProgressIndicator extends StatelessWidget {
  final double value;
  CommonLinearProgressIndicator(this.value);
  @override
  Widget build(BuildContext context) {
    return  LinearProgressIndicator(
      backgroundColor: Color(0xffCCCCCC),
      minHeight: 1.0,
      valueColor: AlwaysStoppedAnimation<Color>(
        Color(0xff3497FD),
      ),
      value: value,
    );
  }
}
