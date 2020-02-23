import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/FcubeDescription.dart';

class ID001CubeImageViwer extends StatefulWidget {
  ID001CubeImageViwer({this.description, this.initindex, Key key})
      : super(key: key);
  final FcubeDescription description;
  final int initindex;

  @override
  _ID001CubeImageViwerState createState() {
    return _ID001CubeImageViwerState(
        description: this.description, currentindex: initindex);
  }
}

class _ID001CubeImageViwerState extends State<ID001CubeImageViwer> {
  _ID001CubeImageViwerState({this.description, this.currentindex});
  FcubeDescription description;
  int currentindex;
  SwiperController controller = SwiperController();
  Swiper mainswiper;
  @override
  void initState() {
    super.initState();
    mainswiper = Swiper(
      onIndexChanged: (index) {
        currentindex = index;
        setState(() {});
      },
      controller: controller,
      itemCount: description.desimages.length,
      index: currentindex,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(description.desimages[index].src),
                  fit: BoxFit.fitWidth)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: Container(
            alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width,
            child: Text("${currentindex + 1}/${description.desimages.length}",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Color(0xffffffff),
                ))),
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: mainswiper,
      ),
    );
  }
}
