import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountryItem.dart';
import 'package:forutonafront/Components/CountrySelect/CountrySelectPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sim_info/sim_info.dart';

class CountrySelectButton extends StatelessWidget {
  final CountrySelectButtonController countrySelectButtonController;

  const CountrySelectButton({Key key, this.countrySelectButtonController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountrySelectButtonViewModel(
          countrySelectButtonController: countrySelectButtonController),
      child: Consumer<CountrySelectButtonViewModel>(
        builder: (_, model, child) {
          return Container(
            height: 30,
            child: Material(
              child: InkWell(
                onTap: () {
                  model.moveToCountrySelectPage(context);
                },
                child: Row(
                  children: [
                    model.loaded
                        ? Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 21,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/flags/${model.currentCountryCode}.png'))),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 9),
                                  child: Text(
                                    '${model.currentCountryName}(${model.currentCountryDialCode})',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: const Color(0xff000000),
                                      letterSpacing: -0.28,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2142857142857142,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                      child: Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CountrySimpleSelectButton extends StatelessWidget {
  final CountrySelectButtonController countrySelectButtonController;

  final CountryItem initCountryItem;

  const CountrySimpleSelectButton(
      {Key key, this.countrySelectButtonController, this.initCountryItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CountrySelectButtonViewModel(
            countrySelectButtonController: countrySelectButtonController,
            initCountryItem: initCountryItem),
        child:
            Consumer<CountrySelectButtonViewModel>(builder: (_, model, child) {
          return Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  '국가',
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff000000),
                    letterSpacing: -0.28,
                    fontWeight: FontWeight.w700,
                    height: 1.2142857142857142,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  children: [
                    model.loaded
                        ? Expanded(
                      child: Material(
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB1B1B1))),
                        child: InkWell(
                            onTap: () {
                              model.moveToCountrySelectPage(context);
                            },
                            child: Container(
                              color: Colors.white,
                                constraints: BoxConstraints(
                                    maxHeight: 33,
                                    maxWidth:
                                    MediaQuery.of(context).size.width),
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  model.currentCountryName,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    color: const Color(0xff3a3e3f),
                                    letterSpacing: -0.24,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4166666666666667,
                                  ),
                                ))),
                      ),
                    )


                        : Container()
                  ],
                )

              ]));
        }));
  }
}

class CountrySelectButtonViewModel extends ChangeNotifier {
  CountrySelectButtonController countrySelectButtonController;

  bool loaded = false;

  CountryItem currentCountryItem;

  CodeCountry codeCountry;

  CountryItem initCountryItem;

  CountrySelectButtonViewModel(
      {this.countrySelectButtonController, this.initCountryItem}) {
    if (this.countrySelectButtonController != null) {
      countrySelectButtonController._countrySelectButtonViewModel = this;
    }
    codeCountry = CodeCountry();
    if (initCountryItem != null) {
      currentCountryItem = initCountryItem;
      loaded = true;
    } else {
      this.init();
    }
  }

  init() async {
    var currentCountry = await getMobileCountry();

    this.currentCountryItem = codeCountry
        .countryList()
        .firstWhere((element) => element.code.toLowerCase() == currentCountry);
    if (countrySelectButtonController != null &&
        countrySelectButtonController.onCurrentCountryItem != null) {
      countrySelectButtonController.onCurrentCountryItem(currentCountryItem);
    }
    loaded = true;
    notifyListeners();
  }

  String get currentCountryDialCode {
    return currentCountryItem.dialCode;
  }

  String get currentCountryCode {
    return currentCountryItem.code.toLowerCase();
  }

  String get currentCountryName {
    return currentCountryItem.name;
  }

  Future<String> getMobileCountry() async {
    String mobileCountryCode = await SimInfo.getIsoCountryCode;
    // String locale = await Devicelocale.currentLocale;
    var lastIndexOf = mobileCountryCode.lastIndexOf("_");
    var countryCode = mobileCountryCode.substring(lastIndexOf + 1);
    return countryCode.toLowerCase();
  }

  void moveToCountrySelectPage(BuildContext context) async {
    String code =
        await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return CountrySelectPage(
        countryCode: currentCountryCode.toUpperCase(),
      );
    }));

    if (code != null) {
      this.currentCountryItem = codeCountry.countryList().firstWhere(
          (element) => element.code.toLowerCase() == code.toLowerCase());

      if (countrySelectButtonController != null &&
          countrySelectButtonController.onCurrentCountryItem != null) {
        countrySelectButtonController.onCurrentCountryItem(currentCountryItem);
      }
      notifyListeners();
    }
  }

  _setCurrentCountryItem(CountryItem countryItem) {
    currentCountryItem = countryItem;
    notifyListeners();
  }
}

class CountrySelectButtonController {
  CountrySelectButtonViewModel _countrySelectButtonViewModel;

  Function(CountryItem countryItem) onCurrentCountryItem;

  CountrySelectButtonController({this.onCurrentCountryItem});

  setCurrentCountryItem(CountryItem countryItem) {
    _countrySelectButtonViewModel._setCurrentCountryItem(countryItem);
  }

  CountryItem getCurrentCountryItem() {
    if (_countrySelectButtonViewModel != null) {
      return _countrySelectButtonViewModel.currentCountryItem;
    } else {
      var codeCountry = CodeCountry();
      return codeCountry
          .countryList()
          .firstWhere((element) => element.code.toLowerCase() == "kr");
    }
  }
}
