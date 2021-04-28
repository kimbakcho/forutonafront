import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/HCodePage/H002/BottomMakeComponent/BallMakeButton.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001MainPage.dart';
import 'package:provider/provider.dart';

class BottomMakeComponent extends StatelessWidget {
  final Function? makeBallPop;

  const BottomMakeComponent({Key? key, this.makeBallPop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BottomMakeComponentViewModel(),
      child: Consumer<BottomMakeComponentViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Column(
              children: [
                Spacer(),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 15),
                  height: 87,
                  child: BallMakeButton(
                    icon: Icon(
                      ForutonaIcon.issue1,
                      color: Colors.white,
                      size: 18,
                    ),
                    text: "당신 주변에서 일어나는 크고 작은 소식들을 지도 위에 표시하고 공유해 보세요.",
                    ballName: "이슈볼",
                    leftImage: AssetImage(
                        "assets/BallMakeImage/issubalImakeimage.png"),
                    mainColor: Color(0xffDC3E57),
                    onTap: () async {
                      await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return IM001MainPage();
                      }));
                      makeBallPop!();
                    },
                  ),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  height: 87,
                  child: BallMakeButton(
                    icon: Icon(
                      ForutonaIcon.quest,
                      color: Colors.white,
                      size: 18,
                    ),
                    text: "해결해야할 일이 있으신가요? 보상을 건 퀘스트를 만들어 도움을 청해보세요.",
                    ballName: "퀘스트볼",
                    leftImage: AssetImage(
                        "assets/BallMakeImage/questBallMakeImage.png"),
                    mainColor: Color(0xff4f72ff),
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: "준비중입니다",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color(0xff454F63),
                          textColor: Colors.white,
                          fontSize: 12.0);
                    },
                  ),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ]),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: Material(
                    shape: CircleBorder(),
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      customBorder: CircleBorder(),
                      child: Container(
                        width: 32,
                        height: 32,
                        child: Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ]),
                ),
                SizedBox(height: 12),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BottomMakeComponentViewModel extends ChangeNotifier {}
