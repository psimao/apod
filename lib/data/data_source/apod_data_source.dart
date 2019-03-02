import 'package:apod/domain/entity/apod.dart';
export 'package:apod/domain/entity/apod.dart';
import 'package:apod/data/data_source.dart';
export 'package:apod/data/data_source.dart';

abstract class ApodDataSource implements DataSource<Apod> {

  Future<Apod> getAstronomyPictureOfDay(DateTime date);

  Future<bool> setAstronomyPictureOfDay(DateTime date, Apod apod);
}