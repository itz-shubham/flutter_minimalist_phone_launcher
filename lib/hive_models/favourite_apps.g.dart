// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_apps.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteAppsAdapter extends TypeAdapter<FavouriteApps> {
  @override
  final int typeId = 0;

  @override
  FavouriteApps read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteApps(
      appName: fields[0] as String,
      packageName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteApps obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.appName)
      ..writeByte(1)
      ..write(obj.packageName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteAppsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
