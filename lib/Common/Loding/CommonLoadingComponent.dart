import 'package:flutter/material.dart';

class CommonLoadingComponent extends StatelessWidget {
  bool isTouch = false ;
  CommonLoadingComponent({this.isTouch = false});

  @override
  Widget build(BuildContext context) {
    return !isTouch?
      FlatButton(
        onPressed: (){

        },
      child : loadingContainer(context)
    ) : loadingContainer(context);
  }

  Container loadingContainer(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:Center(
          child: CircularProgressIndicator(),
        )
    );
  }
}
