import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBallPopup extends StatelessWidget {
  final Function(BuildContext context) onModify;

  final Function(BuildContext context) onDelete;

  const MyBallPopup({Key key, this.onModify, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyBallPopupViewModel(),
      child: Consumer<MyBallPopupViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: 221,
                height: 152,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              onModify(context);
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text("수정하기"),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                    Divider(
                      color: Color(0xffE4E7E8),
                      height: 1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              onDelete(context);
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text("삭제하기"),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                    Divider(
                      color: Color(0xffE4E7E8),
                      height: 1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text("닫기"),
                              ),
                            ),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyBallPopupViewModel extends ChangeNotifier {}
