import 'package:apod/domain/entity/apod.dart';
import 'package:apod/data/data_source/apod_data_source.dart';
import 'package:apod/domain/repository/apod_repository.dart';

class CachedApodRepository implements ApodRepository {

  final ApodDataSource remoteDataSource;
  final ApodDataSource localDataSource;

  CachedApodRepository(this.remoteDataSource, this.localDataSource);

  @override
  Future<Apod> getAstronomyPictureOfTheDay(DateTime date) async {
    var apod = await localDataSource.getAstronomyPictureOfDay(date);
    if (apod == null) {
      apod = await remoteDataSource.getAstronomyPictureOfDay(date);
      if (apod != null) {
        localDataSource.setAstronomyPictureOfDay(date, apod);
      }
    }
    return apod;
  }
}
