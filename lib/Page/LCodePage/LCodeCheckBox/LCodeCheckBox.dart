import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LCodeCheckBox extends StatelessWidget {
  final LCodeCheckBoxController? controller;

  final double size;

  const LCodeCheckBox({Key? key, this.controller, this.size = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LCodeCheckBoxViewModel(controller: controller!),
      child: Consumer<LCodeCheckBoxViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Material(
              color: Colors.transparent,
              // color: model._checkValue ? Color(0xff3497FD) : Color(0xffD4D4D4),
              child: InkWell(
                onTap: (){
                  model.toggleValue();
                },
                customBorder: CircleBorder(),
                child: Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      size: size,
                      color: model._checkValue
                          ? Color(0xff3497FD)
                          : Color(0xffD4D4D4),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LCodeCheckBoxViewModel extends ChangeNotifier {
  final LCodeCheckBoxController? controller;

  bool _checkValue = false;

  LCodeCheckBoxViewModel({this.controller}) {
    if(this.controller != null){
      controller!._lCodeCheckBoxViewModel = this;
    }
  }
  toggleValue(){
    _checkValue = !_checkValue;
    if(this.controller != null){
      if(this.controller!.onChangeValue != null){
        this.controller!.onChangeValue!(_checkValue);
      }
    }
    notifyListeners();
  }
}

class LCodeCheckBoxController {
  LCodeCheckBoxViewModel? _lCodeCheckBoxViewModel;

  Function(bool value)? onChangeValue;

  LCodeCheckBoxController({this.onChangeValue});

  bool getValue() {
    if(_lCodeCheckBoxViewModel == null){
      return false;
    }
    return _lCodeCheckBoxViewModel!._checkValue;
  }
  setValue(bool value ){
    this._lCodeCheckBoxViewModel!._checkValue = value;
    _lCodeCheckBoxViewModel!.notifyListeners();
  }
}
