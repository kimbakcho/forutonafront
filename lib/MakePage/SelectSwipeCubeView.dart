import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/MakePage/Component/CustomSwipePagenation.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/GoogleMapsMakeView.dart';
import 'package:forutonafront/globals.dart';
import 'package:uuid/uuid.dart';

class SelectSwipeCubeView extends StatefulWidget {
  SelectSwipeCubeView({Key key}) : super(key: key);

  @override
  _SelectSwipeCubeStateView createState() => _SelectSwipeCubeStateView();
}

class _SelectSwipeCubeStateView extends State<SelectSwipeCubeView> {
  SwiperController _controller;
  List<FcubeTypeObj> cubeLists;
  Uuid uuid = Uuid();
  int currentindex = 0;
  @override
  void initState() {
    super.initState();
    _controller = new SwiperController();
    cubeLists = new List<FcubeTypeObj>();
    cubeLists.add(FcubeTypeObj(
        name: "퀘스트큐브",
        type: FcubeType.questCube,
        description: "장황한 설명",
        picture: "assets/MarkesImages/QuestCube.png"));
    cubeLists.add(FcubeTypeObj(
        name: "메세지 큐브",
        type: FcubeType.messageCube,
        description: "장황한 설명",
        picture: "assets/MarkesImages/MessageCube.png"));
    cubeLists.add(FcubeTypeObj(
        name: "메세지 큐브2",
        type: FcubeType.messageCube,
        description: "장황한 설명",
        picture: "assets/MarkesImages/MessageCube.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Swiper(
                itemCount: cubeLists.length,
                controller: _controller,
                onIndexChanged: (index) {
                  currentindex = index;
                },
                pagination: new CustomSwipePagenation(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(50),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 30,
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(cubeLists[index].picture),
                          ),
                        ),
                        Container(
                          child: Text(cubeLists[index].name),
                        ),
                        Container(
                          height: 20,
                        ),
                        Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Text(cubeLists[index].description),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: RaisedButton(
                child: Text("MAKE"),
                onPressed: () async {
                  Fcube cube = new Fcube(
                      cubedispalyname: cubeLists[this.currentindex].name,
                      cubetype: cubeLists[this.currentindex].type,
                      cubeuuid: uuid.v4(),
                      uid: GolobalStateContainer.of(context)
                          .state
                          .userInfoMain
                          .uid,
                      cubeimage: cubeLists[this.currentindex].picture);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return GoogleMapsMakeView(
                      selectFcube: cube,
                    );
                  }));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
