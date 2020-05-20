import 'package:json_annotation/json_annotation.dart';
import 'package:mim2/model/movie_api.dart';

part 'search_movies.g.dart';

@JsonSerializable()
class SearchMovies{
  @JsonKey(name: "Search")
  List<MovieS> results;

  SearchMovies({this.results});

  factory SearchMovies.fromJson(Map<String, dynamic> json) => _$SearchMoviesFromJson(json);
  Map<String, dynamic> get json => _$SearchMoviesToJson(this);

}