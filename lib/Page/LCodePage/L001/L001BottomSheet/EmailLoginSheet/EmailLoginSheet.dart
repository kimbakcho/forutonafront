import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailLoginSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=> EmailLoginSheetViewModel(),
      child: Consumer<EmailLoginSheetViewModel>(
        builder: (_,model,child){
          return Container(child: Text("이메일 로그인 페이지"));
        },
      ),
    );
  }
}
class EmailLoginSheetViewModel extends ChangeNotifier {

}
