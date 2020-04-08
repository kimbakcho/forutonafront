import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/HCodePage/H005/H00501/H00501Page.dart';
import 'package:forutonafront/HCodePage/H005/H005MainPageViewModel.dart';
import 'package:provider/provider.dart';

import 'H00502/H00502Page.dart';

class H005MainPage extends StatefulWidget {
  H005MainPage(this.serachText);

  String serachText;

  @override
  _H005MainPageState createState() {
    return _H005MainPageState(serachText);
  }
}

class _H005MainPageState extends State<H005MainPage>
    with SingleTickerProviderStateMixin {
  _H005MainPageState(this.serachText);

  String serachText;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H005MainPageViewModel(context, serachText,
            tabController: tabController),
        child: Consumer<H005MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(0, 22.h, 0, 0),
                    child: Stack(children: <Widget>[
                      Column(children: <Widget>[
                        topSerchBar(context, model),
                        topTabbar(model),
                        Expanded(
                          child: TabBarView(
                            controller: model.tabController,
                            children: <Widget>[
                              H00501Page(),
                              H00502Page(),
                            ],
                          ),
                        )
                      ])
                    ])))
          ]);
        }));
  }

  Container topSerchBar(BuildContext context, H005MainPageViewModel model) {
    return Container(
      height: 60.h,
      width: 360.w,
      child: Stack(
        children: <Widget>[
          Row(children: <Widget>[
            BackButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            Container(
                height: 32.00.h,
                width: 280.00.w,
                margin: EdgeInsets.only(left: 8.w),
                alignment: Alignment.center,
                child: Text(model.getSearchTextDisplay(),
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontSize: 14,
                      color: Color(0xff454f63),
                    )),
                decoration: BoxDecoration(
                  color: Color(0xfff9f9f9),
                  border: Border.all(
                    width: 1.00,
                    color: Color(0xfff6f6f6),
                  ),
                  borderRadius: BorderRadius.circular(12.00),
                ))
          ]),
          Positioned(
              right: 40.w,
              top: 15.h,
              child: Container(
                  height: 14.00.h,
                  width: 14.00.w,
                  child: FlatButton(
                    onPressed: () {
                      model.sethasClearFlag(true);
                    },
                    padding: EdgeInsets.all(0),
                    child: Icon(Icons.close,
                        size: 9.sp,
                        color: !model.hasClearFlag
                            ? Color(0xff454F63)
                            : Color(0xffCCCCCC)),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    border: Border.all(
                      width: 1.00.w,
                      color: !model.hasClearFlag
                          ? Color(0xff454F63)
                          : Color(0xffcccccc),
                    ),
                    shape: BoxShape.circle,
                  )))
        ],
      ),
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Container topTabbar(H005MainPageViewModel model) {
    return Container(
      color: Colors.white,
      child: TabBar(
          onTap: (value) {
            model.changeTabIndex(value);
          },
          indicatorColor: Colors.black,
          unselectedLabelColor: Color(0xffCCCCCC),
          labelColor: Color(0xff454F63),
          labelStyle: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontSize: 14.sp,
            color: Color(0xff454f63),
          ),
          controller: model.tabController,
          tabs: [
            Tab(
              text: model.getTitleText(),
            ),
            Tab(text: model.getTagText()),
          ]),
    );
  }
}