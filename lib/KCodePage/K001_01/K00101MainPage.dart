import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class K00101MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => K00101MainPageViewModel(),
        child: Consumer<K00101MainPageViewModel>(builder: (_, model, __) {
          return CustomScrollView(slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                child: Text("123"),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.itemcount,
                  itemBuilder: (context, index) {
                    return Container(child: Text("${index}"));
                  }),
                  FlatButton(
                    onPressed: model.itemcoutplus,
                    child: Text("123"),
                  )
            ]))
          ]);
        }));
  }
}

class K00101MainPageViewModel extends ChangeNotifier {

  int itemcount = 1;

  void itemcoutplus(){
    itemcount++;
    notifyListeners();
  }
}
