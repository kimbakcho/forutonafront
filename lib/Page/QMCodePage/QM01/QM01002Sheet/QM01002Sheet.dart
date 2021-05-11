import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'CheckInPositionOpenWidget.dart';
import 'PhotoCertificationDescription.dart';
import 'PhotoCertificationWidget.dart';
import 'PhotoCertificationWithCheckInWidget.dart';
import 'QTimeLimitWidget.dart';
import 'QuestSelectMode.dart';
import 'QuestSuccessSelect.dart';
import 'PositionSelectorWidget.dart';

class QM01002Sheet extends StatefulWidget {
  final Function(bool) onComplete;

  final QM01002SheetController controller;

  const QM01002Sheet({Key? key, required this.onComplete,required this.controller}) : super(key: key);

  @override
  _QM01002SheetState createState() => _QM01002SheetState();
}

class _QM01002SheetState extends State<QM01002Sheet>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QM01002SheetViewModel(onCanComplete: widget.onComplete,controller: widget.controller),
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
                      model.timeLimitFlag ? QTimeLimitWidget(
                        controller: model._qTimeLimitWidgetController,
                      ) : Container(),
                      Container(
                        margin: EdgeInsets.only(top: 34, left: 16, right: 16),
                        child: model.getStartPositionSelectWidget(),
                      )
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
                      onTap: () {
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
                      onTap: () {
                        Fluttertoast.showToast(msg: "준비중 입니다.");
                      },
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
                      onTap: () {
                        model.toggleStartFlag();
                      },
                      icon: model.startPositionFlag
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
                      onTap: () {
                        Fluttertoast.showToast(msg: "준비중 입니다.");
                      },
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

  QM01002SheetController controller;

  QuestSelectMode currentSelectMode = QuestSelectMode.None;

  bool timeLimitFlag = false;

  bool positionShareFlag = false;

  bool phoneFlag = false;

  bool startPositionFlag = false;

  bool lockFlag = false;

  Function(bool) onCanComplete;

  PhotoCertificationDescriptionController _photoCertificationDescriptionController = PhotoCertificationDescriptionController();

  PositionSelectorWidgetController _checkInController =  PositionSelectorWidgetController();

  PositionSelectorWidgetController _startPositionController = PositionSelectorWidgetController();

  QTimeLimitWidgetController _qTimeLimitWidgetController = QTimeLimitWidgetController();

  CheckInPositionOpenWidgetController _checkInPositionOpenWidgetController = CheckInPositionOpenWidgetController();

  late Timer timer;

  QM01002SheetViewModel({required this.onCanComplete,required this.controller}){
    this.controller._viewModel = this;
    timer = Timer.periodic(Duration(seconds: 1), (time){
      timer = time;
      changeCanComplete();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  changeCanComplete() {
    if (currentSelectMode != QuestSelectMode.None) {
      if(currentSelectMode == QuestSelectMode.PhotoCertification){
        if(_photoCertificationDescriptionController.getText().isNotEmpty){
          if(startPositionFlag){
            if(_startPositionController.getSelectPosition() != null){
              onCanComplete(true);
              return;
            }
          }else {
            onCanComplete(true);
            return ;
          }
        }
      }else if(currentSelectMode == QuestSelectMode.CheckInWithPhotoCertification){
        if(_photoCertificationDescriptionController.getText().isNotEmpty && _checkInController.getSelectPosition() != null){
          if(startPositionFlag){
            if(_startPositionController.getSelectPosition() != null){
              onCanComplete(true);
              return ;
            }
          }else {
            onCanComplete(true);
            return ;
          }
        }
      }
    }
    onCanComplete(false);
  }

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
      return PhotoCertificationDescription(
        controller: _photoCertificationDescriptionController,
      );
    } else {
      return Container();
    }
  }

  Widget getSettingCheckInWidget() {
    if (currentSelectMode == QuestSelectMode.CheckInWithPhotoCertification) {
      return Column(
        children: [
          PositionSelectorWidget(
            mapIconPath: "assets/MarkesImages/checkinflag.png",
            label: "체크인 위치",
            hint: '[!] 지정된 위치 반경 20m 내에서 체크인이 가능합니다.',
            hint2: "여기를 눌러 체크인 위치를 지정해주세요",
            controller: _checkInController,
          ),
          SizedBox(
            height: 20,
          ),
          CheckInPositionOpenWidget(
            controller: _checkInPositionOpenWidgetController,
          )
        ],
      )

        ;
    } else {
      return Container();
    }
  }

  Widget getStartPositionSelectWidget() {
    if (startPositionFlag) {
      return PositionSelectorWidget(
        mapIconPath: "assets/MarkesImages/startflag.png",
        label: "시작 위치",
        hint: '',
        hint2: "여기를 눌러 시작 위치를 지정해주세요",
        controller: _startPositionController,
      );
    } else {
      return Container();
    }
  }

  toggleStartFlag() {
    startPositionFlag = !startPositionFlag;
    notifyListeners();
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

class QM01002SheetController {
  QM01002SheetViewModel? _viewModel;

  QuestSelectMode getSuccessSelectMode() {
      return _viewModel!.currentSelectMode;
  }

  Position? getSelectCheckInPosition() {
    return _viewModel!._checkInController.getSelectPosition();
  }

  String? getSelectCheckInAddress(){
    return _viewModel!._checkInController.getSelectAddress();
  }

  String getPhotoCertificationDescription(){
    return _viewModel!._photoCertificationDescriptionController.getText();
  }

  Duration? getLimitTime(){
    return _viewModel!._qTimeLimitWidgetController.getSelectDuration();
  }

  Position? getSelectStartPosition() {
    return _viewModel!._startPositionController.getSelectPosition();
  }

  String? getSelectStartPositionAddress(){
    return _viewModel!._checkInController.getSelectAddress();
  }

  bool getTimeLimitFlag(){
    return _viewModel!.timeLimitFlag;
  }

  bool getStartPositionFlag(){
    return _viewModel!.startPositionFlag;
  }

  bool isOpenCheckInPosition(){
    return _viewModel!._checkInPositionOpenWidgetController.getState();
  }
}
