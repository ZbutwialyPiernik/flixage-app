import 'package:cached_network_image/cached_network_image.dart';
import 'package:flixage/ui/widget/cached_network_image/dio_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Simple helper method
/// Because every single resource is protected, even static content in this case
/// we need to pass authentication header with bearer token.
///
/// In this case we will use custom [CacheManager] with [Dio] as http client.
/// [Dio] will have an [InterceptorsWrapper] and will handle authentication header.
class CustomImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final bool rounded;

  CustomImage({
    @required this.imageUrl,
    this.width = double.infinity,
    this.height = double.infinity,
    this.rounded = false,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: Provider.of<DioCacheManager>(context),
      imageBuilder: (context, imageProvider) {
        return rounded
            ? Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider),
                ),
              )
            : Stack(
                children: <Widget>[
                  // If image has opacity then it will be background
                  Container(
                    width: width,
                    height: height,
                    color: Colors.black26,
                  ),
                  Image(
                    width: width,
                    height: height,
                    image: imageProvider,
                  ),
                ],
              );
      },
      imageUrl: imageUrl ??
          "https://flodai.com/wp-content/themes/flotheme/assets/img/placeholder.png",
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: Colors.black26,
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.black26,
        child: Center(
          child: Icon(Icons.error_outline),
        ),
      ),
      width: width,
      height: height,
    );
  }
}
