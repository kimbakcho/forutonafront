import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:forutonafront/GCodePage/G017/G017MainPageViewModel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class G017MainPage extends StatelessWidget {
  int _idx;

  G017MainPage(this._idx);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G017MainPageViewModel(context, _idx),
        child: Consumer<G017MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Positioned(top: 0, left: 0, child: topBar(model)),
                      Positioned(top: 56.h, left: 0, child: topTitleBar(model)),
                      Positioned(
                          top: 136.h,
                          left: 0,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                            width: 328.w,
                            height: 456.h,
                            child: model.personaSettingNoticeResDto != null ? WebviewScaffold(url: model.htmlUrl) : Container(),
                            decoration: BoxDecoration(color: Colors.white),
                          ))
                    ])))
          ]);
        }));
  }

  Container topTitleBar(G017MainPageViewModel model) {
    return Container(
      height: 64.h,
      width: 360.w,
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
      color: Colors.white,
      child: model.personaSettingNoticeResDto != null
          ? Column(
              children: <Widget>[
                Text(model.personaSettingNoticeResDto.noticeName,
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Color(0xff454f63),
                      shadows: [
                        Shadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                          blurRadius: 6,
                        ),
                      ],
                    )),
                Text(
                    DateFormat("yy.MM.dd").format(
                        model.personaSettingNoticeResDto.noticeWriteDateTime),
                    style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w300,
                        fontSize: 10.sp,
                        color: Color(0xff454f63),
                        shadows: [
                          Shadow(
                            offset: Offset(0.00, 3.00),
                            color: Color(0xff000000).withOpacity(0.16),
                            blurRadius: 6,
                          )
                        ]))
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
            )
          : Container(),
    );
  }

  Container topBar(G017MainPageViewModel model) {
    return Container(
      width: 360.w,
      height: 56.h,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackTap,
                child: Icon(Icons.arrow_back)),
            width: 48.w),
        Container(
            child: Text("내용",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Color(0xff454f63),
                )))
      ]),
    );
  }
}
