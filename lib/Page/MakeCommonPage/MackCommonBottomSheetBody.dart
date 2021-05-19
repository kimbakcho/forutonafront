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
import 'package:forutonafront/Page/MakeCommonPage/MakeCommonBottomSheetHeader.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../ICodePage/IM001/Component/BallImageEdit/BallImageEditComponent.dart';
import '../ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';
import '../ICodePage/IM001/Component/BallTageEdit/BallTagEditComponent.dart';
import '../ICodePage/IM001/Component/BallTageEdit/TagEditDto.dart';
import 'MakePageMode.dart';


class MackCommonBottomSheetBody extends StatefulWidget {
  final Function(String)? onChangeAddress;

  final Function(bool)? onComplete;

  final String ballName;

  final String ballContentDescription;

  final String? initAddress;

  final MakeCommonBottomSheetBodyController makeCommonBottomSheetBodyController;

  final MakePageMode? makePageMode;

  final FBallResDto? preSetBallResDto;

  final List<FBallTagResDto>? preSetFBallTagResDtos;

  MackCommonBottomSheetBody(
      {Key? key,
        this.initAddress,
        this.onChangeAddress,
        this.onComplete,
        required this.makeCommonBottomSheetBodyController,
        this.makePageMode,
        this.preSetBallResDto,
        this.preSetFBallTagResDtos, required this.ballName,required this.ballContentDescription})
      : super(key: key);

  @override
  _MackCommonBottomSheetBodyState createState() => _MackCommonBottomSheetBodyState();
}

class _MackCommonBottomSheetBodyState extends State<MackCommonBottomSheetBody> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MakeCommonBottomSheetBodyViewModel(
          widget.onChangeAddress,
          widget.initAddress,
          widget.onComplete,
          widget.makeCommonBottomSheetBodyController,
          widget.makePageMode,
          widget.preSetBallResDto,
          widget.preSetFBallTagResDtos),
      child: Consumer<MakeCommonBottomSheetBodyViewModel>(
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
                              child: Text("${widget.ballName} 장소",
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
                                    autofocus: false,
                                    autocorrect: false,
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
                                    autofocus: false,
                                    autocorrect: false,
                                    focusNode: model.contentFocus,
                                    controller: model._contentTextController,
                                    maxLength: 2500,
                                    inputFormatters: [
                                      ModifiedLengthLimitingTextInputFormatter(2500)
                                    ],
                                    maxLines: null,
                                    decoration: InputDecoration(
                                        hintText: widget.ballContentDescription,
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
                                im001mode: widget.makePageMode,
                                preSetBallResDto: widget.preSetBallResDto),
                            YoutubeUrlUploadComponent(
                              margin: EdgeInsets.only(top: 32, right: 16, left: 16),
                              youtubeUrlUploadComponentController:
                              model.youtubeUrlUploadComponentController,
                              im001mode: widget.makePageMode,
                              preSetBallResDto: widget.preSetBallResDto,
                            ),
                            BallTagEditComponent(
                              im001mode: widget.makePageMode,
                              preSetFBallTagResDtos: widget.preSetFBallTagResDtos,
                              ballTagEditComponentController:
                              model.ballTagEditComponentController,
                              margin: EdgeInsets.only(left: 16, right: 16, top: 32),
                            )
                          ],
                        )),
                  )),
              Container(
                height: 60,
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Color(0xffE4E7E8), width: 1))),
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
          )
          ;
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}

class MakeCommonBottomSheetBodyViewModel extends ChangeNotifier {
  String? _currentAddress;

  final String? initAddress;

  TextEditingController? _addressTextController;

  TextEditingController? _titleTextController;

  TextEditingController? _contentTextController;

  final Function(String)? onChangeAddress;

  final MakeCommonBottomSheetBodyController? im001bottomSheetBodyController;

  YoutubeUrlUploadComponentController? youtubeUrlUploadComponentController;

  FocusNode? titleFocus;

  FocusNode? contentFocus;

  BallImageEditComponentController? ballImageEditComponentController;

  BallTagEditComponentController? ballTagEditComponentController;

  final _picker = ImagePicker();

  final Function(bool)? onComplete;

  final MakePageMode? makePageMode;

  final FBallResDto? preSetBallResDto;

  final List<FBallTagResDto>? preSetFBallTagResDtos;

  IssueBallDisPlayUseCase? _issueBallDisPlayUseCase;

  MakeCommonBottomSheetBodyViewModel(
      this.onChangeAddress,
      this.initAddress,
      this.onComplete,
      this.im001bottomSheetBodyController,
      this.makePageMode,
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
      im001bottomSheetBodyController!._makeCommonBottomSheetBodyViewModel = this;
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

    if (makePageMode == MakePageMode.modify) {
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
  void changeDisplayAddress(String value) {
    _addressTextController!.text = value;
    notifyListeners();
  }
}

class MakeCommonBottomSheetBodyController {
  MakeCommonBottomSheetBodyViewModel? _makeCommonBottomSheetBodyViewModel;

  changeDisplayAddress(String value) {
    _makeCommonBottomSheetBodyViewModel!.changeDisplayAddress(value);
  }

  String getBallName() {
    return _makeCommonBottomSheetBodyViewModel!._titleTextController!.text;
  }

  String getPlaceAddress() {
    return _makeCommonBottomSheetBodyViewModel!._currentAddress!;
  }

  String getContent() {
    return _makeCommonBottomSheetBodyViewModel!._contentTextController!.text;
  }

  String getYoutubeId() {
    return _makeCommonBottomSheetBodyViewModel!.youtubeUrlUploadComponentController!
        .getYoutubeId();
  }

  List<BallImageItem?> getBallImages() {
    return _makeCommonBottomSheetBodyViewModel!.ballImageEditComponentController!
        .getBallImageItems();
  }

  Future<List<BallImageItem?>> updateImageAndFillImageUrl() async {
    await _makeCommonBottomSheetBodyViewModel!.ballImageEditComponentController!
        .updateImageAndFillImageUrl();
    return getBallImages();
  }

  List<TagEditItemDto> getTags() {
    return _makeCommonBottomSheetBodyViewModel!.ballTagEditComponentController!
        .getTags();
  }

}
