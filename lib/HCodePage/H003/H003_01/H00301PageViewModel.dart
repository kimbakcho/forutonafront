import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/GeolocationRepository.dart';
import 'package:forutonafront/Common/PageableDto/MultiSort.dart';
import 'package:forutonafront/Common/PageableDto/MultiSorts.dart';
import 'package:forutonafront/Common/PageableDto/QueryOrders.dart';
import 'package:forutonafront/FBall/Dto/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserToPlayBallResWrapDto.dart';
import 'package:forutonafront/FBall/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class H00301PageViewModel extends ChangeNotifier{
  final BuildContext context;
  FBallPlayerRepository _fBallPlayerRepository =  FBallPlayerRepository();
  UserToPlayBallResWrapDto userToPlayBallList;
  ScrollController scrollController =  ScrollController();
  int pageCount = 0;
  int limitSize = 10;


  H00301PageViewModel(this.context){
    userToPlayBallList = new UserToPlayBallResWrapDto(DateTime.now(),[]);
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
    sorts.add(MultiSort("startTime",QueryOrders.DESC));
    MultiSorts wrapsorts = new MultiSorts(sorts) ;
    var userToPlayBallReqDto = UserToPlayBallReqDto(globalModel.fUserInfoDto.uid,pageCount,limitSize,wrapsorts.toQureyJson());
    if(pageCount == 0){
      this.userToPlayBallList = await _fBallPlayerRepository.getUserToPlayBallList(userToPlayBallReqDto);
    }else {
      var userToPlayBallResWrapDto = await _fBallPlayerRepository.getUserToPlayBallList(userToPlayBallReqDto);
      this.userToPlayBallList.contents.addAll(userToPlayBallResWrapDto.contents);
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
          userToPlayBallList.contents.length) {
        return;
      } else {
        ballListUp();
      }
    }
  }



}