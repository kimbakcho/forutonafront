import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/HCodePage/H004/H004MainPageViewModel.dart';
import 'package:forutonafront/HCodePage/H005/H005MainPage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class H004MainPage extends StatefulWidget {
  @override
  _H004MainPageState createState() => _H004MainPageState();
}

class _H004MainPageState extends State<H004MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H004MainPageViewModel(context),
        child: Consumer<H004MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(0, 22.h, 0, 0),
                    child: Stack(
                      children: <Widget>[
                        Column(children: <Widget>[
                          searchBar(context, model),
                        ]),
                        Positioned(
                            top: 59.h,
                            left: 0,
                            child: searchHistoryDrawer(model))
                      ],
                    )))
          ]);
        }));
  }

  AnimatedContainer searchHistoryDrawer(H004MainPageViewModel model) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: model.isClearButtonActive()
          ? 0
          : (52.h * model.searchHistorys.length),
      width: 360.w,
      child: ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: model.searchHistorys.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(0, 0, 16.w, 0),
              height: 52.h,
              child: FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return H005MainPage(
                          model.searchHistorys[index].searchText);
                    }));
                  },
                  child: Row(children: <Widget>[
                    Container(
                      width: 240.w,
                      child: Text(model.searchHistorys[index].searchText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14.sp,
                            color: Color(0xff454f63),
                          )),
                    ),
                    Container(
                      child: Text(
                          DateFormat("yy.MM.dd").format(
                              model.searchHistorys[index].searchTime.toLocal()),
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14.sp,
                            color: Color(0xffcccccc),
                          )),
                    ),
                    Container(
                        width: 18.w,
                        child: IconButton(
                            onPressed: () {
                              model.removeSearchText(
                                  model.searchHistorys[index]);
                            },
                            icon: Icon(
                              ForutonaIcon.removepath,
                              size: 14.sp,
                              color: Color(0xff78849E),
                            )))
                  ])),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: Color(0xffE4E7E8),
                          width: 0.5.w,
                          style: BorderStyle.solid))),
            );
          }),
    );
  }

  Container searchBar(BuildContext context, H004MainPageViewModel model) {
    return Container(
      height: 60.h,
      width: 360.w,
      child: Stack(children: <Widget>[
        Row(children: <Widget>[
          BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Color(0xff454F63),
          ),
          Container(
              margin: EdgeInsets.only(left: 8.w),
              width: 280.w,
              height: 32.h,
              child: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                focusNode: model.searchFocusNode,
                onSubmitted: (value) async {
                  if (value.length <= 1) {
                    Fluttertoast.showToast(
                        msg: "2글자 이상 입력해주세요",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Color(0xff454F63),
                        textColor: Colors.white,
                        fontSize: 12.0);
//                                      model.clearTextSearchText();
                    model.attckSearchFocus();
                  } else {
                    await model.onSave(value);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return H005MainPage(value);
                    }));
                  }
                },
                maxLines: 1,
                autofocus: true,
                controller: model.searchTextController,
                cursorColor: Color(0xff707070),
                textAlign: model.hasSearchTextFocus
                    ? TextAlign.start
                    : TextAlign.center,
                decoration: InputDecoration(
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
                        borderSide:
                            BorderSide(color: Color(0xff3497FD), width: 1.5.w),
                        borderRadius: BorderRadius.all(Radius.circular(12.w))),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffF9F9F9), width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(12.w)))),
              ))
        ]),
        Positioned(
            right: 40.w,
            top: 15.h,
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
      ]),
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}
