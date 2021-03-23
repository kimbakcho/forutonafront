import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/CommonValue/Value/ReplyMaliciousType.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:provider/provider.dart';

class OtherUserBallPopup extends StatelessWidget {
  final Function(BuildContext context, MaliciousType replyMaliciousType)
      onReportMalicious;

  final Function(BuildContext context) onShare;

  final Function(BuildContext context) onNotInterest;

  final Function(BuildContext context) onFavourite;

  final isShowShareBtn;

  final isShowNotInterestBtn;

  final isShowFavourite;

  final isShowReportMalicious;

  final isShowCloseBtn;

  const OtherUserBallPopup(
      {Key key,
      this.onReportMalicious,
      this.onShare,
      this.onNotInterest,
      this.onFavourite,
      this.isShowFavourite = false,
      this.isShowNotInterestBtn = false,
      this.isShowShareBtn = false,
      this.isShowReportMalicious = true,
      this.isShowCloseBtn = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtherUserBallPopupViewModel(onReportMalicious),
      child: Consumer<OtherUserBallPopupViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: 221,
                height: widgetHeight,
                child: Column(
                  children: [
                    isShowShareBtn
                        ? _makeBar(
                            label: "공유 하기",
                            ontTap: () {
                              onShare(context);
                            })
                        : Container(),
                    isShowNotInterestBtn
                        ? _makeBar(
                            label: "관심 없음",
                            ontTap: () async {
                              await onNotInterest(context);
                              Navigator.of(context).pop();
                            })
                        : Container(),
                    isShowFavourite
                        ? _makeBar(
                            label: "즐겨찾기에 저장",
                            ontTap: () {
                              onFavourite(context);
                            })
                        : Container(),
                    isShowReportMalicious
                        ? _makeBar(
                            label: "신고하기",
                            ontTap: () {
                              model.showReportItem(context);
                            })
                        : Container(),
                    isShowCloseBtn
                        ? _makeBar(
                            label: "닫기",
                            ontTap: () {
                              Navigator.of(context).pop();
                            })
                        : Container(),
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

  Widget _makeBar({Function ontTap, String label}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Material(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  ontTap();
                },
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(label),
                  ),
                ),
              ),
            ))
          ],
        ),
        Divider(
          color: Color(0xffE4E7E8),
          height: 1,
        )
      ],
    );
  }

  get widgetHeight {
    double height = 0;
    if (isShowShareBtn) {
      height += 51;
    }
    if (isShowNotInterestBtn) {
      height += 51;
    }
    if (isShowShareBtn) {
      height += 51;
    }
    if (isShowReportMalicious) {
      height += 51;
    }
    if (isShowCloseBtn) {
      height += 51;
    }
    return height;
  }
}

class OtherUserBallPopupViewModel extends ChangeNotifier {
  final Function(BuildContext context, MaliciousType replyMaliciousType)
      onReportMalicious;

  OtherUserBallPopupViewModel(this.onReportMalicious);

  reportMaliciousReply(
      BuildContext context, MaliciousType replyMaliciousType) async {
    await onReportMalicious(context, replyMaliciousType);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  reportMaliciousWithLoading(
      BuildContext context, MaliciousType replyMaliciousType) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          reportMaliciousReply(context, replyMaliciousType);
          return CommonLoadingComponent();
        });
  }

  void showReportItem(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0))),
        context: context,
        builder: (context) {
          return Container(
            height: 350,
            child: Column(
              children: [
                ListTile(
                  title: Text("범죄 또는 이름 조장"),
                  onTap: () {
                    reportMaliciousWithLoading(context, MaliciousType.crime);
                  },
                ),
                ListTile(
                  title: Text("욕설,차별,사칭 등 타인에 대한 위협 및 피해"),
                  onTap: () {
                    reportMaliciousWithLoading(context, MaliciousType.abuse);
                  },
                ),
                ListTile(
                  title: Text("사생활 침해,개인정보 노출"),
                  onTap: () {
                    reportMaliciousWithLoading(context, MaliciousType.privacy);
                  },
                ),
                ListTile(
                  title: Text("성적인 메세지"),
                  onTap: () {
                    reportMaliciousWithLoading(context, MaliciousType.sexual);
                  },
                ),
                ListTile(
                  title: Text("광고성 메시지"),
                  onTap: () {
                    reportMaliciousWithLoading(
                        context, MaliciousType.advertising);
                  },
                ),
                ListTile(
                  title: Text("기타"),
                  onTap: () {
                    reportMaliciousWithLoading(context, MaliciousType.etc);
                  },
                )
              ],
            ),
          );
        });
  }
}
