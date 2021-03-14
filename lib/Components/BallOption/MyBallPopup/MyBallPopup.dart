import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBallPopup extends StatelessWidget {
  final Function(BuildContext context) onShare;

  final Function(BuildContext context) onModify;

  final Function(BuildContext context) onDelete;

  final isShowShareBtn;
  final isShowModifyBtn;
  final isShowDeleteBtn;
  final isShowCloseBtn;

  const MyBallPopup(
      {Key key,
      this.onModify,
      this.onDelete,
      this.onShare,
      this.isShowShareBtn = false,
      this.isShowModifyBtn = true,
      this.isShowDeleteBtn = true,
      this.isShowCloseBtn=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyBallPopupViewModel(),
      child: Consumer<MyBallPopupViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: 221,
                height: widgetHeight,
                child: Column(
                  children: [
                    isShowShareBtn ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Material(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  onShare(context);
                                },
                                child: Container(
                                  height: 50,
                                  child: Center(
                                    child: Text("공유하기"),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ): Container(),
                    isShowShareBtn ? Divider(
                      color: Color(0xffE4E7E8),
                      height: 1,
                    ): Container(),
                    isShowModifyBtn ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              onModify(context);
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text("수정하기"),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ): Container(),
                    isShowModifyBtn? Divider(
                      color: Color(0xffE4E7E8),
                      height: 1,
                    ): Container(),
                    isShowDeleteBtn ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              onDelete(context);
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text("삭제하기"),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ): Container(),
                    isShowDeleteBtn ? Divider(
                      color: Color(0xffE4E7E8),
                      height: 1,
                    ): Container(),
                    isShowCloseBtn ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text("닫기"),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ): Container()
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  get widgetHeight {
    double height = 0;
    if(isShowShareBtn){
      height += 51;
    }
    if(isShowModifyBtn){
      height += 51;
    }
    if(isShowDeleteBtn){
      height += 51;
    }
    if(isShowCloseBtn){
      height += 51;
    }
    return height;
  }
}

class MyBallPopupViewModel extends ChangeNotifier {


}
