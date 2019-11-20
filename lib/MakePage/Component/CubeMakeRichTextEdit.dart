import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/CustomImageDelegate.dart';

import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class CubeRichTextController {
  Function ontoolbarshow;
  Function ondatacahnge;
  bool isedithint;
  NotusDocument document;
  bool autofocus = false;
}

class CubeMakeRichTextEdit extends StatefulWidget {
  final Fcube fcube;
  final String custommode;
  final String jsondata;
  final ZefyrMode zefyrMode;
  final CubeRichTextController parentcontroller;
  CubeMakeRichTextEdit(
      {Key key,
      this.fcube,
      this.jsondata,
      this.zefyrMode,
      this.custommode,
      this.parentcontroller})
      : super(key: key);

  @override
  _CubeMakeRichTextEditState createState() {
    return _CubeMakeRichTextEditState(
        fcube: this.fcube,
        custommode: this.custommode,
        jsondata: this.jsondata,
        zefyrMode: this.zefyrMode,
        parentcontroller: this.parentcontroller);
  }
}

class _CubeMakeRichTextEditState extends State<CubeMakeRichTextEdit> {
  Fcube fcube;
  String custommode;
  String jsondata;
  ZefyrMode zefyrMode;
  CubeRichTextController parentcontroller;
  _CubeMakeRichTextEditState(
      {this.fcube,
      this.custommode,
      this.jsondata,
      this.zefyrMode,
      this.parentcontroller});
  NotusDocument document;
  ZefyrController _wigcontroller;
  FocusNode _focusNode;

  @override
  void initState() {
    document = _loadDocument();
    if (parentcontroller != null) {
      parentcontroller.document = document;
    }

    setState(() {
      _wigcontroller = ZefyrController(document);

      _focusNode = FocusNode();
    });
    if (zefyrMode != null && zefyrMode == ZefyrMode.edit) {
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
    }

    super.initState();
  }

  NotusDocument _loadDocument() {
    if (jsondata != null) {
      return NotusDocument.fromJson(jsonDecode(jsondata));
    } else {
      return NotusDocument();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZefyrScaffold(
      child: ZefyrEditor(
        custommode: custommode,
        mode: zefyrMode != null ? zefyrMode : ZefyrMode.edit,
        autofocus:
            parentcontroller != null ? parentcontroller.autofocus : false,
        padding: EdgeInsets.all(16),
        imageDelegate: CustomImageDelegate(cube: fcube),
        controller: _wigcontroller,
        focusNode: _focusNode,
        ontoolbarshow: () {
          if (parentcontroller != null) {
            if (parentcontroller.ontoolbarshow != null) {
              parentcontroller.ontoolbarshow();
            }
          }
        },
      ),
    );
  }
}
