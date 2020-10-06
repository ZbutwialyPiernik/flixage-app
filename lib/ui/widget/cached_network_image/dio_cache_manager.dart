import 'package:dio/dio.dart';
import 'package:flixage/ui/widget/cached_network_image/dio_file_service.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

enum HeaderPolicy { Merge, Replace }

class Settings {
  /// Cache duration, can be overriden by http headers when [allowHttpCacheHeaders] is true
  /// Default value: 7 days.
  Duration cacheDuration;

  /// Indicates if cache manager should respect http cache headers
  /// Default value: true.
  bool allowHttpCacheHeaders;

  /// Name of folder in temponary directory
  /// Default value: 'DioCacheManager'
  String cacheKey;

  /// Default request headers with lower priority than passed in [CacheManager] function
  Map<String, String> headers;

  /// Describes how http headers are treated
  /// [HeaderPolicy.Merge]: default headers have lower priority and are merged with those passed in [CacheManager] function
  /// [HeaderPolicy.Replace]: default headers are replaced with those passsed in [CacheManager] function
  /// Default value: HeaderPolicy.Merge
  HeaderPolicy headerPolicy;

  Settings(
      {this.cacheDuration = const Duration(days: 7),
      this.cacheKey = "DioCacheManager",
      this.headers = const {},
      this.allowHttpCacheHeaders = true,
      this.headerPolicy = HeaderPolicy.Merge});
}

class DioCacheManager extends BaseCacheManager {
  final Settings settings;
  final Dio dio;

  DioCacheManager(this.dio, this.settings)
      : assert(dio != null),
        assert(settings != null),
        super(settings.cacheKey, fileService: DioFileService(dio, settings));

  @override
  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return path.join(directory.path, settings.cacheKey);
  }
}
