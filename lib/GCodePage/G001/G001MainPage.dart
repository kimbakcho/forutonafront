import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/GCodePage/G001/G001MainPageViewModel.dart';
import 'package:provider/provider.dart';

class G001MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var g001MainPageViewModel = Provider.of<G001MainPageViewModel>(context);
    return ChangeNotifierProvider.value(
        value: g001MainPageViewModel,
        child: Consumer<G001MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    child: Stack(children: <Widget>[
              Positioned(
                  top: 36.h, left: 146.w, child: userProfileImage(model)),
              Positioned(top: 126.h, left: 0, child: userNickName(model)),
              Positioned(
                top: 150.h,
                left: 0,
                child: userCountry(model),
              ),
              Positioned(top: 179.h, left: 0, child: userIntroduce(model)),
                      
            ])))
          ]);
        }));

    Container();
  }

  Container userIntroduce(G001MainPageViewModel model) {
    return Container(
        width: 360.w,
        alignment: Alignment.center,
        child: model.getHaveUserSelfIntroduction()
            ? Text(model.getUserSelfIntroduction(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 12.sp,
                  color: Color(0xff454f63),
                ))
            : Container(
                child: InkWell(
                    onTap: () {},
                    child: Text(model.getUserSelfIntroduction(),
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 12,
                          color: Color(0xff3497fd),
                          decoration: TextDecoration.underline,
                        )))));
  }

  Container userCountry(G001MainPageViewModel model) {
    return Container(
      width: 360.w,
      alignment: Alignment.center,
      child: Text(model.getUserCountry()),
    );
  }

  Container userNickName(G001MainPageViewModel model) {
    return Container(
        width: 360.w,
        alignment: Alignment.center,
        child: Text(model.getUserNickName(),
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontWeight: FontWeight.w700,
              fontSize: 17.sp,
              color: Color(0xff454f63),
            )));
  }

  Container userProfileImage(G001MainPageViewModel model) {
    return Container(
        height: 69.00.h,
        width: 69.00.w,
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: model.getUserProfileImage(),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              ),
            ],
            shape: BoxShape.circle));
  }
}
