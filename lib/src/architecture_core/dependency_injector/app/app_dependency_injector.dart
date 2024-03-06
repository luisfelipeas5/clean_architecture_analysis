typedef Creator<T> = T Function(AppDependencyInjector injector);

abstract interface class AppDependencyInjector {
  void putSingleton<D extends Object>(Creator<D> creator);
  D get<D extends Object>();
  D call<D extends Object>();
}
