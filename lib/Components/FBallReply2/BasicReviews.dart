import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'BasicReViewsInsert.dart';
import 'ReviewCountMediator.dart';
import 'ReviewInertMediator.dart';

class BasicReviews extends StatelessWidget {
  final String ballUuid;
  final ReviewInertMediator reviewInertMediator;
  final ReviewCountMediator reviewCountMediator;
  BasicReviews(
      {Key key,
      this.ballUuid,
      this.reviewInertMediator,
      this.reviewCountMediator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001ReviewsViewModel(
            ballUuid: ballUuid,
            reviewInertMediator: reviewInertMediator,
            reviewCountMediator: reviewCountMediator,
            fireBaseAuthAdapterForUseCase: sl(),
            fBallReplyUseCaseInputPort: sl()),
        child: Consumer<ID001ReviewsViewModel>(builder: (_, model, __) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${model.reviewCount}',
                        style: GoogleFonts.notoSans(
                          fontSize: 20,
                          color: const Color(0xffcccccc),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Reviews',
                        style: GoogleFonts.notoSans(
                          fontSize: 10,
                          color: const Color(0xffcccccc),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 38,
                      height: 38,
                      child: FlatButton(
                        onPressed: () {
                          model.showRootReplyInputDialog(context);
                        },
                        child: Icon(Icons.edit, color: Colors.white),
                        padding: EdgeInsets.all(0),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xff007EFF), shape: BoxShape.circle),
                    )
                  ],
                )
              ],
            ),
          );
        }));
  }
}

class ID001ReviewsViewModel extends ChangeNotifier
    implements ReviewCountMediatorComponent {
  final String ballUuid;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final isLoaded = false;
  final ReviewInertMediator _reviewInertMediator;
  final ReviewCountMediator _reviewCountMediator;

  ID001ReviewsViewModel(
      {this.ballUuid,
      FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort,
      FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      ReviewInertMediator reviewInertMediator,
      ReviewCountMediator reviewCountMediator})
      :
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _reviewInertMediator = reviewInertMediator,
        _reviewCountMediator = reviewCountMediator {
    reviewCountMediator.registerComponent(this);

  }
  showRootReplyInputDialog(BuildContext context) async {
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      await showModalBottomSheet(
          context: context,
          isDismissible: true,
          isScrollControlled: true,
          builder: (context) {
            return BasicReViewsInsert(
                ballUuid: ballUuid,
                autoFocus: true,
                reviewCountMediator: _reviewCountMediator,
                reviewInertMediator: _reviewInertMediator);
          });
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return J001View();
      }));
    }
  }


  @override
  void dispose() {
    this._reviewCountMediator.unregisterComponent(this);
    super.dispose();
  }

  get reviewCount {
    return _reviewCountMediator.reviewCount;
  }

  @override
  onReviewCount(int reviewCount) {
    notifyListeners();
  }

}
