import 'package:kiwi/kiwi.dart';
export 'package:kiwi/kiwi.dart';

final injector = Injector._internal();

class Injector {

  final Container _container = Container();

  Injector._internal();

  void inject(List<Module> modules) {
    modules.forEach((module) => module.registerOn(_container));
  }

  T resolve<T>([String name]) => _container.resolve(name);
}

abstract class Module {

  void registerOn(Container container);
}