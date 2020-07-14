import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallReplyDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Data/Value/FBallReplyResWrap.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyUpdateReqDto.dart';
import 'package:mockito/mockito.dart';

class MockFDio extends Mock implements FDio {}

void main() {
  MockFDio mockFDio;

  FBallReplyDataSource fBallReplyDataSource;
  setUp(() {
    mockFDio = MockFDio();
    fBallReplyDataSource = FBallReplyDataSourceImpl();
  });
  test('should deleteFBallReply ', () async {
    String replyUuid = "replyUuid";
    //arrange
    when(mockFDio.delete("/v1/FBallReply/" + replyUuid))
        .thenAnswer((_) async => Response<dynamic>(
            statusCode: 200,
            data: 1,
            headers: Headers.fromMap({
              "Content-Type": ['application/json', 'charset=utf-8']
            })));
    //act
    var result = await fBallReplyDataSource.deleteFBallReply(
         replyUuid,  mockFDio);
    //assert
    expect(result, 1);
  });

  test('should getFBallReply', () async {
    //arrange
    FBallReplyReqDto reqDto = FBallReplyReqDto();
    reqDto.ballUuid = "testBallUuid";
    reqDto.size = 3;
    reqDto.page = 0;
    reqDto.reqOnlySubReply = false;
    FBallReplyResWrap replyResWrap = FBallReplyResWrap();
    replyResWrap.contents= [] ;
    replyResWrap.replyTotalCount = 0;
    replyResWrap.count = 0;
    when(mockFDio.get("/v1/FBallReply",
            queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => Response<dynamic>(
            statusCode: 200,
            data: replyResWrap.toJson(),
            headers: Headers.fromMap({
              "Content-Type": ['application/json', 'charset=utf-8']
            })));
    //act
    await fBallReplyDataSource.getFBallReply(reqDto,mockFDio);
    //assert
    verify(mockFDio.get("/v1/FBallReply", queryParameters: anyNamed('queryParameters')));
  });



  test('should insertFBallReply', () async {
    //arrange
    FBallReplyInsertReqDto reqDto = FBallReplyInsertReqDto();
    reqDto.ballUuid = "testBallUuid";
    FBallReply fBallReplyRes = FBallReply();
    fBallReplyRes.uid = "testUid";
    fBallReplyRes.userNickName = "testNickName";
    fBallReplyRes.replyText = "testReply";

    when(mockFDio.post("/v1/FBallReply",data: anyNamed('data')))
        .thenAnswer((_) async => Response<dynamic>(
        statusCode: 200,
        data: fBallReplyRes.toJson(),
        headers: Headers.fromMap({
          "Content-Type": ['application/json', 'charset=utf-8']
        })));
    //act
    await fBallReplyDataSource.insertFBallReply(reqDto,mockFDio);
    //assert
    verify(mockFDio.post("/v1/FBallReply", data: anyNamed('data')));
  });

  test('should updateFaBallReply', () async {
    //arrange
    FBallReplyUpdateReqDto reqDto = FBallReplyUpdateReqDto();
    reqDto.replyUuid = "testBallUuid";

    when(mockFDio.put("/v1/FBallReply",data: anyNamed('data')))
        .thenAnswer((_) async => Response<dynamic>(
        statusCode: 200,
        data: 1,
        headers: Headers.fromMap({
          "Content-Type": ['application/json', 'charset=utf-8']
        })));
    //act
    await fBallReplyDataSource.updateFBallReply(reqDto,mockFDio);
    //assert
    verify(mockFDio.put("/v1/FBallReply", data: anyNamed('data')));
  });
}
