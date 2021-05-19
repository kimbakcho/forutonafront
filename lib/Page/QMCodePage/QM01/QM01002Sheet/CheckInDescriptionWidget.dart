import 'package:flutter/material.dart';
import 'package:forutonafront/Common/ModifiedLengthLimitingTextInputFormatter/ModifiedLengthLimitingTextInputFormatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class CheckInDescriptionWidget extends StatelessWidget {

  final CheckInDescriptionWidgetController? controller;

  final String? preSetText;

  CheckInDescriptionWidget({this.controller,this.preSetText});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckInDescriptionWidgetViewModel(
        controller: controller,
        preSetText: preSetText
      ),
      child: Consumer<CheckInDescriptionWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "체크인 위치 힌트",
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: const Color(0xff000000),
                      letterSpacing: -0.28,
                      fontWeight: FontWeight.w700,
                      height: 1.2142857142857142,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: model.textController,
                  maxLength: 50,
                  inputFormatters: [
                    ModifiedLengthLimitingTextInputFormatter(50)
                  ],
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(
                      hintText: "체크인 위치 힌트를 설명해 주세요.",
                      hintStyle: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xffb1b1b1),
                        letterSpacing: -0.28,
                        fontWeight: FontWeight.w500,
                        height: 1.2142857142857142,
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CheckInDescriptionWidgetViewModel extends ChangeNotifier {
  CheckInDescriptionWidgetController? controller;

  TextEditingController textController = TextEditingController();

  String? preSetText;

  CheckInDescriptionWidgetViewModel({this.controller, this.preSetText}){
    if(this.controller!=null){
      this.controller!._viewModel = this;
    }
    if(preSetText != null){
      textController.text = preSetText!;
    }

  }
}

class CheckInDescriptionWidgetController {
  CheckInDescriptionWidgetViewModel? _viewModel;

  String getText(){
    if(_viewModel!=null){
      return _viewModel!.textController.text;
    }else {
      return "";
    }
  }

}
