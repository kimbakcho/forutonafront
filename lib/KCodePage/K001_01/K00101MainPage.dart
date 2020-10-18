import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../KCodeDrawer/KCodeDrawer.dart';
import '../KCodeTopFilterBar.dart';
import 'K00101DrawerBody.dart';

class K00101MainPage extends StatelessWidget {

  final String searchText;

  const K00101MainPage({Key key, this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => K00101MainPageViewModel(
          context: context
        ),
        child: Consumer<K00101MainPageViewModel>(builder: (_, model, __) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: ListView(
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    KCodeTopFilterBar(
                      searchText: searchText,
                      descriptionText: "관련 닉네임",
                      kCodeTopFilterBarController: model.kCodeTopFilterBarController,
                    )
                  ],
                ),
              )
              
            ],
          );
        }));
  }
}

class K00101MainPageViewModel extends ChangeNotifier {

  KCodeTopFilterBarController kCodeTopFilterBarController;
  final BuildContext context;

  K00101MainPageViewModel({this.context}){
    kCodeTopFilterBarController = KCodeTopFilterBarController(
      onFilter: openBottomSheet
    );
  }

  openBottomSheet() {
    showMaterialModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context, _) {
          return KCodeDrawer(
              drawerBody: K00101DrawerBody(
            initSelectItem: K00101DrawerItem.PlayPoint,
          ));
        });
  }
}
