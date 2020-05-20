import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(explicitToJson: true)
class Movie{
  String id;
  String title;
  String director;
  String year;
  bool watched;

  Movie({this.id, this.title, this.director, this.year, this.watched});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}