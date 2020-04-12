import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'MapGeoSearchPageViewModel.dart';

class MapGeoSearchPage extends StatelessWidget {
  final String _initAddress;
  final Position _initPosition;

  MapGeoSearchPage(this._initAddress, this._initPosition);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MapGeoSearchPageViewModel(_initAddress, _initPosition,context),
        child: Consumer<MapGeoSearchPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                backgroundColor: Color(0xffF2F0F1),
                body: Stack(children: <Widget>[
                  Positioned(
                      top: MediaQuery.of(context).padding.top,
                      child: Column(children: <Widget>[
                        topSearchBar(context, model),
                        Container(
                          height: 1,
                          width: 360.00,
                          color: Color(0xffe4e7e8),
                        ),
                        AnimatedContainer(
                          height: model.predictions.length * 52.h,
                          width: 360.w,
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                          duration: Duration(milliseconds: 500),
                          child: ListView.builder(
                              itemCount: model.predictions.length,
                              padding: EdgeInsets.all(0),
                              itemBuilder: (_, index) {
                                return Container(
                                    height: 52.h,
                                    width: 360.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xffE4E7E8),
                                                width: 1.h))),
                                    child: FlatButton(
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          model.onPredictionTab(model.predictions[index]);
                                        },
                                        child: Container(
                                          height: 52.h,
                                          width: 360.w,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.fromLTRB(
                                              16.w, 0, 16.w, 0),
                                          child: Text(
                                              model.predictions[index]
                                                  .description,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: "Noto Sans CJK KR",
                                                fontSize: 14.sp,
                                                color: Color(0xff454f63),
                                              )),
                                        )));
                              }),
                        )
                      ]))
                ]))
          ]);
        }));
  }

  Container topSearchBar(
      BuildContext context, MapGeoSearchPageViewModel model) {
    return Container(
        color: Colors.white,
        height: 68.h,
        width: 360.w,
        child: Stack(children: <Widget>[
          Positioned(
              left: 16.w,
              child: Container(
                height: 68.h,
                width: 32.w,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.arrow_back,
                    size: 24.sp,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )),
          Positioned(
            left: 48.w,
            top: 16.h,
            child: Container(
                margin: EdgeInsets.only(left: 8.w),
                width: 280.w,
                height: 32.h,
                child: TextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  focusNode: model.searchFocusNode,
                  onSubmitted: (value) async {},
                  maxLines: 1,
                  controller: model.searchTextController,
                  cursorColor: Color(0xff707070),
                  textAlign: model.hasSearchTextFocus
                      ? TextAlign.start
                      : TextAlign.center,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF9F9F9),
                      hintText: model.getSearchHintText(),
                      hintStyle: model.hasSearchTextFocus
                          ? TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontSize: 14.sp,
                              color: Color(0xffcccccc))
                          : TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontSize: 14.sp,
                              color: Color(0xff454f63),
                            ),
                      contentPadding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xff3497FD), width: 1.5.w),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.w))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffF9F9F9), width: 0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.w)))),
                )),
          ),
          Positioned(
              right: 40.w,
              top: 25.h,
              child: model.isClearButtonShow()
                  ? Container(
                      height: 14.00.h,
                      width: 14.00.w,
                      child: FlatButton(
                        onPressed: model.isClearButtonActive()
                            ? () {
                                model.clearSearchText();
                              }
                            : null,
                        padding: EdgeInsets.all(0),
                        child: Icon(Icons.close,
                            size: 9.sp,
                            color: model.isClearButtonActive()
                                ? Color(0xff454F63)
                                : Color(0xffCCCCCC)),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border.all(
                          width: 1.00.w,
                          color: model.isClearButtonActive()
                              ? Color(0xff454F63)
                              : Color(0xffcccccc),
                        ),
                        shape: BoxShape.circle,
                      ))
                  : Container())
        ]));
  }
}
