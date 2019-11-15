import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/CustomImageDelegate.dart';

import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:zefyr/zefyr.dart';

class CubeRichTextController {
  Function ontoolbarshow;
  Function ondatacahnge;
  bool isedithint;
  NotusDocument document;
}

class CubeMakeRichTextEdit extends StatefulWidget {
  final Fcube fcube;
  final String custommode;
  final CubeRichTextController parentcontroller;
  CubeMakeRichTextEdit(
      {Key key, this.fcube, this.custommode, this.parentcontroller})
      : super(key: key);

  @override
  _CubeMakeRichTextEditState createState() {
    return _CubeMakeRichTextEditState(
        fcube: this.fcube,
        custommode: this.custommode,
        parentcontroller: this.parentcontroller);
  }
}

class _CubeMakeRichTextEditState extends State<CubeMakeRichTextEdit> {
  Fcube fcube;
  String custommode;
  CubeRichTextController parentcontroller;
  _CubeMakeRichTextEditState(
      {this.fcube, this.custommode, this.parentcontroller});
  NotusDocument document;
  ZefyrController _wigcontroller;
  FocusNode _focusNode;

  @override
  void initState() {
    document = _loadDocument();
    parentcontroller.document = document;

    setState(() {
      _wigcontroller = ZefyrController(document);

      _focusNode = FocusNode();
    });
    document.changes.listen((data) async {
      data.before.toList().forEach((item) async {
        if (item.attributes != null && item.attributes.containsKey("embed")) {
          if (item.attributes["embed"]["type"] == "image") {
            print(item.attributes["embed"]["source"]);
            await CustomImageDelegate.cuberelationimagedelete(
                item.attributes["embed"]["source"]);
          }
        }
      });
      if (document.length > 0) {
        if (parentcontroller.isedithint != null) {
          parentcontroller.isedithint = false;
        }
      } else {
        if (parentcontroller.isedithint != null) {
          parentcontroller.isedithint = true;
        }
      }
      if (parentcontroller.ondatacahnge != null) {
        parentcontroller.ondatacahnge(data);
      }
    });
    super.initState();
  }

  NotusDocument _loadDocument() {
    return NotusDocument();
  }

  @override
  Widget build(BuildContext context) {
    return ZefyrScaffold(
      child: ZefyrEditor(
        custommode: custommode,
        autofocus: false,
        padding: EdgeInsets.all(16),
        imageDelegate: CustomImageDelegate(cube: fcube),
        controller: _wigcontroller,
        focusNode: _focusNode,
        ontoolbarshow: () {
          if (parentcontroller.ontoolbarshow != null) {
            parentcontroller.ontoolbarshow();
          }
        },
      ),
    );
  }
}
