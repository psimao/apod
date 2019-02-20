import 'package:apod/data/data_source/apod_data_source.dart';
import 'package:apod/data/entity/apod.dart';
import 'package:apod/data/entity_mapper.dart';
import 'package:apod/data/repository/apod_repository.dart';
import 'package:apod/data_local/local_data_source.dart';
import 'package:apod/data_remote/remote_data_source.dart';
import 'package:apod/redux/middleware/load_apod_middleware.dart';
import 'package:apod/injector.dart';

class DataModule extends Module {
  @override
  void registerOn(Container container) {
    container.registerSingleton(
        (c) => ApodRepository(c.resolve("remote"), c.resolve("local")));
  }
}

class DataLocalModule extends Module {
  @override
  void registerOn(Container container) {
    container.registerSingleton((c) => ApodStorage());
    container.registerSingleton<EntityMapper<Apod>, LocalApodMapper>(
        (c) => LocalApodMapper(),
        name: "local");
    container.registerSingleton<ApodDataSource, LocalApodDataSource>(
        (c) => LocalApodDataSource(c.resolve(), c.resolve("local")),
        name: "local");
  }
}

class DataRemoteModule extends Module {
  @override
  void registerOn(Container container) {
    container.registerSingleton((c) => ApodService());
    container.registerSingleton<EntityMapper<Apod>, LocalApodMapper>(
        (c) => RemoteApodMapper(),
        name: "remote");
    container.registerSingleton<ApodDataSource, LocalApodDataSource>(
        (c) => RemoteApodDataSource(c.resolve(), c.resolve("remote")),
        name: "remote");
  }
}

class ReduxModule extends Module {
  @override
  void registerOn(Container container) {
    container
        .registerSingleton((c) => LoadApodMiddleware.createTyped(c.resolve()));
  }
}
