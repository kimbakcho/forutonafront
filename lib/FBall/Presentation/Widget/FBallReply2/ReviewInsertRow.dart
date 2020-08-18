import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class ReviewTextActionRow extends StatelessWidget {
  final String userProfileImageUrl;
  final FocusNode replyTextFocusNode;
  final bool autoFocus;
  final TextEditingController replyTextEditController;
  final Function(String) actionReply;
  final String ballUuid;

  const ReviewTextActionRow(
      {Key key,
      this.userProfileImageUrl,
      this.replyTextFocusNode,
      this.autoFocus,
      this.replyTextEditController,
      this.actionReply, this.ballUuid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(children: <Widget>[
        Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: NetworkImage(userProfileImageUrl)))),
        Expanded(
          child: Container(
            width: 300,
            child: TextField(
              minLines: 1,
              maxLines: 3,
              focusNode: replyTextFocusNode,
              autocorrect: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white))),
              keyboardType: TextInputType.multiline,
              autofocus: autoFocus,
              controller: replyTextEditController,
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
            color: Color(0xff007EFF),
          ),
        )
      ]),
    );
  }
}
