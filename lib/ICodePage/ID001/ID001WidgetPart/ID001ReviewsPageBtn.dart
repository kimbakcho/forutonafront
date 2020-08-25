import 'package:flutter/material.dart';
import 'package:forutonafront/Components/FBallReply2/FullReviewPage/FullReviewPage.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewCountMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewDeleteMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewInertMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewUpdateMediator.dart';
import 'package:google_fonts/google_fonts.dart';

class ID001ReviewsPageBtn extends StatelessWidget {
  final String ballUuid;
  final ReviewInertMediator reviewInertMediator;
  final ReviewCountMediator reviewCountMediator;
  final ReviewDeleteMediator reviewDeleteMediator;
  final ReviewUpdateMediator reviewUpdateMediator;

  const ID001ReviewsPageBtn(
      {Key key,
      this.ballUuid,
      this.reviewInertMediator,
      this.reviewDeleteMediator,
      this.reviewUpdateMediator,
      this.reviewCountMediator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: EdgeInsets.all(16),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => FullReviewPage(
                    ballUuid: ballUuid,
                    reviewInertMediator: reviewInertMediator,
                    reviewCountMediator: reviewCountMediator,
                    reviewUpdateMediator: reviewUpdateMediator,
                    reviewDeleteMediator: reviewDeleteMediator,
                  )));
        },
        child: Text(
          '댓글 페이지로 이동하기',
          style: GoogleFonts.notoSans(
            fontSize: 16,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          border: Border.all(color: Colors.black, width: 2)),
    );
  }
}
