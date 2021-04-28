import 'package:flutter/material.dart';
import 'package:forutonafront/Page/GCodePage/G010/G010MainPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'UserProfileMode.dart';

class UserSelfIntroduceWidget extends StatelessWidget {
  final UserProfileMode? userProfileMode;

  final String? userSelfIntroduce;

  const UserSelfIntroduceWidget(
      {Key? key, this.userProfileMode, this.userSelfIntroduce})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserSelfIntroduceWidgetViewModel(),
        child: Consumer<UserSelfIntroduceWidgetViewModel>(
            builder: (_, model, child) {
          if (userSelfIntroduce!.isNotEmpty) {
            return Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text(
                  userSelfIntroduce!,
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: const Color(0xff3a3e3f),
                  ),
                  textAlign: TextAlign.center,
                ));
          } else {
            if (userProfileMode == UserProfileMode.ME) {
              return Container(
                  child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:  (_){
                      return G010MainPage();
                    }));
                  },
                  child: Container(
                    child: Text(
                      '여기를 눌러 소개글을 작성해 주세요.',
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        color: const Color(0xff3497fd),
                        decoration: TextDecoration.underline,
                        height: 1.1666666666666667,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ));
            } else {
              return Container();
            }
          }
        }));
  }
}

class UserSelfIntroduceWidgetViewModel extends ChangeNotifier {}
