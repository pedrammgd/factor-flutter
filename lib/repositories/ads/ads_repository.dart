import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:factor_flutter_mobile/core/http_backend/global_config.dart';
import 'package:factor_flutter_mobile/models/ads/ads_view_model.dart';

class AdsRepository {
  final Dio _dio = httpClient();

  Future<Either<String, List<AdsViewModel>>> getAds() async {
    var getAds = await _dio.get('/ads');
    try {
      final result = getAds.data['results'].map<AdsViewModel>((element) {
        print(element);
        return AdsViewModel.fromJson(element);
      }).toList();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
