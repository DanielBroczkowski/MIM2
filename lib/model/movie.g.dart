// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    id: json['id'] as String,
    title: json['title'] as String,
    director: json['director'] as String,
    year: json['year'] as String,
    watched: json['watched'] as bool,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'director': instance.director,
  'year': instance.year,
  'watched': instance.watched,
};
