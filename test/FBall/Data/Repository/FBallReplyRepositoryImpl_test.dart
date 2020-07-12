import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallReplyDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Data/Value/FBallReplyResWrap.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/Preference.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'file:///C:/workproject/FlutterPro/forutonafront/lib/FBall/Data/Repository/FBallReplyRepositoryImpl.dart';

class MockFireBaseAuthBaseAdapter extends Mock
    implements FireBaseAuthBaseAdapter {}

class MockFBallReplyDataSource extends Mock implements FBallReplyDataSource {}

void main() {
  FBallReplyRepository fBallReplyRepository;
  FireBaseAuthBaseAdapter mockFireBaseAuthBaseAdapter;
  MockFBallReplyDataSource mockFBallReplyDataSource;

  final sl = GetIt.instance;
  sl.registerSingleton<Preference>(Preference());

  setUp(() {
    mockFBallReplyDataSource = MockFBallReplyDataSource();
    mockFireBaseAuthBaseAdapter = MockFireBaseAuthBaseAdapter();
    fBallReplyRepository = FBallReplyRepositoryImpl(
        fireBaseAuthBaseAdapter: mockFireBaseAuthBaseAdapter,
        fBallReplyDataSource: mockFBallReplyDataSource);
    when(isGivenFireBaseTokenToDataSource(mockFireBaseAuthBaseAdapter))
        .thenAnswer((realInvocation) async => "token");
  });

  test('should deleteFBallReply DataSource Call', () async {
    //arrange
    String replyUuid = "replyUuid";
    //act
    await fBallReplyRepository.deleteFBallReply(replyUuid);
    //assert
    verify(mockFBallReplyDataSource.deleteFBallReply(replyUuid, any));
  });


  test('should getFBallReply DataSource Call', () async {
    //arrange
    FBallReplyReqDto reqDto = FBallReplyReqDto();
    reqDto.ballUuid = "testBallUuid";
    FBallReplyResWrap fBallReplyResWrap = FBallReplyResWrap();
    fBallReplyResWrap.count = 0;
    fBallReplyResWrap.contents = [];
    fBallReplyResWrap.replyTotalCount = 0;
    when(mockFBallReplyDataSource.getFBallReply(any,any)).thenAnswer((realInvocation)  async => fBallReplyResWrap);
    //act
    await fBallReplyRepository.getFBallReply(reqDto);
    //assert
    verify(mockFBallReplyDataSource.getFBallReply(reqDto, any));
  });

  test('should insertFBallReply DataSource Call', () async {
    //arrange
    FBallReplyInsertReqDto reqDto = FBallReplyInsertReqDto();
    reqDto.ballUuid = "testBallUuid";
    FBallReply fBallReply = FBallReply();
    fBallReply.ballUuid = "ballUUid";
    when(mockFBallReplyDataSource.insertFBallReply(any,any)).thenAnswer((realInvocation)  async => fBallReply);
    //act
    await fBallReplyRepository.insertFBallReply(reqDto);
    //assert
    verify(mockFBallReplyDataSource.insertFBallReply(reqDto, any));
  });

  test('should updateFBallReply DataSource Call', () async {
    //arrange
    FBallReplyInsertReqDto reqDto = FBallReplyInsertReqDto();
    reqDto.ballUuid = "testBallUuid";
    when(mockFBallReplyDataSource.updateFBallReply(any,any)).thenAnswer((realInvocation)  async => 1);
    //act
    await fBallReplyRepository.updateFBallReply(reqDto);
    //assert
    verify(mockFBallReplyDataSource.updateFBallReply(reqDto, any));
  });

}

Future<String> isGivenFireBaseTokenToDataSource(
        MockFireBaseAuthBaseAdapter mockFireBaseAdapter) =>
    mockFireBaseAdapter.getFireBaseIdToken();
