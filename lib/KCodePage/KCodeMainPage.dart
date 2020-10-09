import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KCodeMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>KCodeMainPageViewModel(),
      child: Consumer<KCodeMainPageViewModel>(
        builder: (_,model,__){
          return Scaffold(
            body:Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Text("K001"),
            ) ,
          )
            ;
        },
      ),
    );
  }
}

class KCodeMainPageViewModel extends ChangeNotifier {

}
