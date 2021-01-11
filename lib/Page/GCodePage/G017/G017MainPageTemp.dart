import 'package:flutter/material.dart';

import 'package:forutonafront/Page/GCodePage/G017/G017MainPageTempViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class G017MainPageTemp extends StatelessWidget {
  final int _idx;

  G017MainPageTemp(this._idx);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G017MainPageTempViewModel(
            context: context,
            idx: _idx,
            personaSettingNoticeUseCaseInputPort: sl()),
        child: Consumer<G017MainPageTempViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Positioned(
                          top: 0, left: 0, child: topBar(model, context)),
                      Positioned(
                          top: 57, left: 0, child: topTitleBar(model, context)),
                      Positioned(
                          top: 136,
                          left: 0,
                          child: noticeContentBar(model, context))
                    ])))
          ]);
        }));
  }

  Container noticeContentBar(
      G017MainPageTempViewModel model, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      height: MediaQuery.of(context).size.height - 180,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: model.personaSettingNoticeResDto != null
          ? WebView(initialUrl: model.htmlUrl)
          : Container(),
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Container topTitleBar(G017MainPageTempViewModel model, BuildContext context) {
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
                        color: Color(0xff454f63))),
                Text(
                    DateFormat("yy.MM.dd").format(
                        model.personaSettingNoticeResDto.noticeWriteDateTime),
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                      color: Color(0xff454f63),
                    ))
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
            )
          : Container(),
    );
  }

  Container topBar(G017MainPageTempViewModel model, BuildContext context) {
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
