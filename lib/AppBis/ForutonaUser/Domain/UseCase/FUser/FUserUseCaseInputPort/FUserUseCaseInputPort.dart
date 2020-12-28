import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:injectable/injectable.dart';

abstract class FUserUseCaseInputPort {
  Future<void> updateMaliciousMessageCheck();
}
@LazySingleton(as: FUserUseCaseInputPort)
class FUserUseCase implements FUserUseCaseInputPort{
  final FUserRepository _fUserRepository;

  FUserUseCase(this._fUserRepository);

  @override
  Future<void> updateMaliciousMessageCheck() async {
    await this._fUserRepository.updateMaliciousMessageCheck();
  }


}