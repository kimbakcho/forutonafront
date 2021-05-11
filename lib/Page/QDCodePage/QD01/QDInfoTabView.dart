import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QDInfoTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QDInfoTabViewViewModel(),
      child: Consumer<QDInfoTabViewViewModel>(
        builder: (_, model, child) {
          return Container(
            child: ListView.builder(


              itemCount: 100,
              itemBuilder: (context, index) {
              return Text("${index}");
            },),
          );
        },
      ),
    );
  }
}

class QDInfoTabViewViewModel extends ChangeNotifier {}
