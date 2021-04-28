import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'GenderType.dart';

class GenderSelectComponent extends StatelessWidget {
  final GenderSelectComponentController? genderSelectComponentController;

  final GenderType? initGender;

  const GenderSelectComponent(
      {Key? key, this.genderSelectComponentController, this.initGender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GenderSelectComponentViewModel(
          genderSelectComponentController: genderSelectComponentController,
          initGender: initGender),
      child: Consumer<GenderSelectComponentViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '성별',
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff000000),
                    letterSpacing: -0.28,
                    fontWeight: FontWeight.w700,
                    height: 1.2142857142857142,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Material(
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () {
                          model._setCurrentGenderType(GenderType.Male);
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: model._currentGenderType ==
                                          GenderType.Male
                                      ? Color(0xff668FF7)
                                      : Color(0xffE4E7E8),
                                  shape: BoxShape.circle),
                              width: 32,
                              height: 32,
                              padding: EdgeInsets.all(4),
                              child: SvgPicture.asset(
                                "assets/IconImage/male.svg",
                                color:
                                    model._currentGenderType == GenderType.Male
                                        ? Color(0xffF6F6F6)
                                        : Color(0xffD4D4D4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        "남성",
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: model._currentGenderType == GenderType.Male
                              ? Color(0xff668FF7)
                              : Color(0xffb1b1b1),
                          letterSpacing: -0.28,
                          fontWeight: FontWeight.w300,
                          height: 1.2142857142857142,
                        ),
                      ),
                    )
                    ,
                    SizedBox(width: 27),
                    Material(
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () {
                          model._setCurrentGenderType(GenderType.FeMale);
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: model._currentGenderType ==
                                          GenderType.FeMale
                                      ? Color(0xffF68D9A)
                                      : Color(0xffE4E7E8),
                                  shape: BoxShape.circle),
                              width: 32,
                              height: 32,
                              padding: EdgeInsets.all(4),
                              child: SvgPicture.asset(
                                "assets/IconImage/female.svg",
                                color: model._currentGenderType ==
                                        GenderType.FeMale
                                    ? Color(0xffF6F6F6)
                                    : Color(0xffD4D4D4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        "여성",
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: model._currentGenderType == GenderType.FeMale
                              ? Color(0xffF68D9A)
                              : Color(0xffb1b1b1),
                          letterSpacing: -0.28,
                          fontWeight: FontWeight.w300,
                          height: 1.2142857142857142,
                        ),
                      ),
                    )

                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class GenderSelectComponentViewModel extends ChangeNotifier {
  final GenderSelectComponentController? genderSelectComponentController;

  GenderType? initGender;

  GenderType _currentGenderType = GenderType.None;

  GenderSelectComponentViewModel(
      {this.genderSelectComponentController, this.initGender}) {
    if (this.genderSelectComponentController != null) {
      genderSelectComponentController!._genderSelectComponentViewModel = this;
    }
    if (initGender != null) {
      _currentGenderType = initGender!;
    }
  }

  _setCurrentGenderType(GenderType type) {
    if (_currentGenderType == type) {
      _currentGenderType = GenderType.None;
    } else {
      _currentGenderType = type;
    }
    notifyListeners();
  }
}

class GenderSelectComponentController {
  GenderSelectComponentViewModel? _genderSelectComponentViewModel;

  GenderType get currentGenderType {
    return _genderSelectComponentViewModel!._currentGenderType;
  }
}
