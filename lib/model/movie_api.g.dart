// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieS _$MovieSFromJson(Map<String, dynamic> json) {
  return MovieS(
    id: json['imdbID'] as String,
    type: json['Type'] as String,
    year: json['Year'] as String,
    title: json['Title'] as String,
    poster: json['Poster'] as String,
  );
}

Map<String, dynamic> _$MovieSToJson(MovieS instance) => <String, dynamic>{
  'imdbID': instance.id,
  'Title': instance.title,
  'Poster': instance.poster,
  'Year': instance.year,
  'Type': instance.type,
};
