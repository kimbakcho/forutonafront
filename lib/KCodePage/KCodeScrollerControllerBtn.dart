import 'package:flutter/material.dart';
import 'package:forutonafront/KCodePage/KCodeScrollerControllerAniBuilder.dart';

class KCodeScrollerControllerBtn extends StatelessWidget {

  final KCodeScrollerController kCodeScrollerController;
  final ScrollController mainScroller;

  const KCodeScrollerControllerBtn(
      {Key key, this.mainScroller, this.kCodeScrollerController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KCodeScrollerControllerAniBuilder(
      child: Container(
        width: 36,
        height: 36,
        child: Material(
          shape: CircleBorder(),
          child: InkWell(
            onTap: () {
              mainScroller.animateTo(0,
                  duration: Duration(milliseconds: 500), curve: Curves.easeOut);
            },
            child: Icon(Icons.keyboard_arrow_up),
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
      ),
      startPosition: -30,
      endPosition: 48,
      controller: kCodeScrollerController,
    );
  }
}
