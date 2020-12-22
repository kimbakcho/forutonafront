import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ManagerBis/TermsConditions/Domain/Repository/TermsConditionsRepository.dart';
import 'package:forutonafront/ManagerBis/TermsConditions/Dto/TermsConditionsResDto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:TermsConditionsRepository)
class TermsConditionsRepositoryImpl implements TermsConditionsRepository {
  @override
  Future<TermsConditionsResDto> findById(int idx) async {
    FDio fDio = FDio.noneToken();
    var response = await fDio.get("/termsConditions",queryParameters: {
      "idx": idx
    });
    return  TermsConditionsResDto.fromJson(response.data);
  }

}