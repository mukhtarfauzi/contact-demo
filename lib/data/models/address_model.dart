import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(includeIfNull: false)
class Address {
  @HiveField(0)
  @JsonKey(name: 'street')
  String? street;

  @HiveField(1)
  @JsonKey(name: 'city')
  String? city;

  @HiveField(2)
  @JsonKey(name: 'state')
  String? state;

  @HiveField(3)
  @JsonKey(name: 'zip')
  String? zip;


  Address({
    this.street,
    this.city,
    this.state,
    this.zip,
  }) : super();

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
