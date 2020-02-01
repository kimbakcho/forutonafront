import 'package:flutter/material.dart';

class A003ServiceUserAgreements extends StatefulWidget {
  A003ServiceUserAgreements({Key key}) : super(key: key);

  @override
  _A003ServiceUserAgreementsState createState() =>
      _A003ServiceUserAgreementsState();
}

class _A003ServiceUserAgreementsState extends State<A003ServiceUserAgreements> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF606060), Color(0xFF0E1014)]),
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: AssetImage("assets/MainImage/map-846083_1920.png"))),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            title: Text("서비스 이용 약관",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Container(
              child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFE4E7E8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.00),
                            topRight: Radius.circular(16.00))),
                    child: Container(
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.00, 4.00),
                            color: Color(0xff455b63).withOpacity(0.08),
                            blurRadius: 16,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12.00),
                      ),
                      child: RichText(
                        text: TextSpan(
                            text: "텍스트 추후 웹페이지 링크",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Noto Sans CJK KR',
                                fontWeight: FontWeight.w700,
                                fontSize: 24)),
                      ),
                    )),
              )
            ],
          )),
        ));
  }
}
