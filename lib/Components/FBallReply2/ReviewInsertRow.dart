import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReviewTextActionRow extends StatelessWidget {
  final ImageProvider userProfileImage;
  final bool autoFocus;
  final ReviewTextActionRowController reviewTextActionRowController;
  final Function(String) actionReply;
  final String ballUuid;
  final EdgeInsetsGeometry padding;

  const ReviewTextActionRow(
      {Key key,
      this.userProfileImage,
      this.autoFocus,
      this.reviewTextActionRowController,
      this.actionReply,
        this.padding,
      this.ballUuid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ReviewTextActionRowViewModel(reviewTextActionRowController: reviewTextActionRowController),
        child: Consumer<ReviewTextActionRowViewModel>(builder: (_, model, __) {
          return Container(
              color: Colors.white,
              padding: padding,
              child: Row(children: <Widget>[
                Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(image: userProfileImage))),
                Expanded(
                  child: Container(
                    width: 300,
                    child: TextField(
                      minLines: 1,
                      maxLines: 4,
                      focusNode: model.replyTextFocusNode,
                      autocorrect: false,
                      onAppPrivateCommand: (value, value1) {
                        print("onAppPrivateCommand");
                        print(value);
                      },
                      decoration: InputDecoration(
                        hintText: "댓글 입력하기",
                          hintStyle: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: const Color(0xffcccccc),
                            height: 1,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0, color: Colors.white)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(width: 0, color: Colors.white))
                      ),
                      keyboardType: TextInputType.multiline,
                      autofocus: autoFocus,
                      controller: model.replyTextEditController,
                      cursorColor: Color(0xff3497FD),
                    ),
                  ),
                ),
                Container(
                    height: 30,
                    width: 30,
                    child: FlatButton(
                      padding: EdgeInsets.all(0).add(EdgeInsets.only(right: 4)),
                      onPressed: () {
                        actionReply(ballUuid);
                      },
                      child: Icon(
                        ForutonaIcon.replysendicon,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: model.isReplyTextEmpty
                          ? Color(0xffCCCCCC)
                          :  Color(0xff007EFF),
                    ))
              ]));
        }));
  }
}

class ReviewTextActionRowViewModel extends ChangeNotifier {

  TextEditingController replyTextEditController;

  FocusNode replyTextFocusNode = FocusNode();

  final ReviewTextActionRowController reviewTextActionRowController;

  ReviewTextActionRowViewModel({this.reviewTextActionRowController}){
    replyTextEditController = TextEditingController();
    if(reviewTextActionRowController != null){
      reviewTextActionRowController._viewModel = this;
    }
    if(reviewTextActionRowController != null && reviewTextActionRowController.initReplyText != null){
      replyTextEditController.text = reviewTextActionRowController.initReplyText;
    }

    replyTextEditController.addListener(() {
      changeReplyText();
    });


  }
  changeReplyText(){
    notifyListeners();
    if(reviewTextActionRowController!= null && reviewTextActionRowController.changeText != null){
      reviewTextActionRowController.changeText(replyTextEditController.text);
    }
  }

  get isReplyTextEmpty {
    return replyTextEditController.text.isEmpty;
  }

  get _replyText {
    return replyTextEditController.text;
  }

  _textFieldUnFocus(){
    replyTextFocusNode.unfocus();
  }
}

class ReviewTextActionRowController  {

  ReviewTextActionRowViewModel _viewModel;

  Function(String) changeText;

  final String initReplyText;

  ReviewTextActionRowController({this.initReplyText});

  get replyText {
    if(_viewModel != null){
      return _viewModel._replyText;
    }else {
      return "";
    }
  }
  textFieldUnFocus(){
    _viewModel._textFieldUnFocus();
  }
}