import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1Support.dart';
import 'package:forutonafront/HCodePage/H005/H00502/H00502pageViewModel.dart';
import 'package:provider/provider.dart';

import 'H00502DropdownItemType.dart';

class H00502Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => H00502pageViewModel(context),
      child: Consumer<H00502pageViewModel>(builder: (_, model, child) {
        return Stack(children: <Widget>[
          Scaffold(
              body: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                            controller: model.mainDropDownBtnController,
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: model.listUpBalls.length+2,
                            itemBuilder: (context, index) {
                              if(index == 0){
                                return relationTagRankingList(model, context);
                              }else if(index == 1){
                                return selectOrderButton(model);
                              }else {
                                return Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                    child: BallStyle1Support.selectBallWidget(
                                        model.listUpBalls[index-2]));
                              }
                            }))
                  ]))),
          model.getIsLoading() ? CommonLoadingComponent() : Container()
        ]);
      }),
    );
  }

  Container selectOrderButton(H00502pageViewModel model) {
    return Container(
        height: 58,
        padding: EdgeInsets.only(right: 16),
        alignment: Alignment.centerRight,
        child: Container(
            height: 29.00,
            width: 91.00,
            child: DropdownButton<H00502DropdownItemType>(
              isExpanded: true,
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0xff454f63),
              ),
              value: model.selectOrder,
              onChanged: (H00502DropdownItemType newValue) {
                model.selectOrder = newValue;
                model.onChangeOrder();
              },
              underline: Container(
                height: 0,
                color: Colors.white,
              ),
              items: model.dropDownItems,
            ),
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(
                  width: 1.00,
                  color: Color(0xff454f63),
                ),
                borderRadius: BorderRadius.circular(8.00))));
  }

  Container relationTagRankingList(
      H00502pageViewModel model, BuildContext context) {
    return Container(
        height: 54,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: model.tagRankings.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 26,
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  margin: EdgeInsets.fromLTRB(16, 14, 0, 14),
                  child: InkWell(
                      onTap: () {},
                      child: Text(model.tagRankings[index].tagName,
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color(0xff454f63),
                          ))),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff).withOpacity(0.50),
                    border: Border.all(
                      width: 1.00,
                      color: Color(0xffcccccc).withOpacity(0.50),
                    ),
                    borderRadius: BorderRadius.circular(8.00),
                  ));
            }));
  }
}
