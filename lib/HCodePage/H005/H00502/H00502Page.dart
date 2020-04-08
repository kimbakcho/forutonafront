import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/FBall/Widget/IssueBall/Style1/IssueBallWidgetStyle1.dart';
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
                  child: Column(
                      children: <Widget>[
                        relationTagRankingList(model),
                        selectOrderButton(model),
                        Expanded(
                            child: ListView.builder(
                                controller: model.mainDcollercontroller,
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: model.listUpBalls.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.fromLTRB(0.w, 0, 0.w, 16.h),
                                      child: IssueBallWidgetStyle1(model.listUpBalls[index]));
                                }))

                      ])))
        ]);
      }),
    );
  }

  Container selectOrderButton(H00502pageViewModel model) {
    return Container(
        height: 58.h,
        padding: EdgeInsets.only(right: 16.w),
        alignment: Alignment.centerRight,
        child: Container(
            height: 29.00.h,
            width: 91.00.w,
            child: DropdownButton<H00502DropdownItemType>(
              isExpanded: true,
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
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

  Container relationTagRankingList(H00502pageViewModel model) {
    return Container(
        height: 54.h,
        width: 360.w,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: model.tagRankings.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 26.h,
                  padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 4.h),
                  margin: EdgeInsets.fromLTRB(16.w, 14.h, 0, 14.h),
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
