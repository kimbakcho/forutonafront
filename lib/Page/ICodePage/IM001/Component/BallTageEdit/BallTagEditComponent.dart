import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallTageEdit/BallEditTagChip.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallTageEdit/TagEditDto.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BallTagEditComponent extends StatelessWidget {
  final EdgeInsets margin;

  final BallTagEditComponentController ballTagEditComponentController;

  const BallTagEditComponent(
      {Key key,
      this.margin = EdgeInsets.zero,
      this.ballTagEditComponentController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            BallTagEditComponentViewModel(this.ballTagEditComponentController),
        child:
            Consumer<BallTagEditComponentViewModel>(builder: (_, model, child) {
          return model.isShow ? Container(
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
                      controller: model._textEditingController,
                      focusNode: model.editFocus,
                      onSubmitted: (value) {
                        model.addTag(value);
                      },
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
                  ])) : Container();
        }));
  }
}

class BallTagEditComponentViewModel extends ChangeNotifier {
  TextEditingController _textEditingController;

  final BallTagEditComponentController ballTagEditComponentController;

  final List<BallEditTagChip> ballEditTagChips = [];

  FocusNode editFocus;

  bool isShow = false;

  BallTagEditComponentViewModel(this.ballTagEditComponentController) {
    _textEditingController = TextEditingController();
    if (ballTagEditComponentController != null) {
      ballTagEditComponentController._viewModel = this;
    }
    editFocus = FocusNode();
    editFocus.addListener(() {
      notifyListeners();
    });
  }

  get isEditFocus {
    return editFocus.hasFocus;
  }

  _toggle() {
    isShow = !isShow;
    notifyListeners();
  }

  void addTag(String value) {

    if(ballEditTagChips.length > 10){
      Fluttertoast.showToast(msg: "태그가 10를 초과 하였습니다.");
      return;
    }

    ballEditTagChips.add(BallEditTagChip(
        tagEditItemDto: TagEditItemDto(value), onDeleteTap: _onDeleteTagChip));
    _textEditingController.clear();
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
}
