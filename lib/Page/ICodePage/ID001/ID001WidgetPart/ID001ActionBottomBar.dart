import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:forutonafront/Components/FBallReply2/FullReviewPage/FullReviewPage.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewCountMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewDeleteMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewInertMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewUpdateMediator.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001MainPage2ViewModel.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/Page/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'ID001LikeAction.dart';

class ID001ActionBottomBar extends StatelessWidget {
  final String ballUuid;
  final ReviewInertMediator? reviewInertMediator;
  final ReviewCountMediator? reviewCountMediator;
  final ReviewDeleteMediator? reviewDeleteMediator;
  final ReviewUpdateMediator? reviewUpdateMediator;

  ID001ActionBottomBar(
      {required this.ballUuid,
      this.reviewCountMediator,
      this.reviewDeleteMediator,
      this.reviewInertMediator,
      this.reviewUpdateMediator});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001ActionBottomBarViewModel(
            context: context,
            reviewCountMediator: reviewCountMediator!,
            valuationMediator:
                Provider.of<ID001MainPage2ViewModel>(context).valuationMediator,
            ballUuid: ballUuid),
        child: Consumer<ID001ActionBottomBarViewModel>(builder: (_, model, __) {
          return Container(
            child: Row(
              children: <Widget>[
                RawMaterialButton(
                    padding: EdgeInsets.all(5),
                    constraints: BoxConstraints(),
                    child: Icon(Icons.card_giftcard),
                    onPressed: () {}),
                RawMaterialButton(
                    padding: EdgeInsets.all(5),
                    constraints: BoxConstraints(),
                    child: Icon(ForutonaIcon.heart),
                    onPressed: () {}),
                RawMaterialButton(
                    padding: EdgeInsets.all(5),
                    constraints: BoxConstraints(),
                    child: Icon(ForutonaIcon.share),
                    onPressed: () {}),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => FullReviewPage(
                              ballUuid: ballUuid,
                              reviewUpdateMediator: reviewUpdateMediator,
                              reviewDeleteMediator: reviewDeleteMediator,
                              reviewInertMediator: reviewInertMediator,
                              reviewCountMediator: reviewCountMediator,
                            )));
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Icon(ForutonaIcon.chat),
                        width: 42,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                      Positioned(
                          right: 0,
                          top: 14,
                          child: Container(
                            width: 31,
                            height: 13,
                            child: Text(
                              "${model.reviewCount}",
                              style: GoogleFonts.notoSans(
                                fontSize: 9,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xffff4e6a),
                            ),
                          ))
                    ],
                  ),
                ),
                Spacer(),
                ID001LikeAction(
                  ballUuid: ballUuid,
                  valuationMediator:
                      Provider.of<ID001MainPage2ViewModel>(context)
                          .valuationMediator,
                )
              ],
            ),
            width: MediaQuery.of(context).size.width,
            decoration:
                BoxDecoration(color: Color(0xffFFFFFF).withOpacity(0.9)),
          );
        }));
  }
}

class ID001ActionBottomBarViewModel extends ChangeNotifier
    implements ValuationMediatorComponent, ReviewCountMediatorComponent {
  String? ballUuid;
  final ValuationMediator? _valuationMediator;
  final ReviewCountMediator? _reviewCountMediator;
  final BuildContext? context;

  ID001ActionBottomBarViewModel({
    this.ballUuid,
    this.context,
    required ValuationMediator? valuationMediator,
    ReviewCountMediator? reviewCountMediator,
  })  : _valuationMediator = valuationMediator,
        _reviewCountMediator = reviewCountMediator {
    _valuationMediator!.registerComponent(this);
    _reviewCountMediator!.registerComponent(this);
    _reviewCountMediator!.reqReviewCount(ballUuid!);
  }


  @override
  void dispose() {
    _reviewCountMediator!.unregisterComponent(this);
    _valuationMediator!.unregisterComponent(this);
    super.dispose();
  }

  @override
  valuationReqNotification() {
    notifyListeners();
  }

  get reviewCount {
    return _reviewCountMediator!.reviewCount;
  }

  @override
  onReviewCount(int reviewCount) {
    notifyListeners();
  }
}
