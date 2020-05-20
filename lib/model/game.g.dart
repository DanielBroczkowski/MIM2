// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
    id: json['id'] as String,
    title: json['title'] as String,
    producer: json['producer'] as String,
    year: json['year'] as String,
    played: json['played'] as bool,
  );
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'producer': instance.producer,
  'year': instance.year,
  'played': instance.played,
};
