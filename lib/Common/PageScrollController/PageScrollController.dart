import 'package:flutter/cupertino.dart';

class PageScrollController {
  final ScrollController scrollController;
  Function? onNextPage;
  Function? onRefreshFirst;

  PageScrollController(
      {required this.scrollController, this.onNextPage, this.onRefreshFirst}) {
    this.scrollController.addListener(_onScrollerListener);
  }

  _onScrollerListener() {
    if (this.scrollController.offset >=
            this.scrollController.position.maxScrollExtent &&
        !this.scrollController.position.outOfRange) {
      onNextPage!();
    }

    if (this.scrollController.offset <=
            this.scrollController.position.minScrollExtent &&
        !this.scrollController.position.outOfRange) {
      onRefreshFirst!();
    }
  }
}
