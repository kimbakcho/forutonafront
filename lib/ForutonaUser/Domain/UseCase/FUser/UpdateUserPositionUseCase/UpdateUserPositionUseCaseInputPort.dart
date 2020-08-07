import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class UpdateUserPositionUseCaseInputPort {
  Future<void> updateUserPosition(LatLng latLng);
}
class UpdateUserPositionUseCase implements UpdateUserPositionUseCaseInputPort{

  final FUserRepository _fUserRepository;

  UpdateUserPositionUseCase({@required FUserRepository fUserRepository})
      : _fUserRepository = fUserRepository;

  @override
  Future<void> updateUserPosition(LatLng latLng) async {
    return await _fUserRepository.updateUserPosition(latLng);
  }

}