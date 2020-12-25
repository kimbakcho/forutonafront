import 'package:flutter/material.dart';
import 'package:forutonafront/Page/LCodePage/LCodeAppBar/LCodeAppBar.dart';
import 'package:provider/provider.dart';

class L008MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => L008MainPageViewModel(),
      child: Consumer<L008MainPageViewModel>(
        builder: (_, model, child) {
          return Material(
            child: Container(
              padding: MediaQuery.of(context).padding,
              child: Column(
                children: [
                  LCodeAppBar(
                    enableTailButton: false,
                    progressValue: 0.9,
                    visibleTailButton: true,
                    title: "프로필 입력",
                    tailButtonLabel: "완료",
                  ),
                  Container(child: Text("123"))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class L008MainPageViewModel extends ChangeNotifier {}
