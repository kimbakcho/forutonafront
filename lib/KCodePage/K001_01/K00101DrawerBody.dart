import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum K00101DrawerItem { PlayPoint, ABC, Followers }

class K00101DrawerBody extends StatelessWidget {
  final K00101DrawerItem initSelectItem;
  final K00101DrawerBodyListener k00101drawerBodyListener;

  const K00101DrawerBody(
      {Key key, this.initSelectItem, this.k00101drawerBodyListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => K00101DrawerBodyViewModel(),
        child: Consumer<K00101DrawerBodyViewModel>(builder: (_, model, __) {
          return Column(children: [
            Material(
                color: Colors.white,
                child: ListTile(
                    selected: initSelectItem == K00101DrawerItem.PlayPoint
                        ? true
                        : false,
                    title: Text("영향력순",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                    onTap: ()  {
                          k00101drawerBodyListener
                              .onBodySelectItem(K00101DrawerItem.PlayPoint);
                          Navigator.pop(context);
                        },
                    trailing: initSelectItem == K00101DrawerItem.PlayPoint
                        ? Icon(Icons.check)
                        : Container(
                            width: 36,
                            height: 36,
                          ))),
            Material(
                color: Colors.white,
                child: ListTile(
                    selected:
                        initSelectItem == K00101DrawerItem.ABC ? true : false,
                    title: Text("가나다순",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                    onTap: ()  {
                          k00101drawerBodyListener
                              .onBodySelectItem(K00101DrawerItem.ABC);
                          Navigator.pop(context);
                        },
                    trailing: initSelectItem == K00101DrawerItem.ABC
                        ? Icon(Icons.check)
                        : Container(
                            width: 36,
                            height: 36,
                          ))),
            Material(
                color: Colors.white,
                child: ListTile(
                    selected: initSelectItem == K00101DrawerItem.Followers
                        ? true
                        : false,
                    title: Text("팔로워순",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                    onTap: () {
                          k00101drawerBodyListener
                              .onBodySelectItem(K00101DrawerItem.Followers);
                          Navigator.pop(context);
                        },
                    trailing: initSelectItem == K00101DrawerItem.Followers
                        ? Icon(Icons.check)
                        : Container(
                            width: 36,
                            height: 36,
                          )))
          ]);
        }));
  }
}

class K00101DrawerBodyViewModel extends ChangeNotifier {}

abstract class K00101DrawerBodyListener {
  onBodySelectItem(K00101DrawerItem item);
}
