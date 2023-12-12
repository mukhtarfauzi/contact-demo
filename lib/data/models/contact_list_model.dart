import 'package:contact_demo/data/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_list_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(includeIfNull: false)
class ContactList  {
  @HiveField(0)
  List<User>? contacts;

  ContactList() : super();

  factory ContactList.fromJson(Map<String, dynamic> json) => _$ContactListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContactListToJson(this);
}
