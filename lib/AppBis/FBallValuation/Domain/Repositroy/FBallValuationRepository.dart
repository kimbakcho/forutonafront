

import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteReqDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteResDto.dart';

abstract class FBallValuationRepository {
    Future<FBallVoteResDto> ballVote(FBallVoteReqDto reqDto);
    Future<FBallVoteResDto> findByBallVoteState(String ballUuid);
}