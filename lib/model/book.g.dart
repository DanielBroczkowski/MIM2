// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
    id: json['id'] as String,
    title: json['title'] as String,
    author: json['author'] as String,
    year: json['year'] as String,
    read: json['read'] as bool,
  );
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'author': instance.author,
  'year': instance.year,
  'read': instance.read,
};
