import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallImageListUpLoadUseCase/BallImageListUpLoadUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001Mode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'BallImageEditItem.dart';
import 'BallImageItem.dart';

class BallImageEditComponent extends StatelessWidget {
  final BallImageEditComponentController? ballImageEditComponentController;
  final EdgeInsets margin;
  final IM001Mode? im001mode;

  final FBallResDto? preSetBallResDto;

  const BallImageEditComponent(
      {Key? key,
      this.ballImageEditComponentController,
      this.margin = EdgeInsets.zero,
      this.im001mode,
      this.preSetBallResDto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BallImageEditComponentViewModel(sl(),im001mode,preSetBallResDto,
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
                          SizedBox(
                            width: 16,
                          ),
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
                          SizedBox(
                            width: 16,
                          )
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

  final IM001Mode? im001mode;

  final FBallResDto? preSetBallResDto;
  List<BallImageItem> images = [];

  final BallImageEditComponentController? ballImageEditComponentController;

  final BallImageListUpLoadUseCaseInputPort?
      _ballImageListUpLoadUseCaseInputPort;

  IssueBallDisPlayUseCase? _issueBallDisPlayUseCase;

  BallImageEditComponentViewModel(this._ballImageListUpLoadUseCaseInputPort, this.im001mode, this.preSetBallResDto,
      {this.ballImageEditComponentController}) {
    if (ballImageEditComponentController != null) {
      ballImageEditComponentController!._ballImageEditComponentViewModel = this;
    }
    if(im001mode==IM001Mode.modify){
      _issueBallDisPlayUseCase = IssueBallDisPlayUseCase(fBallResDto: preSetBallResDto!,geoLocatorAdapter: sl());
      images = _issueBallDisPlayUseCase!.getDesImages();
    }
  }

  _removeImage(BallImageItem ballImageItem) {
    images.remove(ballImageItem);
    if (ballImageEditComponentController != null &&
        ballImageEditComponentController!.onChangeItemList != null) {
      ballImageEditComponentController!.onChangeItemList!(images);
    }
    notifyListeners();
  }

  _addImage(ImageProvider imageProvider) async {
    BallImageItem ballImageItem = BallImageItem(imageProvider,sl());
    await ballImageItem.addImage();
    images.add(ballImageItem);
    if (ballImageEditComponentController != null &&
        ballImageEditComponentController!.onChangeItemList != null) {
      ballImageEditComponentController!.onChangeItemList!(images);
    }
    notifyListeners();
  }

  Future<void> _updateImageAndFillImageUrl() async {
    var hasByteImages =
        images.where((element) => element.imageByte != null).toList();
    if (hasByteImages.isNotEmpty) {
      await _ballImageListUpLoadUseCaseInputPort!
          .ballImageListUpLoadAndFillUrls(hasByteImages);
    }
  }

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
  BallImageEditComponentViewModel? _ballImageEditComponentViewModel;

  final Function(List<BallImageItem> ballList)? onChangeItemList;

  final FluttertoastAdapter _fluttertoastAdapter = sl();

  BallImageEditComponentController({this.onChangeItemList});

  addImage(ImageProvider imageProvider) async {
    if (_ballImageEditComponentViewModel!.images.length > 20) {
      _fluttertoastAdapter.showToast(msg: "20개를 초과 하였습니다.");
    }
    if (imageProvider != null) {
      await _ballImageEditComponentViewModel!._addImage(imageProvider);
    }
  }

  int getImageItemCount() {
    if (_ballImageEditComponentViewModel == null) {
      return 0;
    }
    return _ballImageEditComponentViewModel!.images.length;
  }

  getImageItemUrlList() {
    return _ballImageEditComponentViewModel!._getImageItemUrlList();
  }

  Future<void> updateImageAndFillImageUrl() async {
    await _ballImageEditComponentViewModel!._updateImageAndFillImageUrl();
  }

  List<BallImageItem> getBallImageItems() {
    return _ballImageEditComponentViewModel!.images;
  }
}
