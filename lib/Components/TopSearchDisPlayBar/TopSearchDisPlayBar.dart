import 'package:flutter/material.dart';

import 'package:forutonafront/Components/BackButton/BorderCircleBackButton.dart';
import 'package:forutonafront/Components/InputSearchBar/InputSearchBar.dart';

class TopSearchDisPlayBar extends StatelessWidget {

  final String initText;

  const TopSearchDisPlayBar({Key key, this.initText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Color(0xffE4E7E8)))
      ),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        children: [
          BorderCircleBackButton(),
          SizedBox(width: 16,),
          Expanded(
            child: InputSearchBar(
              readOnly: true,
              autoFocusFlag: false,
              inputSearchBarListener: null,
              searchHistoryViewController: null,
              initText: this.initText,
            ),
          )
        ],
      ),
    );
  }
}
