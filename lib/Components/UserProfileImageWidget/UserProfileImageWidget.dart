import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserProfileImageWidget extends StatelessWidget {

  final String imageUrl;
  final double width;
  final double height;

  const UserProfileImageWidget({Key key, this.imageUrl, this.width=30.0, this.height=30.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null && imageUrl.isNotEmpty ? Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(
                  imageUrl))),
    ) : _basicProfileImageWidget();
  }

  Container _basicProfileImageWidget() {
    return Container(
      width: width,
      height: height,
      child: SvgPicture.asset("assets/IconImage/user-circle.svg"),
      decoration: BoxDecoration(
          shape: BoxShape.circle
      ),
    );
  }
}
