import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/PageScrollController/PageScrollController.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/ManagerBis/Notice/Dto/NoticeResDto.dart';
import 'package:forutonafront/Page/GCodePage/G016/G016PageCollectMediator.dart';
import 'package:forutonafront/Page/GCodePage/G017/G017MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class G016MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G016MainPageViewModel(),
        child: Consumer<G016MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(body: Container(
              color: Colors.white,
              padding: MediaQuery
                  .of(context)
                  .padding,

              child: Column(children: [
                CodeAppBar(
                  progressValue: 0,
                  title: "공지사항",
                  visibleTailButton: false,
                ),
                Expanded(child:
                model.isLoaded ?
                Container(
                  child: ListView.builder(
                      itemCount: model.notices.length,
                      controller: PageScrollController(
                          scrollController: ScrollController(),
                          onNextPage: model.onNextPage,
                          onRefreshFirst: model.onRefreshFirst)
                          .scrollController,

                      itemBuilder: (context, index) {
                        return Container(
                            key: Key(model.notices[index].idx.toString()),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) {
                                        return G017MainPage(
                                            appBarTitle: model.notices[index]
                                                .title,
                                            idx: model.notices[index].idx);
                                      }));
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 8, 16, 8),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Text(
                                          model.notices[index].title,
                                          style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: const Color(0xff3a3e3f),
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ]),
                                      Row(children: [
                                        Text(
                                          TimeDisplayUtil.getCalcToStrFromNow(
                                              model.notices[index].modifyDate),
                                          style: GoogleFonts.notoSans(
                                            fontSize: 12,
                                            color: const Color(0xff7a7a7a),
                                            letterSpacing: -0.24,
                                            fontWeight: FontWeight.w300,
                                            height: 1.8333333333333333,
                                          ),
                                          textAlign: TextAlign.left,
                                        )
                                      ],)
                                    ],
                                  ),
                                ),
                              ),
                            )
                        );
                      }),

                ) : CommonLoadingComponent())

              ])));
        }));
  }
}

class G016MainPageViewModel extends ChangeNotifier {

  G016PageCollectMediator _g016pageCollectMediator;

  bool isLoaded = false;

  G016MainPageViewModel() {
    _g016pageCollectMediator = G016PageCollectMediator(sl());
    init();
  }

  init() async {
    isLoaded = false;
    notifyListeners();
    await _g016pageCollectMediator.searchFirst();
    isLoaded = true;
    notifyListeners();
  }

  List<NoticeResDto> get notices {
    return _g016pageCollectMediator.itemList;
  }

  onNextPage() {
    _g016pageCollectMediator.searchNext();
  }

  onRefreshFirst() {
    _g016pageCollectMediator.searchFirst();
  }
}
