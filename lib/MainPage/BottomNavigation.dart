import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/LCodePage/L001/L001BottomSheet/BottomSheet/L001BottomSheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'KPageNavBtn.dart';

enum BottomNavigationNavType {
  HOME,SEARCH,SNS
}

class BottomNavigation extends StatefulWidget {
  final BottomNavigationListener bottomNavigationListener;

  const BottomNavigation({Key key, this.bottomNavigationListener}) : super(key: key);
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BottomNavigationViewModel(context: context),
        child: Consumer<BottomNavigationViewModel>(builder: (_, model, __) {
          return Consumer<BottomNavigationViewModel>(
              builder: (_, model, child) {
            return Container(
                height: 52,
                child: Row(children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: FlatButton(
                        onPressed: () {
                          if(widget.bottomNavigationListener != null){
                            widget.bottomNavigationListener.onBottomNavClick(BottomNavigationNavType.HOME);
                          }
                        },
                        child: Icon(Icons.home),
                      )),
                  Expanded(flex: 1, child: KPageNavBtn()),
                  Expanded(
                      flex: 1,
                      child:
                          FlatButton(onPressed: () {}, child: Icon(Icons.add))),
                  Expanded(
                      flex: 1,
                      child: FlatButton(
                          onPressed: () {
                            if(widget.bottomNavigationListener != null){
                              widget.bottomNavigationListener.onBottomNavClick(BottomNavigationNavType.SNS);
                            }
                          },
                          child: Icon(
                            ForutonaIcon.officialchannel,
                          ))),
                  Expanded(
                      flex: 1,
                      child: FlatButton(
                          onPressed: () {
                            model.showL001BottomSheet();
                          },
                          child: Icon(
                            ForutonaIcon.snsservicemenu,
                            size: 19,
                          ))),
                ]),
                decoration: BoxDecoration(color: Color(0xffffffff), boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.16),
                    blurRadius: 6,
                  )
                ]));
          });
        }));
  }
}

class BottomNavigationViewModel extends ChangeNotifier {
  final BuildContext context;

  BottomNavigationViewModel({this.context});

  showL001BottomSheet(){
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

abstract class BottomNavigationListener {
  void onBottomNavClick(BottomNavigationNavType bottomNavigationNavType);
}