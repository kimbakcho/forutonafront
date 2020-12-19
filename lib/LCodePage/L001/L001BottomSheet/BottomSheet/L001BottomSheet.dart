import 'package:flutter/material.dart';
import 'package:forutonafront/Components/CloseButton/BottomSheetCloseButton.dart';
import 'package:forutonafront/LCodePage/L001/L001BottomSheet/BottomSlider/L001BottomSheetPageSlider.dart';

import 'package:provider/provider.dart';

class L001BottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L001BottomSheetViewModel(),
        child: Consumer<L001BottomSheetViewModel>(builder: (_, model, child) {
          return Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  16,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: Container(
                  child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16, top: 16),
                    child: BottomSheetCloseButton(),
                  )
                ]),
                SizedBox(
                  height: 30,
                ),
                Expanded(child: Container(child: L001BottomSheetPageSlider()))
              ])));
        }));
  }
}

class L001BottomSheetViewModel extends ChangeNotifier {}
