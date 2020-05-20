import 'package:json_annotation/json_annotation.dart';

part 'movie_api.g.dart';

@JsonSerializable()
class MovieS{
  @JsonKey(name: "imdbID")
  String id;
  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "Poster")
  String poster;
  @JsonKey(name: "Year")
  String year;
  @JsonKey(name: "Type")
  String type;

  MovieS({this.id, this.type, this.year, this.title, this.poster});

  factory MovieS.fromJson(Map<String, dynamic> json) => _$MovieSFromJson(json);

  Map<String, dynamic> get json => _$MovieSToJson(this);

}