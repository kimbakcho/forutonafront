import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SimpleCollectEmptyBar.dart';
import 'SimpleCollectWidgetBottomBar.dart';

class SimpleCollectBottomFactory extends StatelessWidget {
  final SearchCollectMediator? searchCollectMediator;
  final Function? moreCollectAction;
  const SimpleCollectBottomFactory({Key? key, this.searchCollectMediator, this.moreCollectAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchCollectMediator!.currentState ==
        SearchCollectMediatorState.Empty) {
      return SimpleCollectEmptyBar();
    }
    if(searchCollectMediator!.isLastPage!){
      return Container(
        height: 20,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
      );
    }
    return SimpleCollectWidgetBottomBar(
      moreCollectAction: moreCollectAction,
    );

  }
}
