// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoomState _$RoomStateFromJson(Map<String, dynamic> json) => _RoomState(
  roomId: json['room_id'] as String,
  currentState: $enumDecode(
    _$RoomStateValueEnumMap,
    json['current_state'],
    unknownValue: RoomStateValue.unknown,
  ),
  floorState: $enumDecodeNullable(
    _$RoomStateValueEnumMap,
    json['floor_state'],
    unknownValue: RoomStateValue.unknown,
  ),
  ceilingState: $enumDecodeNullable(
    _$RoomStateValueEnumMap,
    json['ceiling_state'],
    unknownValue: RoomStateValue.unknown,
  ),
  wallsState: $enumDecodeNullable(
    _$RoomStateValueEnumMap,
    json['walls_state'],
    unknownValue: RoomStateValue.unknown,
  ),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$RoomStateToJson(_RoomState instance) =>
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
  RoomStateValue.unknown: 'unknown',
};
