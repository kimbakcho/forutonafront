import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

abstract class FileDownLoaderUseCaseInputPort {
  Future<String> downloadAndSaveFile(String url, String fileName);
  Future<List<int>> downloadToByte(String url);
}
@Injectable(as: FileDownLoaderUseCaseInputPort)
class FileDownLoaderUseCase implements  FileDownLoaderUseCaseInputPort {

  @override
  Future<String> downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    Dio dio = new Dio();
    Response<List<int>> rs = await dio.get<List<int>>(url,
        options: Options(responseType: ResponseType.bytes));
    var file = File(filePath);
    await file.writeAsBytes(rs.data);
    return filePath;
  }

  @override
  Future<List<int>> downloadToByte(String url) async {
    Dio dio = new Dio();
    Response<List<int>> rs = await dio.get<List<int>>(url,
        options: Options(responseType: ResponseType.bytes));
    return rs.data;
  }

}