import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:provider/provider.dart';

class UserInfoAvatar extends StatelessWidget {

  final FUserInfoSimpleResDto fUserInfoSimpleResDto;

  UserInfoAvatar({required this.fUserInfoSimpleResDto});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserInfoAvatarViewModel(),
      child: Consumer<UserInfoAvatarViewModel>(
        builder: (_, model, child) {
          if(fUserInfoSimpleResDto.profilePictureUrl != null && fUserInfoSimpleResDto.profilePictureUrl!.isNotEmpty){
            return CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: fUserInfoSimpleResDto.profilePictureUrl!,
                imageBuilder: (context, imageProvider) => Container(
                  width: 45,
                  height: 45,
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
        },
      ),
    );
  }
}

class UserInfoAvatarViewModel extends ChangeNotifier {}
