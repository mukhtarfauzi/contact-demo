import 'package:contact_demo/data/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Auth {
  @HiveField(0)
  String? token;

  @HiveField(1)
  User? user;

  Auth({this.token, this.user});

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);
}