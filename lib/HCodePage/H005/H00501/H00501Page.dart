import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1Widget.dart';

import 'package:forutonafront/HCodePage/H005/H00501/H00501PageViewModel.dart';
import 'package:provider/provider.dart';

import 'H00501DropdownItemType.dart';


class H00501Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H00501PageViewModel(context),
        child: Consumer<H00501PageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                  child: Column(
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                          controller: model.mainDropDownBtnController,
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: model.listUpBalls.length+1,
                          itemBuilder: (context, index) {
                            if(index ==0 ){
                              return selectOrderButton(model);
                            }else {
                              return Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  child: BallStyle1Widget.create(model.listUpBalls[index-1],model.onRequestReFreshBall) as Widget
                              );
                            }
                          }))
                ],
              )),
            ),
            model.getIsLoading() ? CommonLoadingComponent() : Container()
          ]);
        }));
  }

  Container selectOrderButton(H00501PageViewModel model) {
    return Container(
        height: 58,
        padding: EdgeInsets.only(right: 16),
        alignment: Alignment.centerRight,
        child: Container(
            height: 29.00,
            width: 91.00,
            child: DropdownButton<H00501DropdownItemType>(
              isExpanded: true,
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color(0xff454f63),
              ),
              value: model.selectOrder,
              onChanged: (H00501DropdownItemType newValue) {
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
}
