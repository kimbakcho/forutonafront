import 'package:flutter/cupertino.dart';


class PageScrollController extends ScrollController {
  Function onNextPage;
  Function onRefreshFirst;

  PageScrollController({this.onNextPage,this.onRefreshFirst}) {
    this.addListener(_onScrollerListener);
  }

  _onScrollerListener() {
    if (this.offset >= this.position.maxScrollExtent &&
        !this.position.outOfRange) {
      onNextPage();
    }

    if (this.offset <= this.position.minScrollExtent &&
        !this.position.outOfRange) {
      onRefreshFirst();
    }
  }
}
