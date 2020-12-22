import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/AppBis/FBall/Data/Repository/NoInterestBallRepositoryImpl.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/NoInterestBallRepository.dart';

void main() {
  NoInterestBallRepository noInterestBallRepository;

  setUp(() {
    noInterestBallRepository = NoInterestBallRepositoryImpl(
        sharedPreferencesAdapter: MemorySharePreferencesAdapterImpl());
  });



  test('관심 없는 볼 저장', () async {
    //given

    //when
    await noInterestBallRepository.save("TEST_ballUUid");
    //then
    expect(await noInterestBallRepository.existsByBallUuid("TEST_ballUUid"), true);
  });

  test('관심 모든 볼 얻어 오기 ', () async {
    //given
    await noInterestBallRepository.save("TEST_ballUUid1");
    await noInterestBallRepository.save("TEST_ballUUid2");
    await noInterestBallRepository.save("TEST_ballUUid3");
    await noInterestBallRepository.save("TEST_ballUUid4");
    //when
    var list = await noInterestBallRepository.findByAll();
    //then
    expect(list.length, 4);
  });

  test('관심 없는 볼 삭제 ', () async {
    //given
    await noInterestBallRepository.save("TEST_ballUUid1");
    await noInterestBallRepository.save("TEST_ballUUid2");
    await noInterestBallRepository.save("TEST_ballUUid3");
    await noInterestBallRepository.save("TEST_ballUUid4");
    //when
    await noInterestBallRepository.deleteByBallUuid("TEST_ballUUid3");
    //then
    var list = await noInterestBallRepository.findByAll();
    expect(list.length, 3);
    expect(await noInterestBallRepository.existsByBallUuid("TEST_ballUUid3"), false);

  });
}