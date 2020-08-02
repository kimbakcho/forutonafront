import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/HCodePage/H003/H003_01/H00301PageViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class H00301Page extends StatelessWidget {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H00301PageViewModel(
            context: context,
            fireBaseAuthAdapterForUseCase: sl(),
            fBallListUpUseCaseInputPort: sl(),
            scrollController: scrollController),
        child: Builder(
          builder: (context) => Container(
              color: Color(0xffF2F0F1),
              margin: EdgeInsets.only(bottom: 53),
              child: Stack(children: <Widget>[
                !context.watch<H00301PageViewModel>().isEmptyPage()
                    ? ballListUpPage(context)
                    : Container(
                        child: Center(
                            child: Text(
                                "아쉽지만\n"
                                "참여하신 컨텐츠가 없습니다.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  color: Color(0xffb1b1b1),
                                )))),
                context.watch<H00301PageViewModel>().isLoading
                    ? CommonLoadingComponent()
                    : Container()
              ])),
        ));
  }

  ListView ballListUpPage(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return context.watch<H00301PageViewModel>().ballListUpWidgets[index];
        },
        itemCount:
            context.watch<H00301PageViewModel>().ballListUpWidgets.length);
  }
}
