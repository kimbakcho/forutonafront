import 'package:flutter/material.dart';

class BorderCircleBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      child: Material(
        color: Color(0xffF6F6F6),
        shape: CircleBorder(),
        child: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Color(0xff454F63),size: 20),
        ),
      ),
    );
  }
}
