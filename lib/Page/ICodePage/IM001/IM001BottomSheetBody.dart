import 'package:flutter/material.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Components/ProfileImageEditComponent/ImageSelectModalBottomSheet.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Component/BallImageEditComponent.dart';
import 'Component/BallImageItem.dart';

class IM001BottomSheetBody extends StatelessWidget {
  final Function(String) onChangeAddress;

  final String initAddress;
  final IM001BottomSheetBodyController im001bottomSheetBodyController;

  const IM001BottomSheetBody(
      {Key key,
      this.initAddress,
      this.onChangeAddress,
      this.im001bottomSheetBodyController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IM001BottomSheetBodyViewModel(
          onChangeAddress, initAddress, im001bottomSheetBodyController),
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
                      height: 24,
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
                            maxLength: 20,
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
                      height: 24,
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
                            controller: model._titleTextController,
                            maxLength: 2000,
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
                      height: 32,
                    ),
                    BallImageEditComponent(
                      ballImageEditComponentController:
                          model.ballImageEditComponentController,
                    ),
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
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: Color(0xff3A3E3F),
                      ),
                      onTap: () {
                        model.imageSelectModalBottomSheet
                            .show(context, "Ball 이미지 선택");
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    CircleIconBtn(
                      width: 42,
                      height: 42,
                      icon: Icon(
                        Icons.picture_in_picture,
                        color: Color(0xff3A3E3F),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    CircleIconBtn(
                      width: 42,
                      height: 42,
                      icon: Icon(
                        Icons.play_circle_fill,
                        color: Color(0xff3A3E3F),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    CircleIconBtn(
                      width: 42,
                      height: 42,
                      icon: Icon(
                        Icons.tag,
                        color: Color(0xff3A3E3F),
                      ),
                      onTap: () {},
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
  String _currentAddress;

  final String initAddress;

  TextEditingController _addressTextController;

  TextEditingController _titleTextController;

  final Function(String) onChangeAddress;

  final IM001BottomSheetBodyController im001bottomSheetBodyController;

  FocusNode titleFocus;

  FocusNode contentFocus;

  BallImageEditComponentController ballImageEditComponentController;

  ImageSelectModalBottomSheet imageSelectModalBottomSheet;

  IM001BottomSheetBodyViewModel(this.onChangeAddress, this.initAddress,
      this.im001bottomSheetBodyController) {
    ballImageEditComponentController = BallImageEditComponentController(
        onChangeItemList: _imageItemListChange);
    imageSelectModalBottomSheet = ImageSelectModalBottomSheet(
        onSelectImage: _onSelectBallImage,
        color: Colors.white,
        isShowBasicImageSelect: false);
    titleFocus = FocusNode();
    titleFocus.addListener(() {
      notifyListeners();
    });

    contentFocus = FocusNode();
    contentFocus.addListener(() {
      notifyListeners();
    });

    if (im001bottomSheetBodyController != null) {
      im001bottomSheetBodyController._im001bottomSheetBodyViewModel = this;
    }
    _currentAddress = initAddress;
    _addressTextController = TextEditingController();
    _addressTextController.text = _currentAddress;
    _addressTextController.addListener(() {
      _currentAddress = _addressTextController.text;
      if (onChangeAddress != null) {
        onChangeAddress(_addressTextController.text);
      }
    });
  }

  get isTitleFocus {
    return titleFocus.hasFocus;
  }

  get isContentFocus {
    return contentFocus.hasFocus;
  }

  int get imageEditComponentImageLength {
    return ballImageEditComponentController.getImageItemCount();
  }

  _imageItemListChange(List<BallImageItem> ballList) {
    notifyListeners();
  }

  _onSelectBallImage(FileImage fileImage) async {
    await ballImageEditComponentController.addImage(fileImage);
    notifyListeners();
  }
}

class IM001BottomSheetBodyController {
  IM001BottomSheetBodyViewModel _im001bottomSheetBodyViewModel;

  changeDisplayAddress(String value) {
    _im001bottomSheetBodyViewModel._addressTextController.text = value;
  }
}
