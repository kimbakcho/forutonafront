import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum K00101DrawerItem { PlayPoint, ABC, Followers }

class K00101DrawerBody extends StatelessWidget {
  final K00101DrawerItem initSelectItem;

  const K00101DrawerBody({Key key, this.initSelectItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Material(
          color: Colors.white,
          child: ListTile(
              selected:
                  initSelectItem == K00101DrawerItem.PlayPoint ? true : false,
              title: Text("영향력순",
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              onTap: () => {print("영향력순")},
              trailing: initSelectItem == K00101DrawerItem.PlayPoint
                  ? Icon(Icons.check)
                  : Container(
                      width: 36,
                      height: 36,
                    ))),
      Material(
          color: Colors.white,
          child: ListTile(
              selected: initSelectItem == K00101DrawerItem.ABC ? true : false,
              title: Text("가나다순",
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              onTap: () => {print("가나다순")},
              trailing: initSelectItem == K00101DrawerItem.ABC
                  ? Icon(Icons.check)
                  : Container(
                      width: 36,
                      height: 36,
                    ))),
      Material(
          color: Colors.white,
          child: ListTile(
              selected:
                  initSelectItem == K00101DrawerItem.Followers ? true : false,
              title: Text("팔로워순",
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              onTap: () => {print("팔로워순")},
              trailing: initSelectItem == K00101DrawerItem.Followers
                  ? Icon(Icons.check)
                  : Container(
                      width: 36,
                      height: 36,
                    )))
    ]);
  }
}
