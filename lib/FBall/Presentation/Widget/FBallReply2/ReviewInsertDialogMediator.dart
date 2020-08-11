//import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
//
//abstract class ReviewInsertDialogComponent {
//  onOpenInertDialog(FBallReplyResDto parentReplyResDto);
//}
//
//abstract class ReviewInsertDialogMediator {
//  openInsertDialog(FBallReplyResDto parentReplyResDto);
//
//  registerDialogComponent(ReviewInsertDialogComponent component);
//}
//
//class ReviewInsertDialogMediatorImpl implements ReviewInsertDialogMediator {
//  ReviewInsertDialogComponent component;
//
//  registerDialogComponent(ReviewInsertDialogComponent component) {
//    if (this.component == null) {
//      this.component = component;
//    } else {
//      throw Exception("registered Dialog component only can one Dialog");
//    }
//  }
//
//  @override
//  openInsertDialog(FBallReplyResDto parentReplyResDto) {
//    if(this.component != null){
//      this.component.onOpenInertDialog(parentReplyResDto);
//    }else {
//      throw Exception("not register Dialog component");
//    }
//  }
//}
