import 'package:forutonafront/ManagerBis/TermsConditions/Dto/TermsConditionsResDto.dart';

abstract class  TermsConditionsRepository {
  Future<TermsConditionsResDto> findById(int idx);
}