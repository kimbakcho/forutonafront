import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Dto/TagRankingResDto.dart';
import 'package:injectable/injectable.dart';

abstract class RankingTagListMediatorComponent {
  onTagListUpdate();
}

abstract class RankingTagListMediator {
  void registerComponent(RankingTagListMediatorComponent component);

  void unregisterComponent(RankingTagListMediatorComponent component);

  int componentSize();

  search(Position searchPosition);

  TagRankingUseCaseInputPort tagRankingUseCaseInputPort;

  List<TagRankingResDto> tagRankingResDtos;

  onTagListUpdate();
}
// TODO SearchCollectMediator 으로  상속 하여 중복 제거 및 테스트 생성
@Injectable(as: RankingTagListMediator)
class RankingTagListMediatorImpl
    implements RankingTagListMediator {

  List<RankingTagListMediatorComponent> _rankingTagListComponentList = [];

  List<TagRankingResDto> tagRankingResDtos = [];

  Position currentSearchPosition;

  TagRankingUseCaseInputPort tagRankingUseCaseInputPort;

  RankingTagListMediatorImpl();

  void registerComponent(RankingTagListMediatorComponent listener) {
    this._rankingTagListComponentList.add(listener);
  }

  void unregisterComponent(RankingTagListMediatorComponent listener) {
    this._rankingTagListComponentList.remove(listener);
  }

  int componentSize() {
    return this._rankingTagListComponentList.length;
  }

  search(Position searchPosition) async {
    currentSearchPosition = searchPosition;
    this.tagRankingResDtos = await tagRankingUseCaseInputPort.search();
    onTagListUpdate();
  }

  @override
  onTagListUpdate() {
    _rankingTagListComponentList.forEach((element) {
      element.onTagListUpdate();
    });
  }

}
