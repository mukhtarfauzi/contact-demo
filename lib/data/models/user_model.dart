import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(includeIfNull: false)
class User {
  @HiveField(0)
  @JsonKey(name: 'id')
  int? id;

  @HiveField(1)
  @JsonKey(name: 'name')
  String? name;

  @HiveField(2)
  @JsonKey(name: 'email')
  String? email;


  @HiveField(3)
  @JsonKey(name: 'phone')
  String? phone;

  @HiveField(4)
  @JsonKey(name: 'address')
  Address? address;

  @HiveField(5)
  @JsonKey(name: 'avatar')
  String? avatar;

  User({
    this.id,
    this.name,
    this.address,
    this.email,
    this.phone,
    this.avatar,
  }) : super();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
