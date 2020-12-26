import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/Components/SliderDatePicker/date_picker_theme.dart';
import 'package:forutonafront/Components/SliderDatePicker/i18n/date_picker_i18n.dart';
import 'package:forutonafront/Components/SliderDatePicker/widget/date_picker_widget.dart';
import 'package:forutonafront/Page/LCodePage/L005/L005MainPage.dart';

import 'package:forutonafront/Page/LCodePage/LCodeAppBar/LCodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L004MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => L004MainPageViewModel(sl()),
      child: Consumer<L004MainPageViewModel>(
        builder: (_, model, child) {
          return Material(
              child: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LCodeAppBar(
                          progressValue: 0.5,
                          tailButtonLabel: "다음",
                          enableTailButton: model.enableTailButton,
                          title: "사용자 연령 확인",
                          onTailButtonClick: () {
                            model.nextPage(context);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text.rich(
                              TextSpan(
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    color: const Color(0xff000000),
                                    letterSpacing: -0.28,
                                    height: 1.4285714285714286,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '당신의 생일은 언제인가요?\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                        text: '만 14세 미만의 어린이는 가입을 제한하고 있습니다.',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ))
                                  ]),
                              textAlign: TextAlign.left,
                            )),
                        SizedBox(
                          height: 43,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 252,
                              child: DatePickerWidget(
                                dateFormat: "MM월-dd일-yyyy년",
                                locale: DateTimePickerLocale.ko,
                                initialDate: DateTime.now()
                                    .add(Duration(days: -365 * 20)),
                                datePickerWidgetController:
                                    model._datePickerWidgetController,
                                onChange: model.onDateTimeChange,
                                pickerTheme: DateTimePickerTheme(
                                  backgroundColor: Colors.transparent,
                                  dividerColor: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        )
                      ])));
        },
      ),
    );
  }
}

class L004MainPageViewModel extends ChangeNotifier {
  bool enableTailButton = true;
  DatePickerWidgetController _datePickerWidgetController;
  final FUserInfoJoinReqDto _fUserInfoJoinReqDto;

  L004MainPageViewModel(this._fUserInfoJoinReqDto){
    _datePickerWidgetController = new DatePickerWidgetController();
  }

  onDateTimeChange(DateTime dateTime, List<int> selectedIndex) {
    var nowYear = DateTime.now().year;
    int limitYear = nowYear - 20;
    if (dateTime.year > limitYear) {
      this.enableTailButton = false;
    } else {
      this.enableTailButton = true;
    }
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    this._fUserInfoJoinReqDto.forutonaAgree = true;
    this._fUserInfoJoinReqDto.ageDate = _datePickerWidgetController.getCurrentDateTime();
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return L005MainPage();
    }));
  }
}
