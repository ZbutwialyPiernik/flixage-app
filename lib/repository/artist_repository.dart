import 'package:dio/dio.dart';
import 'package:flixage/model/album.dart';
import 'package:flixage/model/artist.dart';
import 'package:flixage/model/page_response.dart';
import 'package:flixage/model/track.dart';
import 'package:retrofit/http.dart';

part 'artist_repository.g.dart';

@RestApi()
abstract class ArtistRepository {
  factory ArtistRepository(Dio dio, {String baseUrl}) = _ArtistRepository;

  @GET("/artists/{id}")
  Future<Artist> getById(@Path() String id);

  @GET("/artists/{id}/singles")
  Future<List<Track>> getSingles(@Path() String id);

  @GET("/artists/{id}/albums")
  Future<List<Album>> getAlbums(@Path() String id);

  @GET("/artists/recent")
  Future<PageResponse<Artist>> getRecentlyAdded({
    @Query("offset") int offset = 0,
    @Query("limit") int limit = 10,
  });
}
