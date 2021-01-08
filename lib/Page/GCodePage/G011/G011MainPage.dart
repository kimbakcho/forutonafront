import 'package:flutter/material.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/Page/GCodePage/Component/GCodeLineButtonComponent.dart';
import 'package:forutonafront/Page/GCodePage/G012/G012MainPage.dart';

import 'package:provider/provider.dart';

class G011MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G011MainPageViewModel(),
        child: Consumer<G011MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              padding: MediaQuery.of(context).padding,
              child: Column(
                children: [
                  CodeAppBar(title: "설정", visibleTailButton: false,progressValue: 0),
                  GCodeLineButtonComponent(
                    icon: Icon(Icons.vpn_key),
                    text: "패스워드 재설정",
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return G012MainPage();
                      }));

                    },
                  )
                ],
              ),
            ),
          );
        }));
  }
}

class G011MainPageViewModel extends ChangeNotifier {}
