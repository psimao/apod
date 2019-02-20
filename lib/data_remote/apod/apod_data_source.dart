import 'package:apod/data/data_source/apod_data_source.dart';
import 'package:apod/data_remote/apod/apod_service.dart';

class RemoteApodDataSource extends ApodDataSource {

  final ApodService _service;
  final EntityMapper<Apod> _mapper;

  RemoteApodDataSource(this._service, this._mapper);

  @override
  Future<Apod> getAstronomyPictureOfDay(DateTime date) {
    return _service.getPictureOfTheDay(date)
        .then((response) => _mapper.map(response));
  }

  @override
  Future<bool> setAstronomyPictureOfDay(DateTime date, Apod apod) {
    // Remote operation not supported
    return null;
  }
}