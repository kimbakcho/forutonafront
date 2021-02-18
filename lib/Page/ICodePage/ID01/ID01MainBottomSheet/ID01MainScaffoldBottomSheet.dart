
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:provider/provider.dart';

class ID01MainScaffoldBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01MainScaffoldBottomSheetViewModel(),
      child: Consumer<ID01MainScaffoldBottomSheetViewModel>(
        builder: (_, model, child) {
          return Container(
            height: 50,
            color: Colors.white.withOpacity(0.7),
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
                      child: Icon(Icons.card_giftcard),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                      child: Icon(Icons.share),
                    ),
                  ),
                ),
                Spacer(),
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Color(0xff3A3E3F),width: 1),
                    ),
                    onTap: (){

                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Color(0xff3A3E3F),width: 1)
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.how_to_vote),
                            margin: EdgeInsets.only(right: 8),
                          ),
                          Text("312")
                        ],
                      ),
                    ) 
                    ,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ID01MainScaffoldBottomSheetViewModel extends ChangeNotifier {}
