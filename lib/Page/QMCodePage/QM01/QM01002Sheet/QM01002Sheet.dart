import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'PhotoCertificationDescription.dart';
import 'PhotoCertificationWidget.dart';
import 'PhotoCertificationWithCheckInWidget.dart';
import 'QTimeLimitWidget.dart';
import 'QuestSelectMode.dart';
import 'QuestSuccessSelect.dart';
import 'SettingCheckInWidget.dart';

class QM01002Sheet extends StatefulWidget {
  @override
  _QM01002SheetState createState() => _QM01002SheetState();
}

class _QM01002SheetState extends State<QM01002Sheet>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QM01002SheetViewModel(),
      child: Consumer<QM01002SheetViewModel>(
        builder: (_, model, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Text("퀘스트 완료 조건 선택",
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: const Color(0xff000000),
                              letterSpacing: -0.28,
                              fontWeight: FontWeight.w700,
                              height: 1.2142857142857142,
                            )),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: model.getSelectorWidget(context),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 34, left: 16, right: 16),
                        child: model.getSettingCheckInWidget(),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 34, left: 16, right: 16),
                          child:
                              model.getPhotoCertificationDescriptionWidget()),
                      model.timeLimitFlag ? QTimeLimitWidget() : Container()
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Color(0xffE4E7E8), width: 1))),
                child: Row(
                  children: [
                    CircleIconBtn(
                      height: 42,
                      width: 42,
                      isBoxShadow: false,
                      onTap: () {
                        model.toggleTimeLimitFlag();
                      },
                      color: Color(0xffF6F6F6),
                      icon: model.timeLimitFlag
                          ? Icon(
                              ForutonaIcon.alram2,
                              color: Colors.black,
                            )
                          : Icon(ForutonaIcon.alram1, color: Colors.black),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    CircleIconBtn(
                      height: 42,
                      width: 42,
                      onTap: (){
                        Fluttertoast.showToast(msg: "준비중 입니다.");
                      },
                      isBoxShadow: false,
                      color: Color(0xffF6F6F6),
                      icon: model.positionShareFlag
                          ? Icon(
                              ForutonaIcon.show2,
                              size: 15,
                              color: Colors.black,
                            )
                          : Icon(ForutonaIcon.show1,
                              size: 15, color: Colors.black),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    CircleIconBtn(
                      height: 42,
                      width: 42,
                      isBoxShadow: false,
                      color: Color(0xffF6F6F6),
                      icon: model.phoneFlag
                          ? Icon(
                              ForutonaIcon.phone2,
                              size: 15,
                              color: Colors.black,
                            )
                          : Icon(ForutonaIcon.phone,
                              size: 15, color: Colors.black),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    CircleIconBtn(
                      height: 42,
                      width: 42,
                      isBoxShadow: false,
                      color: Color(0xffF6F6F6),
                      icon: model.startFlag
                          ? Icon(
                              ForutonaIcon.startflag,
                              size: 15,
                              color: Colors.black,
                            )
                          : Icon(ForutonaIcon.startflag2,
                              size: 15, color: Colors.black),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    CircleIconBtn(
                      height: 42,
                      width: 42,
                      isBoxShadow: false,
                      color: Color(0xffF6F6F6),
                      icon: model.lockFlag
                          ? Icon(
                              ForutonaIcon.lock2,
                              size: 15,
                              color: Colors.black,
                            )
                          : Icon(ForutonaIcon.lock1,
                              size: 15, color: Colors.black),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class QM01002SheetViewModel extends ChangeNotifier {
  QuestSelectMode currentSelectMode = QuestSelectMode.None;

  bool timeLimitFlag = false;

  bool positionShareFlag = false;

  bool phoneFlag = false;

  bool startFlag = false;

  bool lockFlag = false;

  setCurrentSelectMode(QuestSelectMode? mode) {
    if (mode != null) {
      this.currentSelectMode = mode;
      notifyListeners();
    }
  }

  Widget getSelectorWidget(BuildContext context) {
    if (this.currentSelectMode == QuestSelectMode.None) {
      return QuestSuccessSelect(
        onTap: () async {
          setCurrentSelectMode(await showSelectDialog(context));
        },
      );
    } else if (this.currentSelectMode == QuestSelectMode.PhotoCertification) {
      return PhotoCertificationWidget(
        onTap: () async {
          setCurrentSelectMode(await showSelectDialog(context));
        },
      );
    } else if (this.currentSelectMode ==
        QuestSelectMode.CheckInWithPhotoCertification) {
      return PhotoCertificationWithCheckInWidget(
        onTap: () async {
          setCurrentSelectMode(await showSelectDialog(context));
        },
      );
    } else {
      return Container();
    }
  }

  toggleTimeLimitFlag() {
    timeLimitFlag = !timeLimitFlag;
    notifyListeners();
  }

  Widget getPhotoCertificationDescriptionWidget() {
    if (currentSelectMode != QuestSelectMode.None) {
      return PhotoCertificationDescription();
    } else {
      return Container();
    }
  }

  Widget getSettingCheckInWidget() {
    if (currentSelectMode == QuestSelectMode.CheckInWithPhotoCertification) {
      return SettingCheckInWidget();
    } else {
      return Container();
    }
  }

  Future<QuestSelectMode?> showSelectDialog(BuildContext context) async {
    var questSelectMode = await showDialog<QuestSelectMode>(
        barrierColor: Color(0xff2F3035).withOpacity(0.5),
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: PhotoCertificationWidget(
                    onTap: () {
                      Navigator.of(context)
                          .pop(QuestSelectMode.PhotoCertification);
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: PhotoCertificationWithCheckInWidget(
                      onTap: () {
                        Navigator.of(context)
                            .pop(QuestSelectMode.CheckInWithPhotoCertification);
                      },
                    )),
              ],
            ),
          );
        });
    return questSelectMode;
  }
}
