import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/HCodePage/H004/H004MainPageViewModel.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
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
        create: (_) => H004MainPageViewModel(
            context: context,
            geoLocationUtilUseCaseInputPort: sl(),
            ballSearchBarHistoryUseCaseInputPort: sl()),
        child: Consumer<H004MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(
                      children: <Widget>[
                        Column(children: <Widget>[
                          searchBar(context, model),
                        ]),
                        Positioned(
                            top: 59,
                            left: 0,
                            width: MediaQuery.of(context).size.width,
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
          ? 0.0
          : (52.0 * model.searchHistoryList.length),
      child: ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: model.searchHistoryList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              height: 52,
              child: FlatButton(
                  onPressed: () {
                    model.gotoH005Page(
                        model.searchHistoryList[index].searchText);
                  },
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(model.searchHistoryList[index].searchText,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: Color(0xff454f63),
                            )),
                      ),
                    ),
                    Container(
                      child: Text(
                          DateFormat("yy.MM.dd").format(model
                              .searchHistoryList[index].searchTime
                              .toLocal()),
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: Color(0xffcccccc),
                          )),
                    ),
                    Container(
                        width: 18,
                        child: IconButton(
                            onPressed: () {
                              model.removeSearchText(
                                  model.searchHistoryList[index]);
                            },
                            icon: Icon(
                              ForutonaIcon.removepath,
                              size: 14,
                              color: Color(0xff78849E),
                            )))
                  ])),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: Color(0xffE4E7E8),
                          width: 0.5,
                          style: BorderStyle.solid))),
            );
          }),
    );
  }

  Container searchBar(BuildContext context, H004MainPageViewModel model) {
    return Container(
      height: 60,
      child: Stack(children: <Widget>[
        Row(children: <Widget>[
          BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Color(0xff454F63),
          ),
          Container(
              margin: EdgeInsets.only(left: 8),
              width: MediaQuery.of(context).size.width - 80,
              height: 32,
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
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
                    model.gotoH005Page(value);
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
                    filled: true,
                    fillColor: Color(0xffF9F9F9),
                    hintText: model.getSearchHintText(),
                    hintStyle: model.hasSearchTextFocus
                        ? GoogleFonts.notoSans(
                            fontSize: 14, color: Color(0xffcccccc))
                        : GoogleFonts.notoSans(
                            fontSize: 14,
                            color: Color(0xff454f63),
                          ),
                    contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff3497FD), width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffF9F9F9), width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
              ))
        ]),
        Positioned(
            right: 40,
            top: 13,
            child: model.isClearButtonShow()
                ? Container(
                    height: 20.00,
                    width: 20.00,
                    child: FlatButton(
                      onPressed: model.isClearButtonActive()
                          ? () {
                              model.clearSearchText();
                            }
                          : null,
                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.close,
                          size: 14,
                          color: model.isClearButtonActive()
                              ? Color(0xff454F63)
                              : Color(0xffCCCCCC)),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      border: Border.all(
                        width: 1.00,
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
