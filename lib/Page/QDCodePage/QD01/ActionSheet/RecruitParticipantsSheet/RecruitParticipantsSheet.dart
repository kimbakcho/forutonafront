import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'QualifyingForQuestTextWidget.dart';
import 'RecruitParticipantsAppBar.dart';

class RecruitParticipantsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecruitParticipantsSheetViewModel(),
      child: Consumer<RecruitParticipantsSheetViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(width: 1, color: Color(0xffE4E7E8)))),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Icon(Icons.tab_rounded),
                  )
                ],
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).padding.right,
                  MediaQuery.of(context).padding.top + 10,
                  MediaQuery.of(context).padding.right,
                  MediaQuery.of(context).padding.bottom),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.white),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        RecruitParticipantsAppBar(
                          controller: model._recruitParticipantsAppBarController,
                          onComplete: (){
                          }
                        ),

                        Container(
                          padding: EdgeInsets.all(16),
                          child: QualifyingForQuestTextWidget(),
                        )


                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecruitParticipantsSheetViewModel extends ChangeNotifier {
  RecruitParticipantsAppBarController _recruitParticipantsAppBarController = RecruitParticipantsAppBarController();

}
