import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/AddressSearchHistory/Domain/Repository/AddressSearchHistoryRepository.dart';
import 'package:forutonafront/Common/AddressSearchHistory/Domain/Value/AddressSearchHistory.dart';
import 'package:forutonafront/Common/AddressSearchHistory/Dto/AddressSearchHistoryDto.dart';
import 'package:injectable/injectable.dart';

abstract class AddressSearchHistoryUseCaseInputPort {
  Future<AddressSearchHistoryDto> save(String search);
  Future<void> delete(String search);
  Future<List<AddressSearchHistoryDto>> findByAll();
}

@LazySingleton(as: AddressSearchHistoryUseCaseInputPort)
class AddressSearchHistoryUseCase implements AddressSearchHistoryUseCaseInputPort{
  final AddressSearchHistoryRepository addressSearchHistoryRepository;

  AddressSearchHistoryUseCase({@required this.addressSearchHistoryRepository});

  @override
  Future<void> delete(String search) async {
    await addressSearchHistoryRepository.delete(search);
  }

  @override
  Future<List<AddressSearchHistoryDto>> findByAll() async {
    var list = await addressSearchHistoryRepository.findByAll();
    if(list.length == 0){
      return [];
    }
    return list.map((e) => AddressSearchHistoryDto.fromAddressSearchHistory(e)).toList();
  }

  @override
  Future<AddressSearchHistoryDto> save(String search) async {
    var addressSearchHistory = await addressSearchHistoryRepository.save(search);
    return AddressSearchHistoryDto.fromAddressSearchHistory(addressSearchHistory);
  }

}