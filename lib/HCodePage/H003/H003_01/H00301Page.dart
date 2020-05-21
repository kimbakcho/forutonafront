import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/HCodePage/H003/H003_01/H00301PageViewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class H00301Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<H00301PageViewModel>(context);
    return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<H00301PageViewModel>(builder: (_, model, child) {
          return Container(
              margin: EdgeInsets.only(bottom: 53),
              child: Stack(children: <Widget>[
                !viewModel.isEmptyPage()
                    ? ballListUpPage(model)
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
                model.getIsLoading() ? CommonLoadingComponent() : Container()
              ]));
        }));
  }

  ListView ballListUpPage(H00301PageViewModel model) {
    return ListView.builder(
        controller: model.scrollController,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return model.ballListUpWidgets[index];
        },
        itemCount: model.ballListUpWidgets.length);
  }
}
