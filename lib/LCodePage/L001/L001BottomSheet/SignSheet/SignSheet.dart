import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SignSheetViewModel(),
        child: Consumer<SignSheetViewModel>(builder: (_, model, child) {
          return Container(child: Text("회원 가입"));
        }));
  }
}

class SignSheetViewModel extends ChangeNotifier {

}
