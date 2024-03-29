import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallImageViewer/BallImageViwer.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';
import 'package:google_fonts/google_fonts.dart';

import 'DBallForePicture.dart';
import 'DBallOnePicture.dart';
import 'DBallThreePicture.dart';
import 'DBallTwoPicture.dart';

class DBallPictures extends StatelessWidget {
  final List<BallImageItem?>? desImages;

  DBallPictures({this.desImages});

  @override
  Widget build(BuildContext context) {
    return desImages!.length > 0 ? Container(
        child: Column(
      children: <Widget>[
        Container(
          height: 240,
          child: selectPictureWidget(desImages),
        ),
        desImages!.length > 4
            ? Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return BallImageViewer(
                              desImages!,
                              null,
                              initIndex: 0,
                            );
                          }));
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Text(
                            '사진 모두 보기(${desImages!.length})',
                            style: GoogleFonts.notoSans(
                              fontSize: 16,
                              color: const Color(0xff000000),
                              letterSpacing: -0.8,
                              fontWeight: FontWeight.w700,
                              height: 1.375,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff000000)),
                      ),
                    ),
                  )
                ],
              )
            : Container()
      ],
    )):Container();
  }

  Widget selectPictureWidget(List<BallImageItem?>? desImages) {
    if(desImages != null){
      if (desImages.length == 0) {
        return Container();
      } else if (desImages.length == 1) {
        return DBallOnePicture(
          fBallDesImages: desImages[0],
        );
      } else if (desImages.length == 2) {
        return DBallTwoPicture(fBallDesImages: desImages);
      } else if (desImages.length == 3) {
        return DBallThreePicture(fBallDesImages: desImages);
      } else if (desImages.length >= 4) {
        return DBallForePicture(fBallDesImages: desImages);
      } else {
        return Container();
      }
    }else {
      return Container();
    }

  }
}
