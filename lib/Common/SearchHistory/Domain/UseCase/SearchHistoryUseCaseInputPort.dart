import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';
import 'package:forutonafront/Common/SearchHistory/Dto/SearchHistoryDto.dart';

abstract class SearchHistoryUseCaseInputPort {
  Future<SearchHistoryDto> save(String search,String uid);
  Future<void> delete(String search,String uid);
  Future<List<SearchHistoryDto>> findByAll(String uid);
}

class SearchHistoryUseCase implements SearchHistoryUseCaseInputPort{
  final SearchHistoryRepository searchHistoryRepository;

  SearchHistoryUseCase({required this.searchHistoryRepository});

  @override
  Future<void> delete(String search,String uid) async {
    await searchHistoryRepository.delete(search,uid);
  }

  @override
  Future<List<SearchHistoryDto>> findByAll(String uid) async {
    var list = await searchHistoryRepository.findByAll(uid);
    if(list.length == 0){
      return [];
    }
    return list.map((e) => SearchHistoryDto.fromSearchHistory(e)).toList();
  }

  @override
  Future<SearchHistoryDto> save(String search,String uid) async {
    var addressSearchHistory = await searchHistoryRepository.save(search,uid);
    return SearchHistoryDto.fromSearchHistory(addressSearchHistory);
  }

}