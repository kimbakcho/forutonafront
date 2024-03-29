import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallImageViewer/BallImageViwer.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';

class DBallImageContainer extends StatelessWidget {
  final List<BallImageItem?>? fBallDesImages;
  final int index;

  DBallImageContainer(this.fBallDesImages, this.index);

  @override
  Widget build(BuildContext context) {
    if(fBallDesImages == null){
      return Container();
    }
    var item = fBallDesImages![index];
    return item != null ? Container(
        child: InkWell(
          onTap: () {
            if(fBallDesImages != null) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BallImageViewer(
                  fBallDesImages!,
                  null,
                  initIndex: index,
                );
              }));
            }
          },
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: item.imageProvider,
        ))): Container();
  }
}
