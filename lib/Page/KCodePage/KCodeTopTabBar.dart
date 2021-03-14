import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class KCodeTopTabBar extends StatelessWidget  implements PreferredSizeWidget{
  final KCodeTopTabBarListener kCodeTopTabBarListener;
  final TabController tabController;

  const KCodeTopTabBar(
      {Key key, this.kCodeTopTabBarListener,@required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KCodeTopTabBarViewModel(
          tabController: tabController,
          kCodeTopTabBarListener: kCodeTopTabBarListener),
      child: Consumer<KCodeTopTabBarViewModel>(
        builder: (_, model, __) {
          return Container(
            height: 0,width: 0,
          );


            // Container(
            //   color: Colors.white,
            //   padding: EdgeInsets.fromLTRB(52, 16, 52, 0),
            //   child: TabBar(
            //       onTap: model.onTab,
            //       labelStyle: GoogleFonts.notoSans(
            //         fontSize: 14,
            //         color: const Color(0xff3497fd),
            //         letterSpacing: -0.28,
            //         height: 1.4285714285714286,
            //       ),
            //       unselectedLabelStyle: GoogleFonts.notoSans(
            //         fontSize: 14,
            //         color: const Color(0xff454f63),
            //         letterSpacing: -0.28,
            //         height: 1.4285714285714286,
            //       ),
            //       indicatorWeight: 6,
            //       labelColor: Color(0xff3497fd),
            //       unselectedLabelColor: Color(0xff454f63),
            //       controller: tabController,
            //       labelPadding: EdgeInsets.all(0),
            //       tabs: [
            //         Tab(
            //           text: "전체",
            //         ),
            //         Tab(
            //           text: "닉네임",
            //         ),
            //         Tab(
            //           text: "제목",
            //         ),
            //         Tab(
            //           text: "태그",
            //         )
            //       ]));
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(0);


}

class KCodeTopTabBarViewModel extends ChangeNotifier {
  final TabController tabController;
  final KCodeTopTabBarListener kCodeTopTabBarListener;

  KCodeTopTabBarViewModel(
      {@required this.tabController, this.kCodeTopTabBarListener});

  void onTab(int index) {
    if (tabController.indexIsChanging) {
      if (kCodeTopTabBarListener == null) {
        return;
      }
      if (index == 0) {
        kCodeTopTabBarListener.onTabChange(KCodeTabType.ALL);
      } else if (index == 1) {
        kCodeTopTabBarListener.onTabChange(KCodeTabType.NICKNAME);
      } else if (index == 2) {
        kCodeTopTabBarListener.onTabChange(KCodeTabType.SUBJECT);
      } else if (index == 3) {
        kCodeTopTabBarListener.onTabChange(KCodeTabType.TAG);
      }
    }
  }
}

enum KCodeTabType { ALL, NICKNAME, SUBJECT, TAG }

abstract class KCodeTopTabBarListener {
  onTabChange(KCodeTabType kCodeTabType);
}
