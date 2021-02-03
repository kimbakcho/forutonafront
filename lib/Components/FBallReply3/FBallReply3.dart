import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Components/FBallReply2/BasicReViewsContentBars.dart';
import 'package:forutonafront/Components/FBallReply2/BasicReViewsInsert.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewCountMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewDeleteMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewInertMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewInsertRow.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewUpdateMediator.dart';
import 'package:forutonafront/Page/JCodePage/J001/J001View.dart';
import 'package:forutonafront/Page/LCodePage/L001/L001BottomSheet/BottomSheet/L001BottomSheet.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class FBallReply3 extends StatelessWidget {

  final String ballUuid;

  const FBallReply3({Key key, this.ballUuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FBallReply3ViewModel(sl(),sl(),ballUuid),
      child: Consumer<FBallReply3ViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Column(
              children: [
                Divider(
                  color: Color(0xffE4E7E8),
                  height: 1,
                ),
                InkWell(
                    onTap: () {
                      model.showRootReplyInputDialog(context);
                    },
                    child: IgnorePointer(
                        child: ReviewTextActionRow(
                          autoFocus: false,
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          userProfileImage: model.userProfileImage,
                        ))),
                Divider(
                  color: Color(0xffE4E7E8),
                  height: 1,
                ),
                BasicReViewsContentBars(
                  ballUuid: ballUuid,
                  reviewCountMediator: model._reviewCountMediator,
                  reviewInertMediator: model._reviewInertMediator,
                  reviewUpdateMediator: model._reviewUpdateMediator,
                  reviewDeleteMediator: model._reviewDeleteMediator,
                  canSubReplyInsert: true,
                  pageLimit: 20,
                  listable: true,
                  showChildReply: true,
                  showEditBtn: true,
                )
              ],
            ),

          );
        },
      ),
    );
  }
}

class FBallReply3ViewModel extends ChangeNotifier {

  final SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort;
  final FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase;
  final String ballUuid;

  ReviewInertMediator _reviewInertMediator;
  ReviewCountMediator _reviewCountMediator;
  ReviewUpdateMediator _reviewUpdateMediator;
  ReviewDeleteMediator _reviewDeleteMediator;

  FBallReply3ViewModel(this.signInUserInfoUseCaseInputPort, this.fireBaseAuthAdapterForUseCase,this.ballUuid){
    _reviewInertMediator = ReviewInertMediatorImpl(
      fBallReplyUseCaseInputPort: sl()
    );
    _reviewCountMediator = ReviewCountMediatorImpl(
      fBallReplyUseCaseInputPort: sl()
    );
    _reviewUpdateMediator = ReviewUpdateMediatorImpl(
      fBallReplyUseCaseInputPort: sl()
    );
    _reviewDeleteMediator = ReviewDeleteMediatorImpl(
      fBallReplyUseCaseInputPort: sl()
    );
  }

  showRootReplyInputDialog(BuildContext context) async {
    if (await fireBaseAuthAdapterForUseCase.isLogin()) {
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

      showMaterialModalBottomSheet(
          context: context,
          expand: false,
          backgroundColor: Colors.transparent,
          enableDrag: true,
          builder: (context) {
            return L001BottomSheet();
          });
    }
  }

  ImageProvider get userProfileImage {
    if(signInUserInfoUseCaseInputPort.isLogin){
      var profilePictureUrl = signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory().profilePictureUrl;
      return NetworkImage(profilePictureUrl);
    }else {
      return AssetImage("assets/basicprofileimage.png");
    }

  }
}
