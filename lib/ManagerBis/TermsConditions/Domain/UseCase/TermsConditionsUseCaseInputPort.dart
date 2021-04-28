import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ManagerBis/TermsConditions/Domain/Repository/TermsConditionsRepository.dart';
import 'package:forutonafront/ManagerBis/TermsConditions/Dto/TermsConditionsResDto.dart';
import 'package:injectable/injectable.dart';

abstract class TermsConditionsUseCaseInputPort {
  Future<TermsConditionsResDto> getTermsConditions(int idx);
}
@Injectable(as: TermsConditionsUseCaseInputPort)
class TermsConditionsUseCase implements TermsConditionsUseCaseInputPort {

  final TermsConditionsRepository termsConditionsRepository;

  TermsConditionsUseCase(
      {required this.termsConditionsRepository});

  @override
  Future<TermsConditionsResDto> getTermsConditions(int idx) async{
    return await this.termsConditionsRepository.findById(idx);
  }

}