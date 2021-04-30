import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Common/ModifiedLengthLimitingTextInputFormatter/ModifiedLengthLimitingTextInputFormatter.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Components/ProfileImageEditComponent/ImageSelectModalBottomSheet.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/YoutubeUrlUploadComponent.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'Component/BallImageEdit/BallImageEditComponent.dart';
import 'Component/BallImageEdit/BallImageItem.dart';
import 'Component/BallTageEdit/BallTagEditComponent.dart';
import 'Component/BallTageEdit/TagEditDto.dart';
import 'IM001Mode.dart';

class IM001BottomSheetBody extends StatelessWidget {
  final Function(String)? onChangeAddress;

  final Function(bool)? onComplete;

  final String? initAddress;
  final IM001BottomSheetBodyController? im001bottomSheetBodyController;

  final IM001Mode? im001mode;

  final FBallResDto? preSetBallResDto;

  final List<FBallTagResDto>? preSetFBallTagResDtos;

  const IM001BottomSheetBody(
      {Key? key,
      this.initAddress,
      this.onChangeAddress,
      this.onComplete,
      this.im001bottomSheetBodyController,
      this.im001mode,
      this.preSetBallResDto,
      this.preSetFBallTagResDtos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IM001BottomSheetBodyViewModel(
          onChangeAddress,
          initAddress,
          onComplete,
          im001bottomSheetBodyController,
          im001mode,
          preSetBallResDto,
          preSetFBallTagResDtos),
      child: Consumer<IM001BottomSheetBodyViewModel>(
        builder: (_, model, child) {
          return Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text("이슈볼 장소",
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: const Color(0xff000000),
                            letterSpacing: -0.28,
                            fontWeight: FontWeight.w700,
                            height: 1.2142857142857142,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: TextField(
                        controller: model._addressTextController,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                        "제목",
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: model.isTitleFocus
                              ? Color(0xff3497FD)
                              : Colors.black,
                          letterSpacing: -0.28,
                          fontWeight: FontWeight.w700,
                          height: 1.2142857142857142,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: TextField(
                            focusNode: model.titleFocus,
                            controller: model._titleTextController,
                            maxLength: 50,
                            inputFormatters: [
                              ModifiedLengthLimitingTextInputFormatter(50)
                            ],
                            decoration: InputDecoration(
                                hintText: "제목을 지어주세요!",
                                hintStyle: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  color: const Color(0xffb1b1b1),
                                  letterSpacing: -0.28,
                                  fontWeight: FontWeight.w300,
                                  height: 1.2142857142857142,
                                )))),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                        "내용",
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: model.isContentFocus
                              ? Color(0xff3497FD)
                              : Colors.black,
                          letterSpacing: -0.28,
                          fontWeight: FontWeight.w700,
                          height: 1.2142857142857142,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: TextField(
                            focusNode: model.contentFocus,
                            controller: model._contentTextController,
                            maxLength: 2500,
                            inputFormatters: [
                              ModifiedLengthLimitingTextInputFormatter(2500)
                            ],
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: "어떤 이슈인가요?",
                                hintStyle: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  color: const Color(0xffb1b1b1),
                                  letterSpacing: -0.28,
                                  fontWeight: FontWeight.w300,
                                  height: 1.2142857142857142,
                                )))),
                    SizedBox(
                      height: 30,
                    ),
                    BallImageEditComponent(
                        margin: EdgeInsets.only(top: 32),
                        ballImageEditComponentController:
                            model.ballImageEditComponentController,
                        im001mode: im001mode,
                        preSetBallResDto: preSetBallResDto),
                    YoutubeUrlUploadComponent(
                      margin: EdgeInsets.only(top: 32, right: 16, left: 16),
                      youtubeUrlUploadComponentController:
                          model.youtubeUrlUploadComponentController,
                      im001mode: im001mode,
                      preSetBallResDto: preSetBallResDto,
                    ),
                    BallTagEditComponent(
                      im001mode: im001mode,
                      preSetFBallTagResDtos: preSetFBallTagResDtos,
                      ballTagEditComponentController:
                          model.ballTagEditComponentController,
                      margin: EdgeInsets.only(left: 16, right: 16, top: 32),
                    )
                  ],
                )),
              )),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE4E7E8), width: 2)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    CircleIconBtn(
                      width: 42,
                      height: 42,
                      color: Color(0xffF6F6F6),
                      isBoxShadow: false,
                      icon: Icon(
                        ForutonaIcon.camera1,
                        size: 20,
                        color: Color(0xff3A3E3F),
                      ),
                      onTap: () {
                        model.selectImage(ImageSource.camera);
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    CircleIconBtn(
                      width: 42,
                      height: 42,
                      color: Color(0xffF6F6F6),
                      isBoxShadow: false,
                      icon: Icon(
                        ForutonaIcon.gallary2,
                        size: 20,
                        color: Color(0xff3A3E3F),
                      ),
                      onTap: () {
                        model.selectImage(ImageSource.gallery);
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    CircleIconBtn(
                      width: 42,
                      height: 42,
                      color: Color(0xffF6F6F6),
                      isBoxShadow: false,
                      icon: model.youtubeUrlUploadComponentController!.isShow()
                          ? Icon(
                              ForutonaIcon.youtube_1,
                              size: 20,
                              color: Colors.red,
                            )
                          : Icon(
                              ForutonaIcon.youtube1,
                              size: 20,
                              color: Color(0xff3A3E3F),
                            ),
                      onTap: () {
                        model.youtubeBtnToggle();
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    CircleIconBtn(
                      width: 42,
                      height: 42,
                      color: Color(0xffF6F6F6),
                      isBoxShadow: false,
                      icon: model.ballTagEditComponentController!.isShow() ?  Icon(
                        ForutonaIcon.tag_im01,
                        color: Color(0xff3497FD),
                      ): Icon(
                        ForutonaIcon.tag,
                        color: Color(0xff3A3E3F),
                      ),
                      onTap: () {
                        model.ballTagEditComponentToggle();
                      },
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class IM001BottomSheetBodyViewModel extends ChangeNotifier {
  String? _currentAddress;

  final String? initAddress;

  TextEditingController? _addressTextController;

  TextEditingController? _titleTextController;

  TextEditingController? _contentTextController;

  final Function(String)? onChangeAddress;

  final IM001BottomSheetBodyController? im001bottomSheetBodyController;

  YoutubeUrlUploadComponentController? youtubeUrlUploadComponentController;

  FocusNode? titleFocus;

  FocusNode? contentFocus;

  BallImageEditComponentController? ballImageEditComponentController;

  BallTagEditComponentController? ballTagEditComponentController;

  final _picker = ImagePicker();

  final Function(bool)? onComplete;

  final IM001Mode? im001mode;

  final FBallResDto? preSetBallResDto;

  final List<FBallTagResDto>? preSetFBallTagResDtos;

  IssueBallDisPlayUseCase? _issueBallDisPlayUseCase;

  IM001BottomSheetBodyViewModel(
      this.onChangeAddress,
      this.initAddress,
      this.onComplete,
      this.im001bottomSheetBodyController,
      this.im001mode,
      this.preSetBallResDto,
      this.preSetFBallTagResDtos) {
    _titleTextController = TextEditingController();

    _titleTextController!.addListener(() {
      _checkComplete();
    });

    _contentTextController = TextEditingController();

    _contentTextController!.addListener(() {
      _checkComplete();
    });

    youtubeUrlUploadComponentController = YoutubeUrlUploadComponentController();

    ballImageEditComponentController = BallImageEditComponentController(
        onChangeItemList: _imageItemListChange);

    ballTagEditComponentController = BallTagEditComponentController();

    titleFocus = FocusNode();
    titleFocus!.addListener(() {
      notifyListeners();
    });

    contentFocus = FocusNode();
    contentFocus!.addListener(() {
      notifyListeners();
    });

    if (im001bottomSheetBodyController != null) {
      im001bottomSheetBodyController!._im001bottomSheetBodyViewModel = this;
    }
    _currentAddress = initAddress;
    _addressTextController = TextEditingController();
    _addressTextController!.text = _currentAddress!;
    _addressTextController!.addListener(() {
      _currentAddress = _addressTextController!.text;
      if (onChangeAddress != null) {
        onChangeAddress!(_addressTextController!.text);
      }
      _checkComplete();
    });

    if (im001mode == IM001Mode.modify) {
      _issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
          fBallResDto: preSetBallResDto!, geoLocatorAdapter: sl());
      _titleTextController!.text = _issueBallDisPlayUseCase!.ballName();
      _contentTextController!.text = _issueBallDisPlayUseCase!.descriptionText();
      _addressTextController!.text = _issueBallDisPlayUseCase!.placeAddress();
      _checkComplete();
    }
  }

  get isTitleFocus {
    return titleFocus!.hasFocus;
  }

  get isContentFocus {
    return contentFocus!.hasFocus;
  }

  _checkComplete() {
    if (_titleTextController!.text.isNotEmpty &&
        _addressTextController!.text.isNotEmpty &&
        _contentTextController!.text.isNotEmpty) {
      this.onComplete!(true);
    } else {
      this.onComplete!(false);
    }
  }

  int get imageEditComponentImageLength {
    return ballImageEditComponentController!.getImageItemCount();
  }

  _imageItemListChange(List<BallImageItem?> ballList) {
    notifyListeners();
  }

  _onSelectBallImage(FileImage fileImage) async {
    await ballImageEditComponentController!.addImage(fileImage);
    notifyListeners();
  }

  void selectImage(ImageSource imageSource) async {
    var pickedFile = await _picker.getImage(source: imageSource);
    if (pickedFile != null) {
      var _image = File(pickedFile.path);
      _onSelectBallImage(FileImage(_image));
    }
  }

  void youtubeBtnToggle() {
    youtubeUrlUploadComponentController!.toggle();
    notifyListeners();
  }

  void ballTagEditComponentToggle() {
    ballTagEditComponentController!.toggle();
    notifyListeners();
  }
}

class IM001BottomSheetBodyController {
  IM001BottomSheetBodyViewModel? _im001bottomSheetBodyViewModel;

  changeDisplayAddress(String value) {
    _im001bottomSheetBodyViewModel!._addressTextController!.text = value;
  }

  String getBallName() {
    return _im001bottomSheetBodyViewModel!._titleTextController!.text;
  }

  String getPlaceAddress() {
    return _im001bottomSheetBodyViewModel!._currentAddress!;
  }

  String getContent() {
    return _im001bottomSheetBodyViewModel!._contentTextController!.text;
  }

  String getYoutubeId() {
    return _im001bottomSheetBodyViewModel!.youtubeUrlUploadComponentController!
        .getYoutubeId();
  }

  List<BallImageItem?> getBallImages() {
    return _im001bottomSheetBodyViewModel!.ballImageEditComponentController!
        .getBallImageItems();
  }

  Future<List<BallImageItem?>> updateImageAndFillImageUrl() async {
    await _im001bottomSheetBodyViewModel!.ballImageEditComponentController!
        .updateImageAndFillImageUrl();
    return getBallImages();
  }

  List<TagEditItemDto> getTags() {
    return _im001bottomSheetBodyViewModel!.ballTagEditComponentController!
        .getTags();
  }
}
