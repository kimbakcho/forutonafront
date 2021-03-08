import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserProfileImageWidget extends StatelessWidget {

  final String imageUrl;
  final double width;
  final double height;

  const UserProfileImageWidget({Key key, this.imageUrl, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty ? Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(
                  imageUrl))),
    ) : _basicProfileImageWidget();
  }

  Container _basicProfileImageWidget() {
    return Container(
      width: 30,
      height: 30,
      child: SvgPicture.asset("assets/IconImage/user-circle.svg"),
      decoration: BoxDecoration(
          shape: BoxShape.circle
      ),
    );
  }
}
