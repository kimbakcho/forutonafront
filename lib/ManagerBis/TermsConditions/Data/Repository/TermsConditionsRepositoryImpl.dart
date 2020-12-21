import 'package:forutonafront/Common/MDio.dart';
import 'package:forutonafront/ManagerBis/TermsConditions/Domain/Repository/TermsConditionsRepository.dart';
import 'package:forutonafront/ManagerBis/TermsConditions/Dto/TermsConditionsResDto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:TermsConditionsRepository)
class TermsConditionsRepositoryImpl implements TermsConditionsRepository {
  @override
  Future<TermsConditionsResDto> findById(int idx) async {
    MDio mDio = MDio();
    var response = await mDio.get("/termsConditions",queryParameters: {
      "idx": idx
    });
    return  TermsConditionsResDto.fromJson(response.data);
  }

}