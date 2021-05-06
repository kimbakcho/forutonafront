import 'package:flutter/material.dart';
import 'package:forutonafront/Common/ModifiedLengthLimitingTextInputFormatter/ModifiedLengthLimitingTextInputFormatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:provider/provider.dart';

class PhotoCertificationDescription extends StatelessWidget {

  final PhotoCertificationDescriptionController? controller;

  PhotoCertificationDescription({this.controller});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhotoCertificationDescriptionViewModel(
        controller: controller
      ),
      child: Consumer<PhotoCertificationDescriptionViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "인증샷 설명",
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
                      hintText: "퀘스트 완료 인증을 위한 사진을 설명해 주세요.",
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

class PhotoCertificationDescriptionViewModel extends ChangeNotifier {

  TextEditingController textController = TextEditingController();

  PhotoCertificationDescriptionController? controller;

  PhotoCertificationDescriptionViewModel({this.controller}){
    if(controller != null){
      controller!._viewModel = this;
    }
  }

  String getText() {
    return textController.text;
  }

}

class PhotoCertificationDescriptionController {

  PhotoCertificationDescriptionViewModel? _viewModel;

  String getText(){
    if(_viewModel!=null){
      return _viewModel!.textController.text;
    }else {
      return "";
    }
  }

  setText(String str){
    if(_viewModel!=null){
      _viewModel!.textController.text = str;
    }

  }


}