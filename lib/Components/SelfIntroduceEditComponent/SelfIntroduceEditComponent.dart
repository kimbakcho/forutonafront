import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelfIntroduceEditComponent extends StatelessWidget {
  final SelfIntroduceEditController selfIntroduceEditController;
  final String initSelfIntroduce;
  const SelfIntroduceEditComponent({Key key, this.selfIntroduceEditController,this.initSelfIntroduce})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SelfIntroduceEditComponentViewModel(selfIntroduceEditController: selfIntroduceEditController,initSelfIntroduce: initSelfIntroduce),
        child: Consumer<SelfIntroduceEditComponentViewModel>(
            builder: (_, model, child) {
          return Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  '자기소개',
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff000000),
                    letterSpacing: -0.28,
                    fontWeight: FontWeight.w700,
                    height: 1.2142857142857142,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "자기소개를 입력해주세요",
                      hintStyle: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xffb1b1b1),
                        letterSpacing: -0.28,
                        fontWeight: FontWeight.w300,
                        height: 1.2142857142857142,
                      )),
                  controller: model._selfIntroduceEditController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 100,
                )
              ]));
        }));
  }
}

class SelfIntroduceEditComponentViewModel extends ChangeNotifier {
  final SelfIntroduceEditController selfIntroduceEditController;

  String initSelfIntroduce;

  TextEditingController _selfIntroduceEditController;

  SelfIntroduceEditComponentViewModel({this.selfIntroduceEditController,this.initSelfIntroduce}) {
    _selfIntroduceEditController = TextEditingController();
    if (this.selfIntroduceEditController != null) {
      selfIntroduceEditController._selfIntroduceEditComponentViewModel = this;
    }
    if (this.selfIntroduceEditController != null &&
        selfIntroduceEditController.onChangesSelfIntroduceText != null) {
      _selfIntroduceEditController.addListener(() {
        selfIntroduceEditController
            .onChangesSelfIntroduceText(_selfIntroduceEditController.text);
      });
    }
    if(initSelfIntroduce != null){
      _selfIntroduceEditController.text =initSelfIntroduce;
    }
  }
}

class SelfIntroduceEditController {
  SelfIntroduceEditComponentViewModel _selfIntroduceEditComponentViewModel;

  final Function(String) onChangesSelfIntroduceText;

  SelfIntroduceEditController({this.onChangesSelfIntroduceText});

  get selfIntroduceText {
    return _selfIntroduceEditComponentViewModel
        ._selfIntroduceEditController.text;
  }

}
