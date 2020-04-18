import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';

import 'G022MainPageViewModel.dart';

class G022MainPage extends StatelessWidget {
  String policyTitle;

  //DB에서 가져올 이름 (필터)
  String _policyName;

  G022MainPage(this.policyTitle, this._policyName);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G022MainPageViewModel(context, policyTitle, _policyName),
        child: Consumer<G022MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Positioned(top: 0, left: 0, child: topBar(model)),
                      Positioned(
                          top: 71.h, left: 16.w, child: contentBar(model)),
                    ])))
          ]);
        }));
  }

  Container contentBar(G022MainPageViewModel model) {
    return Container(
        height: 530.00.h,
        width: 328.00.w,
        child: model.userPolicyResDto != null
            ? WebviewScaffold(url: model.htmlUrl)
            : Container(),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff455b63).withOpacity(0.08),
                blurRadius: 16.w)
          ],
          borderRadius: BorderRadius.circular(12.00.w),
        ));
  }

  topBar(G022MainPageViewModel model) {
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
            child: Text(model.policyTitle,
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
