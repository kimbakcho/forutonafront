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
              StickyHeader(
                header: Container(
                  height: 50.0,
                  color: Colors.blueGrey[700],
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Header #1',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                content: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: model.itemcount,
                    itemBuilder: (context, index) {
                      return Container(child: Text("${index}"));
                    }),
              ),
              StickyHeader(
                header: Container(
                  height: 50.0,
                  color: Colors.blueGrey[700],
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Header #1',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                content: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: model.itemcount,
                    itemBuilder: (context, index) {
                      return Container(child: Text("${index}"));
                    }),
              ),
              StickyHeader(
                header: Container(
                  height: 50.0,
                  color: Colors.blueGrey[700],
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Header #2',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                content: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: model.itemcount,
                    itemBuilder: (context, index) {
                      return Container(child: Text("${index}"));
                    }),
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
