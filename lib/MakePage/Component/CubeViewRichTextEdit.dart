import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class CubeViewRichTextEdit extends StatefulWidget {
  CubeViewRichTextEdit(Key key) : super(key: key);

  @override
  _CubeViewRichTextEditState createState() {
    return _CubeViewRichTextEditState();
  }
}

class _CubeViewRichTextEditState extends State<CubeViewRichTextEdit> {
  NotusDocument document;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("123"),
    );
  }
}
