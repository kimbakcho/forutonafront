import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001MainPageViewModelTemp.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'Component/BallImageEdit/BallImageItem.dart';


// ignore: must_be_immutable
class IM001MainPageTemp extends StatefulWidget {
  LatLng setUpPosition;
  String address;
  String ballUuid;
  IM001MainPageEnterMode mode;

  IM001MainPageTemp(this.setUpPosition, this.address, this.ballUuid, this.mode);

  @override
  _IM001MainPageTempState createState() => _IM001MainPageTempState(
      this.setUpPosition, this.address, this.ballUuid, this.mode);
}

class _IM001MainPageTempState extends State<IM001MainPageTemp>
    with WidgetsBindingObserver {

  LatLng setUpPosition;
  String address;
  String ballUuid;
  IM001MainPageEnterMode mode;
  IM001MainPageViewModelTemp childModel;
  UniqueKey googleMapKey = UniqueKey();

  _IM001MainPageTempState(
      this.setUpPosition, this.address, this.ballUuid, this.mode);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    googleMapKey = UniqueKey();
    if (childModel != null) {
      await childModel.copyClipBoard();
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IM001MainPageViewModelTemp(
            context: context,
            ballUuid: ballUuid,
            selectBallUseCaseInputPort: sl(),
            ballImageListUpLoadUseCaseInputPort: sl(),
            address: address,
            mode: mode,
            setUpPosition: setUpPosition),
        child: Consumer<IM001MainPageViewModelTemp>(builder: (_, model, child) {
          childModel = model;
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Column(children: <Widget>[
                        topBar(model),
                        Expanded(
                            child: ListView(
                                controller: model.mainScrollController,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 60),
                                children: <Widget>[
                              googleMapBar(model, context),
                              titleLabelBar(model),
                              titleEditBar(model),
                              contentDivider(),
                              textContentLabel(model),
                              textContentEditBar(model),
                              contentDivider(),
                              imageListBar(model),
                              youtubeBar(model),
                              tagBar(model, context),
                            ]))
                      ]),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: bottomBar(model, context),
                      ),
                    ]))),
            model.isLoading ? CommonLoadingComponent() : Container()
          ]);
        }));
  }

  Container tagBar(IM001MainPageViewModelTemp model, BuildContext context) {
    return model.tagBarVisibility
        ? Container(
            child: Column(children: <Widget>[
            tagTopLabelBar(model),
            tagEditTextBar(model),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 10,
                  children: model.tagChips,
                ))
          ]))
        : Container();
  }

  Container tagEditTextBar(IM001MainPageViewModelTemp model) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: TextFormField(
          autocorrect: false,
          enableSuggestions: false,
          focusNode: model.tagEditFocusNode,
          controller: model.tagEditController,
          maxLength: 10,
          onChanged: model.onTagTextChanged,
          onFieldSubmitted: model.onTagFieldSubmitted,
          decoration: InputDecoration(
              counter: Container(width: 0, height: 0),
              labelStyle: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Color(0xff3497fd),
              ),
              hintText: "태그를 입력해 주세요(000, 로 구분합니다.)",
              hintStyle: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xffe4e7e8),
              ),
              contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE4E7E8)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffE4E7E8)),
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE4E7E8))))),
    );
  }

  Container tagTopLabelBar(IM001MainPageViewModelTemp model) {
    return Container(
      child: Row(children: <Widget>[
        Container(
            child: Text("#태그",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: model.tagEditFocusNode.hasFocus
                      ? Color(0xff3497FD)
                      : Color(0xff454f63),
                ))),
        Spacer(),
        Container(
            child: model.tagEditFocusNode.hasFocus
                ? Text("${model.tagChips.length}/10",
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Color(0xffb1b1b1)))
                : Container())
      ]),
      padding: EdgeInsets.fromLTRB(16, 31, 16, 10),
    );
  }

  Container youtubeBar(IM001MainPageViewModelTemp model) {
    return model.youtubeAttachVisibility
        ? Container(
            height: 99,
            width: 360,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 17,
                    left: 16,
                    child: Text("YOUTUBE 동영상 첨부",
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff454f63),
                        ))),
                Positioned(
                    top: 45,
                    left: 16,
                    child: Container(
                        width: MediaQuery.of(context).size.width - 120,
                        child: model.validYoutubeLink == null
                            ? Text("동영상 링크를 복사해서 붙혀넣기 하세요.",
                                style: GoogleFonts.notoSans(
                                  fontSize: 13,
                                  color: Color(0xff78849e),
                                ))
                            : Text(model.validYoutubeLink,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  color: Color(0xff78849e),
                                )))),
                Positioned(top: 37, right: 16, child: youtubeActionBtn(model))
              ],
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffE4E7E8), width: 1))),
          )
        : Container();
  }

  Container youtubeActionBtn(IM001MainPageViewModelTemp model) {
    if (model.currentClipBoardData == null) {
      //비활성화 상태
      return Container(
          height: 27.00,
          width: 73.00,
          child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Text("붙혀넣기",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: Color(0xffcccccc),
                  )),
              onPressed: () {}),
          decoration: BoxDecoration(
            color: Color(0xffe4e7e8),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              ),
            ],
            borderRadius: BorderRadius.circular(13.00),
          ));
    } else if (model.currentClipBoardData != null &&
        model.validYoutubeLink == null) {
      //붙혀 넣기 가능한 상태
      return Container(
          height: 27.00,
          width: 73.00,
          child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Text("붙혀넣기",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: Color(0xffffffff),
                  )),
              onPressed: () {
                model.validYoutubeLinkCheck();
              }),
          decoration: BoxDecoration(
              color: Color(0xff8382F2),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Color(0xff000000).withOpacity(0.16),
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(13.00)));
    } else if (model.validYoutubeLink != null) {
      //youtube Link 까지 입력된 상태
      return Container(
          height: 27.00,
          width: 73.00,
          child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Text("삭제",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: Color(0xffffffff),
                  )),
              onPressed: () {
                model.deleteYoutubeLink();
              }),
          decoration: BoxDecoration(
              color: Color(0xffFF4F9A),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Color(0xff000000).withOpacity(0.16),
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(13.00)));
    } else {
      return Container();
    }
  }

  Container imageListBar(IM001MainPageViewModelTemp model) {
    return model.ballImageList.length != 0
        ? Container(
            height: 124,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 16,
                  left: 16,
                  child: Text("이미지",
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff454f63)))),
              Positioned(
                  top: 16,
                  right: 16,
                  child: Text("${model.ballImageList.length}/20",
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Color(0xffb1b1b1),
                      ))),
              Positioned(
                  top: 40,
                  left: 0,
                  child: Container(
                      height: 68,
                      width: MediaQuery.of(context).size.width,
                      child: imageListView(model)))
            ]),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xffE4E7E8)))),
          )
        : Container();
  }

  ListView imageListView(IM001MainPageViewModelTemp model) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: model.ballImageList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Container(
              width: 77,
              height: 68,
              margin: EdgeInsets.only(left: 16),
              child: Stack(children: <Widget>[
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: ballImageFromDto(model.ballImageList[index])),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 14.00,
                      width: 14.00,
                      child: FlatButton(
                        onPressed: () {
                          model.deleteBallImage(index);
                        },
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          Icons.clear,
                          color: Color(0xffFF4F9A),
                          size: 10,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border.all(
                          width: 1.00,
                          color: Color(0xffff4f9a),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ))
              ]));
        });
  }

  Container ballImageFromDto(BallImageItem imageItem) {
    if (false) {
      return Container(
        height: 62,
        width: 75,
        decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: NetworkImage(imageItem.imageUrl), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12.00),
        ),
      );
    } else {
      return Container(
        height: 62,
        width: 75,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: MemoryImage(
                imageItem.imageByte,
              ),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12.00),
        ),
      );
    }
  }

  Container bottomBar(IM001MainPageViewModelTemp model, BuildContext context) {
    return !model.keyboardVisibility
        ? Container(
            height: 60.00,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(children: <Widget>[
              Container(
                height: 42.00,
                width: 42.00,
                child: FlatButton(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                  shape: CircleBorder(),
                  onPressed: model.onShowSelectPictureDialog,
                  child: Icon(ForutonaIcon.camera, color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffee9acf),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                height: 42.00,
                width: 42.00,
                child: FlatButton(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                  shape: CircleBorder(),
                  onPressed: model.youtubeAttachVisibilityToggle,
                  child: Icon(ForutonaIcon.videoattach, color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff8382F2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 16),
                  height: 42.00,
                  width: 42.00,
                  child: FlatButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                    shape: CircleBorder(),
                    onPressed: model.tagBarToggle,
                    child: Icon(ForutonaIcon.tagadd, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xff88D4F1),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                          blurRadius: 6,
                        )
                      ]))
            ]),
            decoration: BoxDecoration(
              color: Color(0xffffffff).withOpacity(0.90),
              border: Border.all(
                width: 0.50,
                color: Color(0xffe4e7e8).withOpacity(0.90),
              ),
            ),
          )
        : Container();
  }

  TextField textContentEditBar(IM001MainPageViewModelTemp model) {
    return TextField(
      controller: model.textContentEditController,
      focusNode: model.textContentFocusNode,
      autocorrect: false,
      enableSuggestions: false,
      maxLength: 2000,
      maxLines: null,
      minLines: 1,
      decoration: InputDecoration(
          counter: Container(),
          hintText: "어떤 이슈인가요?",
          hintStyle: GoogleFonts.notoSans(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xffe4e7e8),
          ),
          contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Container textContentLabel(IM001MainPageViewModelTemp model) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text("내용",
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: model.textContentFocusNode.hasFocus
                ? Color(0xff3497FD)
                : Color(0xff454f63),
          )),
    );
  }

  Container contentDivider() {
    return Container(
      height: 1,
      width: 360,
      color: Color(0xffE4E7E8),
    );
  }

  TextField titleEditBar(IM001MainPageViewModelTemp model) {
    return TextField(
      controller: model.titleEditController,
      focusNode: model.titleFocusNode,
      autocorrect: false,
      enableSuggestions: false,
      maxLength: 50,
      maxLines: 2,
      minLines: 2,
      decoration: InputDecoration(
          counter: Container(),
          hintText: "제목을 지어주세요!",
          hintStyle: GoogleFonts.notoSans(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xffe4e7e8),
          ),
          contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Container titleLabelBar(IM001MainPageViewModelTemp model) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 0, 8),
      child: Text("제목",
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: model.titleFocusNode.hasFocus
                ? Color(0xff3497FD)
                : Color(0xff454f63),
          )),
    );
  }

  Container googleMapBar(IM001MainPageViewModelTemp model, BuildContext context) {
    return Container(
        height: 233,
        child: Stack(children: <Widget>[
          GoogleMap(
            key: googleMapKey,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            mapType: MapType.normal,
            onMapCreated: model.onMapCreated,
            initialCameraPosition: model.initCameraPosition,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 46.00,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.location_on, color: Color(0xff78849E), size: 15),
                    Text(model.address,
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: Color(0xff454f63),
                        ))
                  ],
                ),
                color: Color(0xffffffff).withOpacity(0.70),
              )),

          Positioned(
            top: 0,
            left: 0,
            child: Container(
              child: FlatButton(
                onPressed: null,
                 child: Container(),
              ),
              width: MediaQuery.of(context).size.width,
              height: 233,
            ),
          )
        ]));
  }

  Container topBar(IM001MainPageViewModelTemp model) {
    return Container(
      height: 56,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackBtnTap,
                child: Icon(Icons.arrow_back)),
            width: 48),
        Container(
            child: Text(model.topNameTitle,
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                ))),
        Spacer(),
        model.isValidComplete()
            ? Container(
                margin: EdgeInsets.only(right: 16),
                height: 32.00,
                width: 75.00,
                child: FlatButton(
                  onPressed: model.onCompleteTap,
                  child: Text("완료",
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Color(0xff454f63),
                      )),
                ),
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    border: Border.all(
                      width: 1.00,
                      color: Color(0xff454f63),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 12.00),
                        color: Color(0xff455b63).withOpacity(0.08),
                        blurRadius: 16,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.00)))
            : Container(
                margin: EdgeInsets.only(right: 16),
                height: 32.00,
                width: 75.00,
                child: FlatButton(
                  onPressed: null,
                  child: Text("완료",
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Color(0xffb1b1b1),
                      )),
                ),
                decoration: BoxDecoration(
                    color: Color(0xffd4d4d4),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.00, 12.00),
                          color: Color(0xff455b63).withOpacity(0.08),
                          blurRadius: 16)
                    ],
                    borderRadius: BorderRadius.circular(5.00)))
      ]),
    );
  }
}