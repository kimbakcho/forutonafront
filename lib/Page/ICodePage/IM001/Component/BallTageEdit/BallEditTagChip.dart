import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:provider/provider.dart';

import 'TagEditDto.dart';

class BallEditTagChip extends StatelessWidget {

  final TagEditItemDto tagEditItemDto;

  final Function(BallEditTagChip) onDeleteTap;

  const BallEditTagChip({Key key, this.onDeleteTap, this.tagEditItemDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BallEditTagChipViewModel(),
      child: Consumer<BallEditTagChipViewModel>(
        builder: (_, model, child) {
          return Container(
            padding: EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),

            decoration: BoxDecoration(
              color: Color(0xffCCCCCC),
              borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(tagEditItemDto.text),
                SizedBox(width: 16,),
                CircleIconBtn(
                  onTap: (){
                    onDeleteTap(this);
                  },
                  height: 14,
                  width: 14,
                  border: Border.all(color: Colors.black,width: 1),
                  icon: Icon(Icons.close,size: 12,),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class BallEditTagChipViewModel extends ChangeNotifier {}

