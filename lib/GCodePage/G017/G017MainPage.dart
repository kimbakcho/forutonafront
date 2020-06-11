
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:forutonafront/GCodePage/G017/G017MainPageViewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class G017MainPage extends StatelessWidget {
  final int _idx;

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
                      Positioned(top: 0, left: 0, child: topBar(model,context)),
                      Positioned(top: 56, left: 0, child: topTitleBar(model,context)),
                      Positioned(
                          top: 136, left: 0, child: noticeContentBar(model,context))
                    ])))
          ]);
        }));
  }

  Container noticeContentBar(G017MainPageViewModel model,BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-32,
      height: MediaQuery.of(context).size.height - 180,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),

      child: model.personaSettingNoticeResDto != null
          ? WebviewScaffold(url: model.htmlUrl)
          : Container(),
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Container topTitleBar(G017MainPageViewModel model,BuildContext context) {
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      color: Colors.white,
      child: model.personaSettingNoticeResDto != null
          ? Column(
              children: <Widget>[
                Text(model.personaSettingNoticeResDto.noticeName,
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
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
                        fontSize: 10,
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

  Container topBar(G017MainPageViewModel model,BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackTap,
                child: Icon(Icons.arrow_back)),
            width: 48),
        Container(
            child: Text("공지사항 상세",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                )))
      ]),
    );
  }
}
