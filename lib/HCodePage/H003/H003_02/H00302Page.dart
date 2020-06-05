import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'H00302PageViewModel.dart';

class H00302Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<H00302PageViewModel>(context);
    return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<H00302PageViewModel>(builder: (_, model, child) {
          return Container(
            color: Color(0xffF2F0F1),
              margin: EdgeInsets.only(bottom: 53),
              child: Stack(children: <Widget>[
                !viewModel.isEmptyPage()
                    ? buildListView(model)
                    : Container(
                        child: Center(
                            child: Text(
                                "아쉽지만\n"
                                "제작하신 컨텐츠가 없습니다.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  color: Color(0xffb1b1b1),
                                )))),
                model.isLoading ? CommonLoadingComponent() : Container()
              ]));
        }));
  }

  ListView buildListView(H00302PageViewModel model) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
        controller: model.scrollController,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return model.ballListUpWidgets[index];
        },
        itemCount: model.ballListUpWidgets.length);
  }
}
