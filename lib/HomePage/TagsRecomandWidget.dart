import 'package:flutter/material.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';

class TagsRecomandWidget extends StatefulWidget {
  TagsRecomandWidget({this.tagsController, Key key}) : super(key: key);
  final TagsController tagsController;

  @override
  _TagsRecomandWidgetState createState() {
    return _TagsRecomandWidgetState(tagsController: tagsController);
  }
}

class _TagsRecomandWidgetState extends State<TagsRecomandWidget> {
  _TagsRecomandWidgetState({this.tagsController});
  TagsController tagsController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: tagsController.taglists.length,
                itemBuilder: (context, index) {
                  if (index == tagsController.currentindex) {
                    return Container(
                        margin: EdgeInsets.fromLTRB(16, 10, 0, 10),
                        child: InkWell(
                          onTap: () {
                            tagsController.currentindex = index;
                            tagsController
                                .onchangeindex(tagsController.currentindex);
                            tagsController.currenttag =
                                tagsController.taglists[index];
                            tagsController
                                .onchangetag(tagsController.currenttag);
                            setState(() {});
                          },
                          child: Text("#${tagsController.taglists[index]}",
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xff454f63),
                              )),
                        ));
                  } else {
                    return Container(
                        margin: EdgeInsets.fromLTRB(16, 10, 0, 10),
                        child: InkWell(
                          onTap: () {
                            tagsController.currentindex = index;
                            tagsController
                                .onchangeindex(tagsController.currentindex);
                            tagsController.currenttag =
                                tagsController.taglists[index];
                            tagsController
                                .onchangetag(tagsController.currenttag);
                            setState(() {});
                          },
                          child: Text(tagsController.taglists[index],
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xffe4e7e8),
                              )),
                        ));
                  }
                }),
          ),
          Container(
            child: Wrap(
              children: <Widget>[],
            ),
          )
        ],
      ),
    );
  }
}

class TagsController {
  int currentindex;
  List<String> taglists;
  String currenttag;
  List<FcubeExtender1> currentFcubelist;
  Function(int) onchangeindex = (value) {};
  Function(String) onchangetag = (value) {};
  TagsController() {
    currentindex = 0;
  }
}
