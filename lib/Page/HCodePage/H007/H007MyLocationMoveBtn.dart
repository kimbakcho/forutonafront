import 'package:flutter/material.dart';

class H007MyLocationMoveBtn extends StatelessWidget {

  final Function onGoMyLocation;

  const H007MyLocationMoveBtn({
    Key key, this.onGoMyLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        shape: CircleBorder(),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            this.onGoMyLocation();
          },
          child: Container(
            width: 36,
            height: 36,
            child: Icon(
              Icons.my_location,
              color: Color(0xff454F63),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}