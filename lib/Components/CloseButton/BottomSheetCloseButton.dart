import 'package:flutter/material.dart';

class BottomSheetCloseButton extends StatelessWidget {

  BottomSheetCloseButton();

  @override
  Widget build(BuildContext context) {
    return
      Material(
        color: Colors.black,
        shape: CircleBorder(),
        child: Center(
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(3),
              child: Icon(Icons.close,color: Colors.white,size: 20),
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
    );
  }


}
