import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:provider/provider.dart';

import 'BallImageItem.dart';



class BallImageEditItem extends StatelessWidget {

  final BallImageItem? ballImageItem;

  final Function(BallImageItem ballImageItem)? onCloseTap;

  const BallImageEditItem({Key? key, this.ballImageItem, this.onCloseTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BallImageEditItemViewModel(),
      child: Consumer<BallImageEditItemViewModel>(
        builder: (_, model, child) {
          return Container(
            height: 66,
            width: 80,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                    bottom: 0,
                    child: Container(
                  width: 75,
                  height: 62,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    image: DecorationImage(
                      image: ballImageItem!.imageProvider!,
                      fit: BoxFit.cover
                    )
                  ),
                )),
                Positioned(
                    top: 13,
                    right: 0,
                    child: CircleIconBtn(
                      width: 14,
                      height: 14,
                      border: Border.all(color: Colors.black,width: 1.0),
                      onTap: (){
                        onCloseTap!(ballImageItem!);
                      },
                      icon: Icon(Icons.close,color: Colors.black,size: 10,),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}

class BallImageEditItemViewModel extends ChangeNotifier {}
