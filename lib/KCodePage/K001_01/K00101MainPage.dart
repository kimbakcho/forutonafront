import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class K00101MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => K00101MainPageViewModel(),
        child: Consumer<K00101MainPageViewModel>(builder: (_, model, __) {
          return ListView(
            children: [
              Container(
                child: Text("123"),
              ),
              FlatButton(
                onPressed: model.itemcoutplus,
                child: Text("123"),
              )
            ],
          );
        }));
  }
}

class K00101MainPageViewModel extends ChangeNotifier {
  int itemcount = 1;

  void itemcoutplus() {
    itemcount++;
    notifyListeners();
  }
}
