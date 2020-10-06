import 'package:flutter/material.dart';

class MyLocationBtn extends StatelessWidget {

  final Function onMovetoMyLocation;

  const MyLocationBtn({Key key, this.onMovetoMyLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      child: Material(
        shape: CircleBorder(),
        child: InkWell(
          onTap: (){
            onMovetoMyLocation();
          },
          child: Icon(Icons.my_location,color: Color(0xff454F63),size: 15),
        ),
      ),
    );
  }
}
