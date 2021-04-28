import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ID001MakerInfo extends StatelessWidget {
  final String? userProfileImageUrl;
  final String? userNickName;
  final String? userInfluencePower;
  final String? userFollower;

  ID001MakerInfo(
      {required this.userProfileImageUrl,
      required this.userNickName,
      this.userFollower,
      this.userInfluencePower});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(userProfileImageUrl!),
                    fit: BoxFit.cover)),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            child: Text(
                      userNickName!,
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        color: const Color(0xff000000),
                        letterSpacing: -0.8,
                        fontWeight: FontWeight.w700,
                        height: 1.375,
                      ),
                      textAlign: TextAlign.left,
                    )))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            child: Text(
                      '영향력 $userInfluencePower  • 팔로워 $userFollower명',
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        color: const Color(0xff78849e),
                      ),
                      textAlign: TextAlign.left,
                    )))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
