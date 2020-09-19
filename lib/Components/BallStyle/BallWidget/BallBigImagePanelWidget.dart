import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:google_fonts/google_fonts.dart';

class BallBigImagePanelWidget extends StatelessWidget {
  final BallDisPlayUseCase ballDisPlayUseCase;

  const BallBigImagePanelWidget({Key key, this.ballDisPlayUseCase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          height: 215,
          imageUrl: ballDisPlayUseCase.mainPictureSrc(),
          imageBuilder: (context, imageProvider) => Container(
            height: 215,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            height: 215,
            child: Icon(Icons.image, color: Color(0xffE4E7E8), size: 40),
          ),
        ),
        ballDisPlayUseCase.pictureCount() > 1
            ? Positioned(
                right: 8,
                bottom: 16,
                child: Container(
                  alignment: Alignment.center,
                  width: 31,
                  height: 26,
                  child: Text(
                    '+${ballDisPlayUseCase.pictureCount()}',
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xff454F63).withOpacity(0.6),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      border: Border.all(color: Color(0xff454F63))),
                ),
              )
            : Container()
      ],
    );
  }
}
