import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/HCodePage/H005/H00502/H00502PageViewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'H00502DropdownItemType.dart';

class H00502Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    H00502PageViewModel _h00501pageViewModel = Provider.of(context);
    return ChangeNotifierProvider.value(
      value: _h00501pageViewModel,
      child: Consumer<H00502PageViewModel>(builder: (_, model, child) {
        return Stack(children: <Widget>[
          Scaffold(
            backgroundColor: Color(0xffF2F0F1),
              body: !model.isEmptyPage()
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(children: <Widget>[
                        Expanded(
                            child: ListView.separated(
                                controller: model.mainDropDownBtnController,
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: model.ballWidgetLists.length + 2,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return relationTagRankingList(
                                        model, context);
                                  } else if (index == 1) {
                                    return selectOrderButton(model);
                                  } else {
                                    return Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 16),
                                        child:
                                            model.ballWidgetLists[index - 2]);
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  if (index == 0) {
                                    return didver(context);
                                  } else {
                                    return SizedBox(height: 16);
                                  }
                                }))
                      ]))
                  : Container(
                      child: Center(
                      child: Text("검색된 결과가 없습니다."),
                    ))),
          model.isLoading ? CommonLoadingComponent() : Container()
        ]);
      }),
    );
  }

  Container didver(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 14, bottom: 16),
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: Color(0xffE4E7E8),
    );
  }

  Container selectOrderButton(H00502PageViewModel model) {
    return Container(
        padding: EdgeInsets.only(right: 16),
        alignment: Alignment.centerRight,
        child: Container(
            height: 29.00,
            width: 91.00,
            child: DropdownButton<H00502DropdownItemType>(
              isExpanded: true,
              style: GoogleFonts.notoSans(
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
      H00502PageViewModel model, BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        height: 32,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: model.relationTagRankings.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: InkWell(
                      onTap: () {},
                      child: Text(model.relationTagRankings[index].tagName,
                          style: GoogleFonts.notoSans(
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
