import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/LCodePage/L001/L001BottomSheet/SignSheet/SignSheet.dart';
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
              children: [LoginSheet(), SignSheet()]);
        }));
  }
}

class L001BottomSheetPageSliderViewModel extends ChangeNotifier {
  PageController _pageController = new PageController();

}
