import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallImageViewer/BallImageViwer.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';

import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001Pictures/ID001ForePicture.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001Pictures/ID001OnePicture.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001Pictures/ID001ThreePicture.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001Pictures/ID001TwoPicture.dart';
import 'package:google_fonts/google_fonts.dart';

class ID001Pictures extends StatelessWidget {
  final List<FBallDesImages> desImages;

  ID001Pictures({this.desImages});

  @override
  Widget build(BuildContext context) {
    return desImages.length > 0 ? Container(
        child: Column(
      children: <Widget>[
        Container(
          height: 240,
          child: selectPictureWidget(desImages),
        ),
        desImages.length > 4
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
                              desImages,
                              null,
                              initIndex: 0,
                            );
                          }));
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Text(
                            '사진 더 불러오기',
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
                        borderRadius: BorderRadius.circular(12.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff000000)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Container()
      ],
    )):Container();
  }

  Widget selectPictureWidget(List<FBallDesImages> desImages) {
    if (desImages.length == 0) {
      return Container();
    } else if (desImages.length == 1) {
      return ID001OnePicture(
        fBallDesImages: desImages[0],
      );
    } else if (desImages.length == 2) {
      return ID001TwoPicture(fBallDesImages: desImages);
    } else if (desImages.length == 3) {
      return ID001ThreePicture(fBallDesImages: desImages);
    } else if (desImages.length >= 4) {
      return ID001ForePicture(fBallDesImages: desImages);
    } else {
      return Container();
    }
  }
}
