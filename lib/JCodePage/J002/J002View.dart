import 'package:flutter/material.dart';
import 'package:forutonafront/JCodePage/J002/J002ViewModel.dart';
import 'package:provider/provider.dart';

class J002View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => J002ViewModel(),
        child: Consumer<J002ViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
              child: Text("123"),
            ))
          ]);
        }));
  }
}
