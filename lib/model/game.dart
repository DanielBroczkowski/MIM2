import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game{
  String id;
  String title;
  String producer;
  String year;
  bool played;

  Game({this.id, this.title, this.producer, this.year, this.played});

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}