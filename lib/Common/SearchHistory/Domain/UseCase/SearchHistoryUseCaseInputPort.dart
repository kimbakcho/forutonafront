import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';
import 'package:forutonafront/Common/SearchHistory/Dto/SearchHistoryDto.dart';

abstract class SearchHistoryUseCaseInputPort {
  Future<SearchHistoryDto> save(String search);
  Future<void> delete(String search);
  Future<List<SearchHistoryDto>> findByAll();
}

class SearchHistoryUseCase implements SearchHistoryUseCaseInputPort{
  final SearchHistoryRepository searchHistoryRepository;

  SearchHistoryUseCase({@required this.searchHistoryRepository});

  @override
  Future<void> delete(String search) async {
    await searchHistoryRepository.delete(search);
  }

  @override
  Future<List<SearchHistoryDto>> findByAll() async {
    var list = await searchHistoryRepository.findByAll();
    if(list.length == 0){
      return [];
    }
    return list.map((e) => SearchHistoryDto.fromSearchHistory(e)).toList();
  }

  @override
  Future<SearchHistoryDto> save(String search) async {
    var addressSearchHistory = await searchHistoryRepository.save(search);
    return SearchHistoryDto.fromSearchHistory(addressSearchHistory);
  }

}