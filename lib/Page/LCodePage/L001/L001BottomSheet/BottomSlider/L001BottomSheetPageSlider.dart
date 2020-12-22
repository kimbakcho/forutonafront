import 'package:flutter/material.dart';
import 'package:forutonafront/Page/LCodePage/L001/L001BottomSheet/SignSheet/SignSheet.dart';
import 'package:forutonafront/Page/LCodePage/L001/L001BottomSheet/SignSheet/SignSheetOutputPort.dart';
import 'package:provider/provider.dart';
import '../LoginSheet/LoginSheet.dart';
import '../LoginSheet/LoginSheetOutputPort.dart';


class L001BottomSheetPageSlider extends StatelessWidget {
  const L001BottomSheetPageSlider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L001BottomSheetPageSliderViewModel(),
        child: Consumer<L001BottomSheetPageSliderViewModel>(
            builder: (_, model, child) {
          return PageView(
              controller: model._pageController,
              scrollDirection: Axis.horizontal,
              children: [LoginSheet(loginSheetOutputPort: model,), SignSheet(signSheetOutputPort: model,)]);
        }));
  }
}

class L001BottomSheetPageSliderViewModel extends ChangeNotifier implements LoginSheetOutputPort,SignSheetOutputPort{
  PageController _pageController = new PageController();

  @override
  moveToEmailLoginPage() {
    // TODO: implement moveToLoginPage
    throw UnimplementedError();
  }

  @override
  moveToSignPage() {
    _pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  moveToLoginPage() {
    _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

}
