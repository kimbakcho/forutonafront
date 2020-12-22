import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Page/HCodePage/H010/SearchHistoryView.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';



class InputSearchBar extends StatelessWidget {
  final InputSearchBarListener inputSearchBarListener;
  final bool autoFocusFlag;
  final String initText;
  final bool readOnly;
  final SearchHistoryViewController searchHistoryViewController;

  const InputSearchBar(
      {Key key, this.inputSearchBarListener, this.autoFocusFlag, this.initText, this.readOnly, this.searchHistoryViewController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            InputSearchBarViewModel(
                initText: initText,
                context: context,
                inputSearchBarListener: inputSearchBarListener,
                searchHistoryViewController: searchHistoryViewController,
                fluttertoastAdapter: sl()),
        child:
        Consumer<InputSearchBarViewModel>(builder: (_, model, __) {
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
                  model.onSearch(search);
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
                        borderSide: BorderSide(color: readOnly ? Color(
                            0xffF6F6F6) : Color(0xff3497FD)),
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

class InputSearchBarViewModel extends ChangeNotifier {
  final InputSearchBarListener inputSearchBarListener;
  final TextEditingController textEditingController;
  final FluttertoastAdapter fluttertoastAdapter;
  final String initText;
  final SearchHistoryViewController searchHistoryViewController;
  final BuildContext context;


  InputSearchBarViewModel(
      {this.fluttertoastAdapter, this.inputSearchBarListener, this.context, this.initText, this.searchHistoryViewController})
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

  void onSearch(String searchText) {
    if (inputSearchBarListener == null) {
      return;
    }
    if (searchText.length >= 2) {
      if (searchHistoryViewController != null) {
        searchHistoryViewController.addHistory(searchText);
      }
      if (inputSearchBarListener != null) {
        inputSearchBarListener.onSearch(searchText, context:context);
      }
    } else {
      fluttertoastAdapter.showToast(msg: '2글자 이상 입력하세요.');
    }
  }

  void clearText() {
    textEditingController.clear();
  }
}

abstract class InputSearchBarListener {
  Future<void> onSearch(String search, {BuildContext context});
}
