import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/Page/GCodePage/Component/GCodeLineButtonComponent.dart';
import 'package:forutonafront/Page/LCodePage/L003/L003MainPage.dart';
import 'package:provider/provider.dart';

class G019MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => G019MainPageViewModel(),
      child: Consumer<G019MainPageViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              padding: MediaQuery.of(context).padding,
              child: Column(
                children: [
                  CodeAppBar(
                    title: "고객 센터",
                    visibleTailButton: false,
                    progressValue: 0
                  ),
                  Expanded(child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        GCodeLineButtonComponent(
                          onTap: (){

                          },
                          text: "Q&A",
                          icon: Icon(Icons.question_answer),
                        ),
                        SizedBox(height: 8),
                        Divider(color: Color(0xff3A3E3F)),
                        GCodeLineButtonComponent(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                              return L003MainPage(termsIdx: 15,);
                            }));
                          },
                          text: "포루투나 이용약관",
                          icon: Icon(Icons.article),
                        ),
                        GCodeLineButtonComponent(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                              return L003MainPage(termsIdx: 67,);
                            }));
                          },
                          text: "포루투나 운영정책",
                          icon: Icon(Icons.article),
                        ),
                        GCodeLineButtonComponent(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                              return L003MainPage(termsIdx: 16,);
                            }));
                          },
                          text: "개인정보 보호정책",
                          icon: Icon(Icons.article),
                        ),
                        GCodeLineButtonComponent(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                              return L003MainPage(termsIdx: 17,);
                            }));
                          },
                          text: "위치정보 보호정책",
                          icon: Icon(Icons.article),
                        ),
                        GCodeLineButtonComponent(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                              return L003MainPage(termsIdx: 17,);
                            }));
                          },
                          text: "오픈소스 라이센스",

                          icon: Icon(Icons.article),
                        ),
                        SizedBox(height: 4),
                        Divider(color: Color(0xff3A3E3F)),
                        GCodeLineButtonComponent(
                          onTap: (){
                            Fluttertoast.showToast(msg: "준비중입니다.");
                          },
                          text: "회사 소개",
                          icon: Icon(Icons.apartment),
                        ),
                        SizedBox(height: 8),
                        Divider(color: Color(0xff3A3E3F)),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class G019MainPageViewModel extends ChangeNotifier {}

