import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Z005CodeMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Z005CodeMainPageViewModel(),
      child: Consumer<Z005CodeMainPageViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            body: Container(
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                child: Text("위치 접근 권한이 거부 상태 입니다."),
                              ),
                              Container(
                                child: Text("권한 설정에서 위치 권한을 허용으로 설정해 주세요."),
                              )
                            ],
                          ),
                        ),
                      )),
                  FlatButton(onPressed: (){

                  }, child: Text("위치 접근 동의")),
                  Container(
                    child: Text("동의후 아래 설정 버튼을 눌러 주세요"),
                  ),
                  FlatButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text("포루투나 입장")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Z005CodeMainPageViewModel extends ChangeNotifier {}
