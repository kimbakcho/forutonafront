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
  final String customscrollmode;
  final String jsondata;
  final ZefyrMode zefyrMode;
  final CubeRichTextController parentcontroller;
  CubeMakeRichTextEdit(
      {Key key,
      this.fcube,
      this.jsondata,
      this.zefyrMode,
      this.custommode,
      this.customscrollmode,
      this.parentcontroller})
      : super(key: key);

  @override
  _CubeMakeRichTextEditState createState() {
    return _CubeMakeRichTextEditState(
        fcube: this.fcube,
        custommode: this.custommode,
        customscrollmode: this.customscrollmode,
        jsondata: this.jsondata,
        zefyrMode: this.zefyrMode,
        parentcontroller: this.parentcontroller);
  }
}

class _CubeMakeRichTextEditState extends State<CubeMakeRichTextEdit> {
  Fcube fcube;
  String custommode;
  String customscrollmode;
  String jsondata;
  ZefyrMode zefyrMode;
  CubeRichTextController parentcontroller;
  _CubeMakeRichTextEditState(
      {this.fcube,
      this.custommode,
      this.customscrollmode,
      this.jsondata,
      this.zefyrMode,
      this.parentcontroller});
  NotusDocument document;
  ZefyrController _wigcontroller;
  FocusNode _focusNode;
  int currentdocumentlenght = 0;

  @override
  void initState() {
    document = _loadDocument();

    if (parentcontroller != null) {
      parentcontroller.document = document;
    }
    currentdocumentlenght = document.length;
    setState(() {
      _wigcontroller = ZefyrController(document);

      _focusNode = FocusNode();
    });
    if (zefyrMode != null && zefyrMode == ZefyrMode.edit) {
      document.changes.listen((data) async {
        /** 임시 이미지 삭제를 위한 코드  */
        bool isdelete = false;
        if (currentdocumentlenght > document.length) {
          isdelete = true;
        }
        currentdocumentlenght = document.length;
        List<Operation> changesitem = data.change.toList();
        if (changesitem.length == 2 &&
            changesitem[0].key == "retain" &&
            changesitem[1].key == "delete" &&
            isdelete) {
          Operation changeitem =
              finddeletetime(changesitem[0].value, data.before.toList());
          if (changeitem.attributes != null &&
              changeitem.attributes.containsKey("embed")) {
            if (changeitem.attributes["embed"]["type"] == "image") {
              print(changeitem.attributes["embed"]["source"]);
              await CustomImageDelegate.cuberelationimagedelete(
                  changeitem.attributes["embed"]["source"]);
            }
          }
        }

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

  Operation finddeletetime(int offset, List<Operation> items) {
    int index = 0;
    for (int i = 0; i < items.length; i++) {
      index += items[i].length;
      if (index > offset) {
        return items[i];
      }
    }
    return null;
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
      custommode: custommode,
      customscrollmode: customscrollmode,
      child: ZefyrEditor(
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
