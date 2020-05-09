import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'J006ViewModel.dart';

class J006View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>J006ViewModel(),
      child: Consumer<J006ViewModel>(builder: (_,model,child){
        return Stack(
          children: <Widget>[
              Scaffold(
                body: Container(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).padding.top, 0, 0),
                  child:Text("123")
                ),
              )
          ],
        );
      }),
    );
  }
}
