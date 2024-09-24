// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPersonModel _$ChatPersonModelFromJson(Map<String, dynamic> json) =>
    ChatPersonModel(
      name: json['name'] as String?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      personId: json['personId'] as String?,
      status: $enumDecodeNullable(_$StatusPEnumMap, json['status']),
      profileUrl: json['profileUrl'] as String?,
      noUnreadMsgs: (json['noUnreadMsgs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChatPersonModelToJson(ChatPersonModel instance) =>
    <String, dynamic>{
      'personId': instance.personId,
      'name': instance.name,
      'messages': instance.messages,
      'status': _$StatusPEnumMap[instance.status],
      'profileUrl': instance.profileUrl,
      'noUnreadMsgs': instance.noUnreadMsgs,
    };

const _$StatusPEnumMap = {
  StatusP.Online: 'Online',
  StatusP.Offline: 'Offline',
};
