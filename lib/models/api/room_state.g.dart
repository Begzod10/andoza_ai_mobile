// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomStateImpl _$$RoomStateImplFromJson(
  Map<String, dynamic> json,
) => _$RoomStateImpl(
  roomId: json['room_id'] as String,
  currentState: $enumDecode(_$RoomStateValueEnumMap, json['current_state']),
  floorState: $enumDecodeNullable(_$RoomStateValueEnumMap, json['floor_state']),
  ceilingState: $enumDecodeNullable(
    _$RoomStateValueEnumMap,
    json['ceiling_state'],
  ),
  wallsState: $enumDecodeNullable(_$RoomStateValueEnumMap, json['walls_state']),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$RoomStateImplToJson(_$RoomStateImpl instance) =>
    <String, dynamic>{
      'room_id': instance.roomId,
      'current_state': _$RoomStateValueEnumMap[instance.currentState]!,
      'floor_state': _$RoomStateValueEnumMap[instance.floorState],
      'ceiling_state': _$RoomStateValueEnumMap[instance.ceilingState],
      'walls_state': _$RoomStateValueEnumMap[instance.wallsState],
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$RoomStateValueEnumMap = {
  RoomStateValue.xom: 'xom',
  RoomStateValue.suvoq: 'suvoq',
  RoomStateValue.shpaklovka: 'shpaklovka',
  RoomStateValue.tayyor: 'tayyor',
};
