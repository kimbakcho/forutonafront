import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Components/SliderDatePicker/date_picker_theme.dart';
import 'package:forutonafront/Components/SliderDatePicker/i18n/date_picker_i18n.dart';
import 'package:forutonafront/Components/SliderDatePicker/widget/date_picker_widget.dart';
import 'package:forutonafront/Page/LCodePage/L005/L005MainPage.dart';
import 'package:forutonafront/Page/LCodePage/L008/L008MainPage.dart';

import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
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
                color: Colors.white,
                  padding: MediaQuery.of(context).padding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CodeAppBar(
                          progressValue: 0.4,
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
                                initialDate: model.initDateTime!,
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
  DatePickerWidgetController? _datePickerWidgetController;
  final FUserInfoJoinReqDto? _fUserInfoJoinReqDto;

  DateTime? initDateTime;

  L004MainPageViewModel(this._fUserInfoJoinReqDto){
    _datePickerWidgetController = new DatePickerWidgetController();
    initDateTime = DateTime(DateTime.now().year-14,DateTime.now().month,DateTime.now().day);
  }

  onDateTimeChange(DateTime dateTime, List<int> selectedIndex) {

    if (dateTime.isAfter(initDateTime!)) {
      this.enableTailButton = false;
    } else {
      this.enableTailButton = true;
    }
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    this._fUserInfoJoinReqDto!.forutonaAgree = true;
    this._fUserInfoJoinReqDto!.ageDate = _datePickerWidgetController!.getCurrentDateTime();
    if(this._fUserInfoJoinReqDto!.snsSupportService == SnsSupportService.Forutona){
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return L005MainPage();
      }));
    }else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return L008MainPage();
      }));
    }

  }
}
