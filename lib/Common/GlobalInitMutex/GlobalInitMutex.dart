import 'package:injectable/injectable.dart';
import 'package:mutex/mutex.dart';
@lazySingleton
class GlobalInitMutex {
  Mutex geoRequestMutex = new Mutex();
}