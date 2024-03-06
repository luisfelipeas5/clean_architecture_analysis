import 'package:clean_architecture_analysis/src/architecture_core/dependency_injector/app/app_dependency_injector.dart';
import 'package:get_it/get_it.dart';

class GetItAppDependencyInjector implements AppDependencyInjector {
  @override
  D call<D extends Object>() => get();

  @override
  D get<D extends Object>() {
    return GetIt.I.get();
  }

  @override
  void putSingleton<D extends Object>(Creator<D> creator) {
    GetIt.I.registerSingleton(creator(this));
  }
}
