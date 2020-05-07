import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'J004ViewModel.dart';

class J004View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => J004ViewModel(),
        child: Consumer<J004ViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(body: Container(child: Text("123")))
          ]);
        }));
  }
}
