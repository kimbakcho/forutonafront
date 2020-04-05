import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Dto/UserToMakerBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserToMakerBallResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:provider/provider.dart';

import '../../../GlobalModel.dart';

class H00302PageViewModel extends ChangeNotifier {
  final BuildContext context;
  FBallRepository _fballRepository =  FBallRepository();
  UserToMakerBallResWrapDto userToMakerBallList;
  ScrollController scrollController =  ScrollController();
  int pageCount = 0;
  int limitSize = 10;

  H00302PageViewModel(this.context){
    userToMakerBallList = new UserToMakerBallResWrapDto(DateTime.now(),[]);
    scrollController.addListener(scrollListener);
    this.init();
  }
  init() async {
    await ballListUp();
  }
  Future ballListUp() async {
    var globalModel = Provider.of<GlobalModel>(context,listen: false);
    List<MultiSort> sorts = new List<MultiSort>();
    sorts.add(MultiSort("Alive",QueryOrders.DESC));
    //start가 Join Time
    sorts.add(MultiSort("makeTime",QueryOrders.DESC));
    MultiSorts wrapsorts = new MultiSorts(sorts) ;
    var userToMakerBallReqDto = UserToMakerBallReqDto(globalModel.fUserInfoDto.uid,pageCount,limitSize,wrapsorts.toQureyJson());
    if(pageCount == 0){
      this.userToMakerBallList = await _fballRepository.getUserToMakerBalls(userToMakerBallReqDto);
    }else {
      var userToPlayBallResWrapDto = await _fballRepository.getUserToMakerBalls(userToMakerBallReqDto);
      this.userToMakerBallList.contents.addAll(userToPlayBallResWrapDto.contents);
    }
    notifyListeners();

  }
  scrollListener() async{
    /**
     * 맨 밑으로 왔을때 무한 스크롤을 위한 이벤트 처리
     */

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      pageCount++;
      if (pageCount * limitSize >
          userToMakerBallList.contents.length) {
        return;
      } else {
        ballListUp();
      }
    }
  }

}