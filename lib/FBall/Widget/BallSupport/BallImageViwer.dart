import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Widget/BallSupport/BallImageViewerViewModel.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import 'package:flutter/scheduler.dart' show timeDilation;

// ignore: must_be_immutable
class BallImageViewer extends StatelessWidget {
  BallImageViewer(this.imageList, this.tag);

  String tag;
  List<FBallDesImagesDto> imageList;

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.8;
    return ChangeNotifierProvider(
        create: (_) => BallImageViewerViewModel(),
        child: Consumer<BallImageViewerViewModel>(builder: (_, model, child) {
          return Stack(
            children: <Widget>[
              Scaffold(
                  appBar: AppBar(
                      backgroundColor: Colors.white,
                      title: Row(
                        children: <Widget>[Text("이미지"), Spacer(),
                          Text("${model.currentPage+1}"+'/ '+"${imageList.length}")],
                      )),
                  body: PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(imageList[index].src),
                        initialScale: PhotoViewComputedScale.contained * 1,
                        heroAttributes: tag != null
                            ? PhotoViewHeroAttributes(tag: tag,)
                            : null,
                      );
                    },
                    itemCount: imageList.length,
                    onPageChanged: (value){
                      model.setCurrentPage(value);
                    },
                    loadingBuilder: (context, progress) => Center(
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          value: progress == null
                              ? null
                              : progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes,
                        ),
                      ),
                    ),
                  ))
            ],
          );
        }));
  }
}