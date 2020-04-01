import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/HCodePage/HCodeMainPage.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:forutonafront/HCodePage/H001/H001Page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CodeMainpage extends StatefulWidget {
  CodeMainpage({Key key}) : super(key: key);

  @override
  _CodeMainpageState createState() => _CodeMainpageState();
}

class _CodeMainpageState extends State<CodeMainpage> {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CodeMainViewModel>(create:(_)=> CodeMainViewModel()),
        ChangeNotifierProvider<H001ViewModel>(create:(_)=> H001ViewModel())
      ],
      child: Consumer<CodeMainViewModel>(builder: (_, model, child) {
        return Scaffold(
          backgroundColor: Color(0xffF2F0F1),
          body: Stack(children: <Widget>[
            Container(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                    controller: model.pageController,
                    children: <Widget>[
                  HCodeMainPage(),
                  Container(
                    child: Text("2"),
                  ),
                  Container(
                    child: Text("3"),
                  ),
                  Container(
                    child: Text("4"),
                  ),
                  Container(
                    child: Text("5"),
                  )
                ]))
          ]),
        );
      }),
    );
  }
}
