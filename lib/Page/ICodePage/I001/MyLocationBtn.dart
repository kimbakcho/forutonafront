import 'package:flutter/material.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class MyLocationBtn extends StatelessWidget {

  final Function? onMovetoMyLocation;

  const MyLocationBtn({Key? key, this.onMovetoMyLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleIconBtn(
      width: 36,
      height: 36,
      icon: Icon(Icons.my_location,size: 18),
      onTap: (){
        onMovetoMyLocation!();
      },
    );
  }
}
