import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'KCodeDrawerBottom.dart';
import 'KCodeDrawerTopBar.dart';

class KCodeDrawer extends StatelessWidget {
  final Widget? drawerBody;

  const KCodeDrawer({Key? key, this.drawerBody}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              KCodeDrawerTopBar(),
              drawerBody!,
              KCodeDrawerBottom()
            ],
          ),
        ));
  }
}
