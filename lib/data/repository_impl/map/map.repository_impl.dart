import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:hot_place/core/util/response.util.dart';
import 'package:hot_place/data/data_source/map/map.data_source.dart';
import 'package:hot_place/data/model/map/address/address.model.dart';
import 'package:hot_place/data/model/map/place/place.model.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entity/map/address/address.entity.dart';
import '../../../domain/entity/map/place/place.entity.dart';
import '../../../domain/repository/map/map.repository.dart';

@Singleton(as: MapRepository)
class MapRepositoryImpl extends MapRepository {
  final MapDataSource _mapDataSource;

  MapRepositoryImpl({required MapDataSource mapDataSource})
      : _mapDataSource = mapDataSource;

  @override
  Future<Position> getCurrentLocation() async =>
      await _mapDataSource.getCurrentLocation();

  @override
  Future<KakaoApiResponseWrapper<AddressEntity>> searchAddress(String keyword,
      {int? page, int? size}) async {
    final res =
        await _mapDataSource.searchAddress(keyword, page: page, size: size);
    return KakaoApiResponseWrapper<AddressEntity>(
        totalCount: res.totalCount,
        data: res.data.map((e) => e.toEntity()).toList());
  }

  @override
  Future<KakaoApiResponseWrapper<PlaceEntity>> searchPlacesByCategory(
      {required CategoryGroupCode category,
      Position? position,
      int? radius,
      int? page,
      int? size}) async {
    final pos = position ?? await getCurrentLocation();
    final res = await _mapDataSource.searchPlaceByCategory(
        category: category, latitude: pos.latitude, longitude: pos.longitude);
    return KakaoApiResponseWrapper(
        totalCount: res.totalCount,
        data: res.data.map((e) => e.toEntity()).toList());
  }
}
