// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactListAdapter extends TypeAdapter<ContactList> {
  @override
  final int typeId = 3;

  @override
  ContactList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactList()..contacts = (fields[0] as List?)?.cast<User>();
  }

  @override
  void write(BinaryWriter writer, ContactList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.contacts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactList _$ContactListFromJson(Map<String, dynamic> json) => ContactList()
  ..contacts = (json['contacts'] as List<dynamic>?)
      ?.map((e) => User.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ContactListToJson(ContactList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('contacts', instance.contacts);
  return val;
}
