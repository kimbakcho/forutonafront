import 'package:forutonafront/GCodePage/G001/G001MainPageInter.dart';

class G001MainPageController {
   G001MainPageInter g001mainPageInter;
   Future<void> reFreshUserInfo() async {
     await g001mainPageInter.reFreshUserInfo();
   }
}