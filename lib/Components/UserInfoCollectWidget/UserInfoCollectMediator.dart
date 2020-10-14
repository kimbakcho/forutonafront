import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoListUpUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';

abstract class UserInfoCollectComponent {
  void onUserInfoListUp();
  void onUserInfoEmpty();
}

abstract class UserInfoCollectMediator {

  UserInfoListUpUseCaseInputPort userInfoListUpUseCaseInputPort;

  void registerComponent(UserInfoCollectComponent component);

  void unregisterComponent(UserInfoCollectComponent component);

  searchNext();

  searchFirst();

  int componentSize();

  bool get isLastPage;

  bool isLoading;

  UserInfoCollectMediatorState currentState;

  List<FUserInfoSimpleResDto> fUserInfoSimpleResDtoList;
}

enum UserInfoCollectMediatorState {
  Empty,HasUserInfo,Error
}
// TODO SearchCollectMediator 으로  상속 하여 중복 제거 및 테스트 생성
class UserInfoCollectMediatorImpl implements UserInfoCollectMediator{

  final pageLimit;

  int _pageCount = 0;

  List<UserInfoCollectComponent> ballListMediatorComponentList = [];

  PageWrap<FUserInfoSimpleResDto> _wrapFUserInfoSimpleResDto;

  List<FUserInfoSimpleResDto> fUserInfoSimpleResDtoList = [];

  @override
  UserInfoListUpUseCaseInputPort userInfoListUpUseCaseInputPort;

  UserInfoCollectMediatorImpl({this.pageLimit = 3}){
    _wrapFUserInfoSimpleResDto = PageWrap<FUserInfoSimpleResDto>();
  }

  _search(Pageable pageable) async {
    isLoading = true;
    onPageListUpdate();
    if(userInfoListUpUseCaseInputPort == null){
      isLoading = false;
      onPageListUpdate();
      throw Exception("don't have searchCaseInputPort for need set FBallListUpUseCaseInputPort");
    }
    if(isLastPage){
      if(_pageCount == 0 && fUserInfoSimpleResDtoList.length == 0){
        currentState = UserInfoCollectMediatorState.Empty;
      }
      isLoading = false;
      onPageListUpdate();
      return ;
    }
    this._wrapFUserInfoSimpleResDto = await this
        .userInfoListUpUseCaseInputPort
        .search(pageable);
    if (_wrapFUserInfoSimpleResDto.first) {
      fUserInfoSimpleResDtoList.clear();
    }
    fUserInfoSimpleResDtoList.addAll(_wrapFUserInfoSimpleResDto.content);
    _pageCount = pageable.page;

    if(_pageCount == 0 && fUserInfoSimpleResDtoList.length == 0){
      currentState = UserInfoCollectMediatorState.Empty;
      onUserInfoListEmpty();
    }else {
      currentState = UserInfoCollectMediatorState.HasUserInfo;
    }
    isLoading = false;
    onPageListUpdate();
  }

  @override
  void registerComponent(UserInfoCollectComponent component) {
    ballListMediatorComponentList.add(component);
  }

  @override
  void unregisterComponent(UserInfoCollectComponent component) {
    ballListMediatorComponentList.remove(component);
  }

  @override
  searchFirst() async{
    _pageCount = 0;
    _wrapFUserInfoSimpleResDto = PageWrap<FUserInfoSimpleResDto>();
    await _search(Pageable(page:_pageCount,size: pageLimit));
  }

  @override
  searchNext() async{
    _pageCount++;
    await _search(Pageable(page:_pageCount,size:pageLimit));
  }

  @override
  bool get isLastPage {
    return _wrapFUserInfoSimpleResDto.last;
  }

  onPageListUpdate() {
    ballListMediatorComponentList.forEach((element) {
      element.onUserInfoListUp();
    });
  }

  onUserInfoListEmpty(){
    ballListMediatorComponentList.forEach((element) {
      element.onUserInfoEmpty();
    });
  }

  @override
  bool isLoading = false;

  @override
  UserInfoCollectMediatorState currentState = UserInfoCollectMediatorState.HasUserInfo;

  @override
  int componentSize() {
    return ballListMediatorComponentList.length;
  }

}