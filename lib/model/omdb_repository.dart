import 'package:mim2/api/api_provider.dart';
import 'package:mim2/model/movie_details.dart';
import 'package:mim2/model/search_movies.dart';

class OmdbRepository{
  OmdbMoviesProvider _omdbMoviesProvider;

  OmdbRepository(this._omdbMoviesProvider);

  Future<SearchMovies> fetchResults(String title)  => _omdbMoviesProvider.getMovieList(title);

  Future<MovieT> getTitle(String id) => _omdbMoviesProvider.getCurrentMovie(id);
}