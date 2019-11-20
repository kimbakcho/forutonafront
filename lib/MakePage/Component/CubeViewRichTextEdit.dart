import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class CubeViewRichTextEdit extends StatefulWidget {
  CubeViewRichTextEdit(Key key) : super(key: key);

  @override
  _CubeViewRichTextEditState createState() {
    _CubeViewRichTextEditState();
  }
}

class _CubeViewRichTextEditState extends State<CubeViewRichTextEdit> {
  ZefyrController _controller;
  NotusDocument document;
  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("123"),
    );
  }
}
