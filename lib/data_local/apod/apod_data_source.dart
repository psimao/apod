import 'package:apod/data/data_source/apod_data_source.dart';
import 'package:apod/data_local/apod/apod_storage.dart';

class LocalApodDataSource extends ApodDataSource {

  final ApodStorage _storage;
  final EntityMapper<Apod> _mapper;

  LocalApodDataSource(this._storage, this._mapper);

  @override
  Future<Apod> getAstronomyPictureOfDay(DateTime date) {
    return _storage.getPictureOfTheDay(date)
        .then((response) => _mapper.map(response));
  }

  @override
  Future<bool> setAstronomyPictureOfDay(DateTime date, Apod apod) {
    return _storage.storePictureOfTheDay(date, _mapper.transform<String>(apod));
  }
}