import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'BallImageEditItem.dart';
import 'BallImageItem.dart';

class BallImageEditComponent extends StatelessWidget {
  final BallImageEditComponentController ballImageEditComponentController;

  const BallImageEditComponent({Key key, this.ballImageEditComponentController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BallImageEditComponentViewModel(
          ballImageEditComponentController: ballImageEditComponentController),
      child: Consumer<BallImageEditComponentViewModel>(
        builder: (_, model, child) {
          return model.images.length != 0
              ? Container(
                  height: 96,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 16,),
                          Text("이미지",
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                              )),
                          Spacer(),
                          Text(
                            "${model.images.length}/20",
                            style: GoogleFonts.notoSans(
                              fontSize: 10,
                              color: const Color(0xffd4d4d4),
                            ),
                          ),
                          SizedBox(width: 16,)
                        ],
                      ),
                      Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(left: 16),

                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: model.images.length,
                        itemBuilder: (context, index) {
                          return BallImageEditItem(
                            ballImageItem: model.images[index],
                            onCloseTap: (ballImageItem) {
                              model._removeImage(ballImageItem);
                            },
                          );
                        },
                      ))
                    ],
                  ),
                )
              : Container();
        },
      ),
    );
  }
}

class BallImageEditComponentViewModel extends ChangeNotifier {
  List<BallImageItem> images = [];

  final BallImageEditComponentController ballImageEditComponentController;

  BallImageEditComponentViewModel({this.ballImageEditComponentController}) {
    if (ballImageEditComponentController != null) {
      ballImageEditComponentController._ballImageEditComponentViewModel = this;
    }
  }

  _removeImage(BallImageItem ballImageItem) {
    images.remove(ballImageItem);
    if (ballImageEditComponentController != null &&
        ballImageEditComponentController.onChangeItemList != null) {
      ballImageEditComponentController.onChangeItemList(images);
    }
    notifyListeners();
  }

  _addImage(ImageProvider imageProvider) async {
    BallImageItem ballImageItem = BallImageItem(sl());
    await ballImageItem.addImage(imageProvider: imageProvider);
    images.add(ballImageItem);
    if (ballImageEditComponentController != null &&
        ballImageEditComponentController.onChangeItemList != null) {
      ballImageEditComponentController.onChangeItemList(images);
    }
    notifyListeners();
  }

  _updateImageAndFillImageUrl() async {}

  List<FBallDesImages> _getImageItemUrlList() {
    List<FBallDesImages> ballImages = [];
    for (int i = 0; i < images.length; i++) {
      FBallDesImages fBallDesImage = FBallDesImages();
      fBallDesImage.index = i;
      fBallDesImage.src = images[i].imageUrl;
      ballImages.add(fBallDesImage);
    }
    return ballImages;
  }
}

class BallImageEditComponentController {
  BallImageEditComponentViewModel _ballImageEditComponentViewModel;

  final Function(List<BallImageItem> ballList) onChangeItemList;

  BallImageEditComponentController({this.onChangeItemList});

  addImage(FileImage imageProvider) async {
    if (imageProvider != null) {
      await _ballImageEditComponentViewModel._addImage(imageProvider);
    }
  }

  int getImageItemCount() {
    if (_ballImageEditComponentViewModel == null) {
      return 0;
    }
    return _ballImageEditComponentViewModel.images.length;
  }

  getImageItemUrlList() {
    return _ballImageEditComponentViewModel._getImageItemUrlList();
  }

  updateImageAndFillImageUrl() async {
    await _ballImageEditComponentViewModel._updateImageAndFillImageUrl();
  }
}
