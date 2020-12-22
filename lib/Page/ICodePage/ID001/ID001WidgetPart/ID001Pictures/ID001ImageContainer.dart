import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallImageViewer/BallImageViwer.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';


class ID001ImageContainer extends StatelessWidget {
  final List<FBallDesImages> fBallDesImages;
  final int index;

  ID001ImageContainer(this.fBallDesImages, this.index);

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
        image: NetworkImage(fBallDesImages[index].src),
      )),
    );
  }
}
