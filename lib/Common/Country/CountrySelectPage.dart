import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Country/CountrySelectPageViewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CountrySelectPage extends StatelessWidget {
  String countryCode;

  CountrySelectPage({this.countryCode});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            CountrySelectPageViewModel(context, initCountryCode: countryCode),
        child: Consumer<CountrySelectPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                  width: MediaQuery.of(context).size.width,
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Column(children: <Widget>[
                      topBar(model),
                      Expanded(child: countryListView(model,context))
                    ])))
          ]);
        }));
  }

  ListView countryListView(CountrySelectPageViewModel model,BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        controller: model.listViewScroller,
        scrollDirection: Axis.vertical,
        itemCount: model.countryList.length,
        itemBuilder: (_, index) {
          return Container(
            height: 49,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: FlatButton(
              onPressed: () {
                model.onSelectCountry(index);
              },
              child: Container(
                  height: 49,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  child: Text(model.countryList[index].name,
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: index == model.selectCountryIndex
                            ? Color(0xff3497FD)
                            : Color(0xff454f63),
                      ))),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Color(0xffF2F0F1), width: 1))),
          );
        });
  }

  Container topBar(CountrySelectPageViewModel model) {
    return Container(
        color: Colors.white,
        child: Row(children: <Widget>[
          Container(
            child: FlatButton(
              child: Icon(Icons.arrow_back),
              onPressed: model.onBackBtnClick,
              padding: EdgeInsets.all(0),
            ),
            width: 41,
            height: 41,
          ),
          Container(
              child: Text("국가",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(0xff454f63),
                  )))
        ]));
  }
}
