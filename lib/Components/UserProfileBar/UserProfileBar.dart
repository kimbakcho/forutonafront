import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'UserInfoAvatar.dart';

class UserProfileBar extends StatelessWidget {
  final FUserInfoSimpleResDto? fUserInfoSimpleResDto;

  const UserProfileBar({Key? key, this.fUserInfoSimpleResDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserProfileBarViewModel(
            fUserInfoSimpleResDto: fUserInfoSimpleResDto),
        child: Consumer<UserProfileBarViewModel>(builder: (_, model, __) {
          return Material(
              child: InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.white,
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                      child: Row(children: [
                        UserInfoAvatar(
                          fUserInfoSimpleResDto: model.fUserInfoSimpleResDto!,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Column(children: [
                          nickName(),
                          SizedBox(height: 4),
                          Row(children: [userInfo()])
                        ]))
                      ]))));
        }));
  }

  Container userInfo() {
    return Container(
        child: RichText(
            text: TextSpan(
                text: "영향력 ${fUserInfoSimpleResDto!.playerPower!.toInt()} BP",
                style: GoogleFonts.notoSans(
                  fontSize: 13,
                  color: const Color(0xff5B5B5B),
                ),
                children: [
          TextSpan(
              text: " • ",
              style: GoogleFonts.notoSans(
                fontSize: 13,
                color: const Color(0xff5B5B5B),
              )),
          TextSpan(
              text: "팔로워 ${fUserInfoSimpleResDto!.followerCount!.toInt()} 명",
              style: GoogleFonts.notoSans(
                fontSize: 13,
                color: const Color(0xff5B5B5B),
              ))
        ])));
  }

  Container nickName() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(fUserInfoSimpleResDto!.nickName!,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            color: const Color(0xff2f3035),
            fontWeight: FontWeight.w500,
          )),
    );
  }
}

class UserProfileBarViewModel extends ChangeNotifier {
  final FUserInfoSimpleResDto? fUserInfoSimpleResDto;

  UserProfileBarViewModel({required this.fUserInfoSimpleResDto});
}
