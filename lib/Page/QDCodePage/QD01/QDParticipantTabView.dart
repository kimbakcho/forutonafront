import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QDParticipantTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QDParticipantTabViewViewModel(),
      child: Consumer<QDParticipantTabViewViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Text("QDParticipantTabView"),
          );
        },
      ),
    );
  }
}

class QDParticipantTabViewViewModel extends ChangeNotifier {}
