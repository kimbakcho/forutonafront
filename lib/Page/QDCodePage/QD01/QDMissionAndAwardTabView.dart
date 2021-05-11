import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QDMissionAndAward extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QDMisstionAndAwardViewModel(),
      child: Consumer<QDMisstionAndAwardViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Text("QDMissionAndAward"),
          );
        },
      ),
    );
  }
}

class QDMisstionAndAwardViewModel extends ChangeNotifier {}
