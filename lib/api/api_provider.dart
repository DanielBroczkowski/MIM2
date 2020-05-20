import 'package:mim2/model/movie_details.dart';
import 'package:mim2/model/search_movies.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'api_provider.g.dart';

@RestApi(baseUrl: 'http://www.omdbapi.com/')
abstract class OmdbMoviesProvider{

  factory OmdbMoviesProvider(Dio dio, {String baseUrl}) = _OmdbMoviesProvider;

  @GET("http://www.omdbapi.com/")
  Future<SearchMovies> getMovieList(@Query("s") String text, {@Query ("apikey") String apiKey = "32e4f0c6"});

  @GET("http://www.omdbapi.com/")
  Future<MovieT> getCurrentMovie(@Query("i") String text, {@Query ("apikey") String apiKey = "32e4f0c6"});
}