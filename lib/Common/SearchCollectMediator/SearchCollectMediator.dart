import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';

abstract class SearchCollectMediatorComponent {

  void onItemListUpUpdate();

  void onItemListEmpty();
}

enum SearchCollectMediatorState {
  Empty,HasItem,Error
}

abstract class SearchCollectMediator<T> {

  int _pageCount = 0;

  int pageLimit = 40;

  PageWrap<T>? wrapItemList;

  List<T> itemList = List.empty(growable: true);

  String? sort;

  SearchCollectMediator(){
    wrapItemList = PageWrap<T>();
  }

  List<SearchCollectMediatorComponent> mediatorComponentList = [];

  void registerComponent(SearchCollectMediatorComponent component){
    mediatorComponentList.add(component);
  }

  void unregisterComponent(SearchCollectMediatorComponent component){
    mediatorComponentList.remove(component);
  }

  int componentSize(){
    return mediatorComponentList.length;
  }

  searchFirst() async {
    _pageCount = 0;
    wrapItemList = PageWrap<T>();
    await _search(Pageable(page:_pageCount,size:pageLimit,sort: sort!));
  }

  searchNext() async{
    _pageCount++;
    await _search(Pageable(page:_pageCount,size:pageLimit,sort: sort!));
  }


  Future<void> _search(Pageable pageable) async{
    isLoading = true;

    onPageListUpdate();
    if(isNullSearchUseCase()){
      currentState = SearchCollectMediatorState.Error;
      isLoading = false;
      onPageListUpdate();
      throw Exception("don't have searchCaseInputPort for need set ListUpUseCaseInputPort");
    }
    if(isLastPage!){
      if(_pageCount == 0 && itemList!.length == 0){
        currentState = SearchCollectMediatorState.Empty;
      }
      isLoading = false;
      onPageListUpdate();
      return ;
    }
    wrapItemList = await searchUseCase(pageable);
    if (wrapItemList!.first!) {
      itemList!.clear();
    }
    if(wrapItemList!.content != null){
      itemList!.addAll(wrapItemList!.content!);
    }

    _pageCount = pageable.page!;

    if(_pageCount == 0 && itemList!.length == 0){
      currentState = SearchCollectMediatorState.Empty;
      onBallListEmpty();
    }else {
      currentState = SearchCollectMediatorState.HasItem;
    }
    isLoading = false;
    onPageListUpdate();
  }

  bool isNullSearchUseCase();

  Future<PageWrap<T>> searchUseCase(Pageable pageable);

  bool? get isLastPage {
    return wrapItemList!.last;
  }

  SearchCollectMediatorState currentState = SearchCollectMediatorState.HasItem;

  bool isLoading = false;

  onPageListUpdate() {
    mediatorComponentList.forEach((element) {
      element.onItemListUpUpdate();
    });
  }

  onBallListEmpty(){
    mediatorComponentList.forEach((element) {
      element.onItemListEmpty();
    });
  }

}