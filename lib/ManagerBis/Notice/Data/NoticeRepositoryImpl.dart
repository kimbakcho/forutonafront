import 'package:flutter/services.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ManagerBis/Notice/Domain/NoticeRepository.dart';
import 'package:forutonafront/ManagerBis/Notice/Dto/NoticeResDto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NoticeRepository)
class NoticeRepositoryImpl implements NoticeRepository {
  @override
  Future<PageWrap<NoticeResDto>> findByAll(Pageable pageable) async {
    FDio dio = FDio.noneToken();
    var response = await dio.get("/Notice/items",queryParameters: pageable.toJson());
    var pageWrap = PageWrap<NoticeResDto>.fromJson(response.data, NoticeResDto.fromJson);
    return pageWrap;
  }

  @override
  Future<NoticeResDto> findById(int idx) async {
    FDio dio = FDio.noneToken();
    var response = await dio.get("/Notice",queryParameters: {
      "idx": idx
    });
    return NoticeResDto.fromJson(response.data);
  }

}