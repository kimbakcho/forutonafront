import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:google_fonts/google_fonts.dart';

class ReduceSizeImageWidget extends StatelessWidget {
  const ReduceSizeImageWidget({
    Key key,
    @required this.issueBallDisPlayUseCase,
  }) : super(key: key);

  final BallDisPlayUseCase issueBallDisPlayUseCase;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
            imageUrl: issueBallDisPlayUseCase.mainPictureSrc(),
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            placeholder: (context, url) => Container(
                  child: Icon(Icons.image, color: Color(0xffE4E7E8), size: 40),
                )),
        issueBallDisPlayUseCase.pictureCount() > 1 ?
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 4, 6, 4),
              child: Text('+${issueBallDisPlayUseCase.pictureCount() - 1}',
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                  )),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: const Color(0x99454f63),
                border: Border.all(width: 1.0, color: const Color(0x99454f63)),
              )),
        ) : Container()
      ],
    );
  }
}
