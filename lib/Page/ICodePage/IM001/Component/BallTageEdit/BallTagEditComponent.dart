import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Common/ModifiedLengthLimitingTextInputFormatter/ModifiedLengthLimitingTextInputFormatter.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallTageEdit/BallEditTagChip.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallTageEdit/TagEditDto.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001Mode.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BallTagEditComponent extends StatelessWidget {
  final EdgeInsets margin;

  final IM001Mode im001mode;

  final List<FBallTagResDto> preSetFBallTagResDtos;

  final BallTagEditComponentController ballTagEditComponentController;

  const BallTagEditComponent(
      {Key key,
      this.margin = EdgeInsets.zero,
      this.ballTagEditComponentController,
      this.im001mode,
      this.preSetFBallTagResDtos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BallTagEditComponentViewModel(
            this.ballTagEditComponentController,
            im001mode,
            preSetFBallTagResDtos),
        child:
            Consumer<BallTagEditComponentViewModel>(builder: (_, model, child) {
          return model.isShow
              ? Container(
                  margin: margin,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "#태그",
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: model.isEditFocus
                                  ? Color(0xff3497FD)
                                  : Colors.black,
                              letterSpacing: -0.28,
                              fontWeight: FontWeight.w700,
                              height: 1.2142857142857142,
                            ),
                          ),
                        ),
                        TextField(
                          controller: model._tagTextEditingController,
                          maxLength: 10,
                          maxLengthEnforced: true,
                          onChanged: model._onTagTextChange,
                          focusNode: model.editFocus,
                          onSubmitted: (value) {
                            model.addTag(value);
                          },
                          inputFormatters: [
                            ModifiedLengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.deny(RegExp(r'''[\{\}\[\]\/?.;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"\s]''''')),
                          ],
                          decoration: InputDecoration(
                              hintStyle: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xffb1b1b1),
                                letterSpacing: -0.28,
                                fontWeight: FontWeight.w300,
                                height: 1.2142857142857142,
                              ),
                              hintText: "태그를 입력해주세요."),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Wrap(
                                spacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: model.ballEditTagChips))
                      ]))
              : Container();
        }));
  }
}

class BallTagEditComponentViewModel extends ChangeNotifier {
  TextEditingController _tagTextEditingController;

  final BallTagEditComponentController ballTagEditComponentController;

  final List<BallEditTagChip> ballEditTagChips = [];

  final IM001Mode im001mode;

  final List<FBallTagResDto> preSetFBallTagResDtos;

  FocusNode editFocus;

  bool isShow = false;

  BallTagEditComponentViewModel(this.ballTagEditComponentController,
      this.im001mode, this.preSetFBallTagResDtos) {
    _tagTextEditingController = TextEditingController();


    if (ballTagEditComponentController != null) {
      ballTagEditComponentController._viewModel = this;
    }
    editFocus = FocusNode();
    editFocus.addListener(() {
      notifyListeners();
    });
    if (im001mode == IM001Mode.modify) {
      if (preSetFBallTagResDtos != null && preSetFBallTagResDtos.length > 0) {
        preSetFBallTagResDtos.forEach((element) {
          addTag(element.tagItem);
        });
        isShow = true;
      }
    }
  }

  _onTagTextChange(String tagValue){
    print(tagValue);
    if(tagValue.isNotEmpty){
      print(tagValue.indexOf(","));
      if(tagValue.indexOf(",")>0){
        _tagTextEditingController.clear();
        var tagText = tagValue.replaceAll(",","");
        addTag(tagText);
      }
    }

  }


  get isEditFocus {
    return editFocus.hasFocus;
  }

  _toggle() {
    isShow = !isShow;
    notifyListeners();
  }

  void addTag(String value) {
    if (ballEditTagChips.length >= 10) {
      Fluttertoast.showToast(msg: "태그가 10를 초과 하였습니다.");
      return;
    }

    bool hasTagFlag =false;

    ballEditTagChips.forEach((element) {
      if(element.tagEditItemDto.text==value){
        hasTagFlag = true;
      }
    });

    if(hasTagFlag){
      Fluttertoast.showToast(msg: "이미 입력된 태그입니다.");
      return;
    }

    ballEditTagChips.add(BallEditTagChip(
        tagEditItemDto: TagEditItemDto(value), onDeleteTap: _onDeleteTagChip));
    _tagTextEditingController.clear();
    notifyListeners();
  }

  _onDeleteTagChip(BallEditTagChip widget) {
    ballEditTagChips.remove(widget);
    notifyListeners();
  }
}

class BallTagEditComponentController {
  BallTagEditComponentViewModel _viewModel;

  toggle() {
    _viewModel._toggle();
  }

  isShow(){
    return _viewModel.isShow;
  }

  List<TagEditItemDto> getTags() {
    var list =
        _viewModel.ballEditTagChips.map((e) => e.tagEditItemDto).toList();
    return list;
  }

  addTags(FBallTagResDto tagItems) {
    _viewModel.addTag(tagItems.tagItem);
  }
}
