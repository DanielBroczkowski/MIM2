import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable(explicitToJson: true)
class Book{
  String id;
  String title;
  String author;
  String year;
  bool read;

  Book({this.id, this.title, this.author, this.year, this.read});

  void setUuid(String uuid){
    this.id = uuid;
  }

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}