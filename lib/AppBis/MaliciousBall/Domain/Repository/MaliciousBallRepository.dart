import 'package:forutonafront/AppBis/MaliciousBall/Dto/MaliciousBallReqDto.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Dto/MaliciousBallResDto.dart';

abstract class MaliciousBallRepository {
  Future<MaliciousBallResDto>  save(MaliciousBallReqDto reqDto);
}