
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingReqDto.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingWrapDto.dart';

class TagRankingRepository {
  Future<TagRankingWrapDto> getTagRanking(TagRankingReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
      var response = await dio.get("/v1/FTag/Ranking",
      queryParameters: reqDto.toJson()
    );
    return TagRankingWrapDto.fromJson(response.data);
  }
}
