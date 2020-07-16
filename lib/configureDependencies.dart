import 'package:forutonafront/configureDependencies.iconfig.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies(String environment) => $initGetIt(getIt,environment: environment);