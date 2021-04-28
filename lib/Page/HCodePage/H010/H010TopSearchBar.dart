import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BackButton/BorderCircleBackButton.dart';
import 'package:forutonafront/Components/InputSearchBar/InputSearchBar.dart';


import 'SearchHistoryView.dart';

class H010TopSearchBar extends StatelessWidget {
  final SearchHistoryViewController? searchHistoryViewController;

  final InputSearchBarListener? inputSearchBarListener;

  const H010TopSearchBar({Key? key, this.searchHistoryViewController, this.inputSearchBarListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xffF2F0F1)))
      ),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        children: [
          BorderCircleBackButton(),
          SizedBox(width: 16,),
          Expanded(
            child: InputSearchBar(
              readOnly: false,
              autoFocusFlag: true,
              searchHistoryViewController: searchHistoryViewController,
              inputSearchBarListener: inputSearchBarListener,
              initText: "",
            ),
          )
        ],
      ),
    );
  }
}


