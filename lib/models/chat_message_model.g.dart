// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      json['text'] as String?,
      DateTime.fromMillisecondsSinceEpoch(json['timestamp'] * 1000),
      json['sender'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      videoUrls: (json['videoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': _$StatusEnumMap[instance.status],
      'sender': instance.sender,
      'imageUrls': instance.imageUrls,
      'videoUrls': instance.videoUrls,
    };

const _$StatusEnumMap = {
  Status.Sent: 'Sent',
  Status.Received: 'Received',
  Status.Read: 'Read',
};
