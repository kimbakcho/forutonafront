import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IM001BottomSheetBody extends StatelessWidget {

  final Function(String) onChangeAddress;

  final String initAddress;

  const IM001BottomSheetBody({Key key, this.initAddress,this.onChangeAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IM001BottomSheetBodyViewModel(onChangeAddress,initAddress),
      child: Consumer<IM001BottomSheetBodyViewModel>(
        builder: (_, model, child) {
          return Column(
            children: [
              TextField(),
              SizedBox(height: 400,),
              TextField(),
              SizedBox(height: 70,),
            ],
          );
        },
      ),
    );
  }
}

class IM001BottomSheetBodyViewModel extends ChangeNotifier {
  String _currentAddress;

  final String initAddress;

  TextEditingController _addressTextController;

  final Function(String) onChangeAddress;

  IM001BottomSheetBodyViewModel(this.onChangeAddress,this.initAddress){
    _currentAddress = initAddress;
    _addressTextController = TextEditingController();
    _addressTextController.text = _currentAddress;
    _addressTextController.addListener(() {
      _currentAddress = _addressTextController.text;
      if(onChangeAddress != null){
        onChangeAddress(_addressTextController.text);
      }
    });
  }


}
