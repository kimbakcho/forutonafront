import 'package:forutonafront/Common/TagRanking/TagRankingDto.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingReqDto.dart';

class TagRankingRepository {
  getTagRanking(TagRankingReqDto reqDto){
    List<TagRankingDto> lists = new List();
    lists.add(new TagRankingDto(1,"TEST1",22000));
    lists.add(new TagRankingDto(2,"TEST2",22000));
    lists.add(new TagRankingDto(3,"TEST3",22000));
    lists.add(new TagRankingDto(4,"TEST4",22000));
    lists.add(new TagRankingDto(5,"TEST5",22000));
    lists.add(new TagRankingDto(6,"TEST6",22000));
    lists.add(new TagRankingDto(7,"TEST7",22000));
    lists.add(new TagRankingDto(8,"TEST8",22000));
    lists.add(new TagRankingDto(9,"TEST9",22000));
    lists.add(new TagRankingDto(10,"TEST10",22000));
    return lists;
  }
}
