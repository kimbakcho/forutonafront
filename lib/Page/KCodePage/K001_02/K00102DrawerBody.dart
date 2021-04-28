import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum K00102DrawerItem { BallPower, Hit, MakeTime, Distance }

class K00102DrawerBody extends StatelessWidget {
  final K00102DrawerItem? initSelectItem;
  final K00102DrawerBodyListener? k00102drawerBodyListener;

  const K00102DrawerBody(
      {Key? key, this.initSelectItem, this.k00102drawerBodyListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => K00102DrawerBodyViewModel(),
        child: Consumer<K00102DrawerBodyViewModel>(builder: (_, model, __) {
          return Column(children: [
            Material(
                color: Colors.white,
                child: ListTile(
                    selected: initSelectItem == K00102DrawerItem.BallPower
                        ? true
                        : false,
                    title: Text("영향력순",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                    onTap: () {
                      k00102drawerBodyListener!
                          .onBodySelectItem(K00102DrawerItem.BallPower);
                      Navigator.pop(context);
                    },
                    trailing: initSelectItem == K00102DrawerItem.BallPower
                        ? Icon(Icons.check)
                        : Container(
                            width: 36,
                            height: 36,
                          ))),
            Material(
                color: Colors.white,
                child: ListTile(
                    selected:
                        initSelectItem == K00102DrawerItem.Hit ? true : false,
                    title: Text("조회수순",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                    onTap: () {
                      k00102drawerBodyListener!
                          .onBodySelectItem(K00102DrawerItem.Hit);
                      Navigator.pop(context);
                    },
                    trailing: initSelectItem == K00102DrawerItem.Hit
                        ? Icon(Icons.check)
                        : Container(
                            width: 36,
                            height: 36,
                          ))),
            Material(
                color: Colors.white,
                child: ListTile(
                    selected: initSelectItem == K00102DrawerItem.MakeTime
                        ? true
                        : false,
                    title: Text("최신순",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                    onTap: () {
                      k00102drawerBodyListener!
                          .onBodySelectItem(K00102DrawerItem.MakeTime);
                      Navigator.pop(context);
                    },
                    trailing: initSelectItem == K00102DrawerItem.MakeTime
                        ? Icon(Icons.check)
                        : Container(
                            width: 36,
                            height: 36,
                          ))),
            Material(
                color: Colors.white,
                child: ListTile(
                    selected: initSelectItem == K00102DrawerItem.Distance
                        ? true
                        : false,
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text("가까운 거리순",
                          style: GoogleFonts.notoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      Text("검색결과를 내 위치에서 가까운 순서대로 표시합니다.",
                          style: GoogleFonts.notoSans(
                            fontSize: 12,
                            color: const Color(0xff454f63),
                          ))
                    ]),
                    onTap: () {
                      k00102drawerBodyListener!
                          .onBodySelectItem(K00102DrawerItem.Distance);
                      Navigator.pop(context);
                    },
                    trailing: initSelectItem == K00102DrawerItem.Distance
                        ? Icon(Icons.check)
                        : Container(
                            width: 36,
                            height: 36,
                          )))
          ]);
        }));
  }
}

class K00102DrawerBodyViewModel extends ChangeNotifier {}

abstract class K00102DrawerBodyListener {
  onBodySelectItem(K00102DrawerItem item);
}
