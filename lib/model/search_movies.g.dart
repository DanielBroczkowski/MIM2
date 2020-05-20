// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMovies _$SearchMoviesFromJson(Map<String, dynamic> json) {
  return SearchMovies(
    results: (json['Search'] as List)
        ?.map((e) =>
    e == null ? null : MovieS.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchMoviesToJson(SearchMovies instance) =>
    <String, dynamic>{
      'Search': instance.results,
    };
