import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/MapIntentButton/MapintentButton.dart';
import 'package:forutonafront/Components/DetailPage/DBallAddressWidget.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/ID01RemainTimeProgress.dart';

import 'package:provider/provider.dart';

class ID01MainBottomSheetHeader extends StatefulWidget {

  final FBallResDto? fBallResDto;

  final Function(Position)? onTapAddress;

  const ID01MainBottomSheetHeader({Key? key, this.fBallResDto, this.onTapAddress}) : super(key: key);

  @override
  _ID01MainBottomSheetHeaderState createState() => _ID01MainBottomSheetHeaderState();
}

class _ID01MainBottomSheetHeaderState extends State<ID01MainBottomSheetHeader> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>ID01MainBottomSheetHeaderViewModel(widget.fBallResDto),
      child: Consumer<ID01MainBottomSheetHeaderViewModel>(
          builder: (_,model,child){
            return Container(
              height: 88,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      height: 32,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 13,
                            height: 2,
                            decoration: BoxDecoration(
                                color: Color(0xffE4E7E8),
                                borderRadius: BorderRadius.all(Radius.circular(20)),

                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Container(
                                margin: EdgeInsets.only(left: 16,right: 16),
                                child: DBallAddressWidget(fBallResDto: model.fBallResDto,onTabAddress: (Position position){
                                  widget.onTapAddress!(position);
                                },)
                                ,
                              ))
                            ],
                          ),
                          Positioned(
                            right: 16,
                            child: MapIntentButton(
                              dstPosition: model._ballPosition!,
                              dstAddress: model.fBallResDto!.placeAddress!,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 17,),
                    ID01RemainTimeProgress(
                      createTime: model.fBallResDto!.makeTime,
                      limitTime: model.fBallResDto!.activationTime,
                    ),

                  ],
                ),
            );
          }
      ),
    );
  }
}

class ID01MainBottomSheetHeaderViewModel extends ChangeNotifier{

  final FBallResDto? fBallResDto;

  Position? _ballPosition;


  ID01MainBottomSheetHeaderViewModel(this.fBallResDto){

    _ballPosition = Position(
      latitude: fBallResDto!.latitude,
      longitude: fBallResDto!.longitude
    );
  }

}
