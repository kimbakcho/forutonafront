import 'package:flutter/material.dart';
import 'package:forutonafront/Page/LCodePage/L013/L013MainPage.dart';
import 'package:forutonafront/Page/LCodePage/L016/L016MainPage.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'L012MainButton/L012MainButton.dart';

class L012MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => L012MainPageViewModel(),
      child: Consumer<L012MainPageViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            body: Container(
              padding: MediaQuery.of(context).padding,
              child: Container(
                color: Color(0xffF2F3F5),
                child: Column(
                  children: [
                    CodeAppBar(
                      title: "패스워드 찾기",
                      visibleTailButton: false,
                      progressValue: 0,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16,right: 16),
                      child: L012MainButton(
                        title: "휴대폰 인증하기",
                        description: "계정에 등록된 휴대폰 번호를 인증하고 패스워드를 변경합니다.",
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return L013MainPage();
                          }));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16,right: 16),
                      child: L012MainButton(
                        title: "이메일 인증하기",
                        description: "계정에 사용한 이메일 주소를 인증하고 패스워드를 변경합니다.",
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return L016MainPage();
                          }));
                        },
                      ),
                    )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class L012MainPageViewModel extends ChangeNotifier {

}
