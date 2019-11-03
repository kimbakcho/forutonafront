import 'package:flutter/material.dart';

class PassWordFindView extends StatefulWidget {
  PassWordFindView({Key key}) : super(key: key);

  @override
  _PassWordFindViewState createState() => _PassWordFindViewState();
}

class _PassWordFindViewState extends State<PassWordFindView> {
  TextEditingController _emailtextcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("전화번호 인증"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailtextcontroller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'ID(Email)',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
          ],
        ),
      ),
    );
  }
}
