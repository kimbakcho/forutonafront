import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../ID001MainPage2ViewModel.dart';

class ID001AppBar extends StatelessWidget {
  final ScrollController listViewScrollerController;
  final String ballName;

  const ID001AppBar(
      {Key key, this.model, this.ballName, this.listViewScrollerController})
      : super(key: key);
  final ID001MainPage2ViewModel model;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001AppBarViewModel(
            listViewScrollerController: listViewScrollerController),
        child: Consumer<ID001AppBarViewModel>(builder: (_, model, __) {
          return Container(
              height: 56.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BackButton(
                        color: Colors.black,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    model.showBallName
                        ? Expanded(
                            child: Container(
                              child: Text(ballName,style: GoogleFonts.notoSans(
                                fontSize: 16,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                                height: 1.25,
                              )),
                            ),
                          )
                        : Container(),
                    IconButton(
                      icon: Icon(ForutonaIcon.pointdash),
                      iconSize: 13.0,
                      onPressed: () {},
                    )
                  ]));
        }));
  }
}

class ID001AppBarViewModel extends ChangeNotifier {
  final ScrollController listViewScrollerController;
  bool showBallName = false;

  ID001AppBarViewModel({this.listViewScrollerController}) {
    listViewScrollerController.addListener(listViewScrollerListener);
  }

  listViewScrollerListener() {
    bool tempShowBallName = showBallName;
    if (listViewScrollerController.offset > 30.0) {
      showBallName = true;
    } else {
      showBallName = false;
    }
    if (tempShowBallName != showBallName) {
      notifyListeners();
    }
  }
}
