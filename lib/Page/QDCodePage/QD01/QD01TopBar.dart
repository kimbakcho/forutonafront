import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';

class QD01TopBar extends StatelessWidget {

  final Function? onShowPopup;


  QD01TopBar({this.onShowPopup});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QD01TopBarViewModel(),
      child: Consumer<QD01TopBarViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Row(
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Spacer(),
                IconButton(icon: Icon(ForutonaIcon.share), onPressed: () {

                }),
                IconButton(
                    icon: Icon(ForutonaIcon.dots_vertical_rounded),
                    onPressed: () {
                      if(onShowPopup != null){
                        onShowPopup!();
                      }
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}

class QD01TopBarViewModel extends ChangeNotifier {}
