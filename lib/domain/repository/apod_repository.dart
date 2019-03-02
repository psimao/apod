import 'package:apod/domain/entity/apod.dart';
import 'package:apod/domain/repository.dart';
import 'package:apod/data/data_source/apod_data_source.dart';

abstract class ApodRepository implements Repository<Apod> {

  Future<Apod> getAstronomyPictureOfTheDay(DateTime date);
}
