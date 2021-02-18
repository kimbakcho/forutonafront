import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallImageViewer/BallImageViwer.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';


class ID01ImageContainer extends StatelessWidget {
  final List<BallImageItem> fBallDesImages;
  final int index;

  ID01ImageContainer(this.fBallDesImages, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return BallImageViewer(
              fBallDesImages,
              null,
              initIndex: index,
            );
          }));
        },
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: fBallDesImages[index].imageProvider,
      )),
    );
  }
}
