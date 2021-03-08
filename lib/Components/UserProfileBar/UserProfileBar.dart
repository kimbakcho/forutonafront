import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserProfileBar extends StatelessWidget {
  final FUserInfoSimpleResDto fUserInfoSimpleResDto;

  const UserProfileBar({Key key, this.fUserInfoSimpleResDto}) : super(key: key);

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
                        avatar(),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Column(children: [
                          nickName(),
                          Row(children: [userInfo()])
                        ]))
                      ]))));
        }));
  }

  Container userInfo() {
    return Container(
        child: RichText(
            text: TextSpan(
                text: "영향력 ${fUserInfoSimpleResDto.playerPower.toInt()} PP",
                style: GoogleFonts.notoSans(
                  fontSize: 10,
                  color: const Color(0xff78849e),
                ),
                children: [
          TextSpan(
              text: "•",
              style: GoogleFonts.notoSans(
                fontSize: 10,
                color: const Color(0xff78849e),
              )),
          TextSpan(
              text: "팔로워 ${fUserInfoSimpleResDto.followerCount.toInt()} 명",
              style: GoogleFonts.notoSans(
                fontSize: 10,
                color: const Color(0xff78849e),
              ))
        ])));
  }

  Container nickName() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(fUserInfoSimpleResDto.nickName,
          style: GoogleFonts.notoSans(
            fontSize: 12,
            color: const Color(0xff2f3035),
            fontWeight: FontWeight.w500,
          )),
    );
  }

  Widget avatar() {
    if(fUserInfoSimpleResDto.profilePictureUrl != null && fUserInfoSimpleResDto.profilePictureUrl.isNotEmpty){
      return CachedNetworkImage(
          fit: BoxFit.fitWidth,
          imageUrl: fUserInfoSimpleResDto.profilePictureUrl,
          imageBuilder: (context, imageProvider) => Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            child: Icon(Icons.image, color: Color(0xffE4E7E8), size: 40),
          )
      );
    }else {
      return  Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset("assets/IconImage/user-circle.svg"),
      );
    }
  }
}

class UserProfileBarViewModel extends ChangeNotifier {
  final FUserInfoSimpleResDto fUserInfoSimpleResDto;

  UserProfileBarViewModel({@required this.fUserInfoSimpleResDto});
}
