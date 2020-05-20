// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieT _$MovieTFromJson(Map<String, dynamic> json) {
  return MovieT(
    title: json['Title'] as String,
    type: json['Type'] as String,
    poster: json['Poster'] as String,
    director: json['Director'] as String,
    genre: json['Genre'] as String,
    imdbRate: json['imdbRating'] as String,
    imdbVotes: json['imdbVotes'] as String,
    plot: json['Plot'] as String,
    runtime: json['Runtime'] as String,
  )
    ..released = json['Released'] as String
    ..actors = json['Actors'] as String;
}

Map<String, dynamic> _$MovieTToJson(MovieT instance) => <String, dynamic>{
  'Title': instance.title,
  'Runtime': instance.runtime,
  'Poster': instance.poster,
  'Genre': instance.genre,
  'Released': instance.released,
  'imdbRating': instance.imdbRate,
  'Actors': instance.actors,
  'imdbVotes': instance.imdbVotes,
  'Director': instance.director,
  'Type': instance.type,
  'Plot': instance.plot,
};
