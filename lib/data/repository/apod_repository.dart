import 'package:apod/data/entity/apod.dart';
import 'package:apod/data/repository.dart';
import 'package:apod/data/data_source/apod_data_source.dart';

class ApodRepository extends Repository<Apod> {

  final ApodDataSource remoteDataSource;
  final ApodDataSource localDataSource;

  ApodRepository(this.remoteDataSource, this.localDataSource);

  Future<Apod> getAstronomyPictureOfTheDay(DateTime date) async {
    var apod = await localDataSource.getAstronomyPictureOfDay(date);
    if (apod == null) {
      apod = await remoteDataSource.getAstronomyPictureOfDay(date);
      localDataSource.setAstronomyPictureOfDay(date, apod);
    }
    return apod;
  }
}
