import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class AddressInputSearchBar extends StatelessWidget {
  final AddressInputSearchBarListener listener;
  final bool autoFocusFlag;
  final String initText;
  final bool readOnly;

  const AddressInputSearchBar(
      {Key key, this.listener, this.autoFocusFlag, this.initText, this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            AddressInputSearchBarViewModel(
                initText: initText,
                listener: listener,
                fluttertoastAdapter: sl()),
        child:
        Consumer<AddressInputSearchBarViewModel>(builder: (_, model, __) {
          return Stack(children: [
            Container(
              height: 36,
              child: TextField(
                maxLines: 1,
                readOnly: readOnly,
                onChanged: model.onChangeText,
                autofocus: autoFocusFlag,
                controller: model.textEditingController,
                keyboardType: TextInputType.streetAddress,
                enableSuggestions: false,
                onSubmitted: (String search) {
                  model.addressSearch(search);
                },
                autocorrect: false,
                cursorColor: Color(0xff707070),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF6F6F6),
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 44, 0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffF6F6F6)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff3497FD)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: readOnly ? Color(0xffF6F6F6): Color(0xff3497FD)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)))),
              ),
            ),
            Positioned(
              right: 16,
              top: 11,
              child: model.showClearButton ? Container(
                  width: 14,
                  height: 14,
                  child: Material(
                      shape: CircleBorder(
                          side: BorderSide(color: Color(0xff454F63))),
                      child: InkWell(
                          onTap: () {
                            model.clearText();
                          },
                          child: Icon(
                            Icons.clear,
                            color: Color(0xff454F63),
                            size: 10,
                          )))) : Container(),
            )
          ]);
        }));
  }
}

class AddressInputSearchBarViewModel extends ChangeNotifier {
  final AddressInputSearchBarListener listener;
  final TextEditingController textEditingController;
  final FluttertoastAdapter fluttertoastAdapter;
  final String initText;


  AddressInputSearchBarViewModel(
      {this.fluttertoastAdapter, this.listener, this.initText})
      : textEditingController = TextEditingController() {
    textEditingController.text = initText;
    onChangeText(textEditingController.text);
  }

  bool showClearButton = false;

  onChangeText(String searchValue) {
    if (searchValue.length > 0) {
      showClearButton = true;
    } else {
      showClearButton = false;
    }
    notifyListeners();
  }

  void addressSearch(String searchText) {
    if(listener == null){
      return ;
    }
    if (searchText.length >= 2) {
      listener.onAddressSearch(searchText);
    } else {
      fluttertoastAdapter.showToast(msg: '2글자 이상 입력하세요.');
    }
  }

  void clearText() {
    textEditingController.clear();
  }
}

abstract class AddressInputSearchBarListener {
  Future<void> onAddressSearch(String search);
}
