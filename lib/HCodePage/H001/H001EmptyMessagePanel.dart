import 'package:flutter/material.dart';

class H001EmptyMessagePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:  Text.rich(
        TextSpan(
          style: TextStyle(
            fontFamily: 'Gibson',
            fontSize: 23,
            color: const Color(0xff454f63),
            letterSpacing: -0.46,
            height: 1.2857142857142858,
          ),
          children: [
            TextSpan(
              text: '아쉽지만\n검색하신 지역에 컨텐츠가 없습니다.',
              style: TextStyle(
                fontFamily: 'Noto Sans CJK KR',
                fontSize: 14,
                color: const Color(0xffb1b1b1),
                letterSpacing: -0.28,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
