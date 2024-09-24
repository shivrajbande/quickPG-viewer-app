import 'package:json_annotation/json_annotation.dart';

part 'chat_message_model.g.dart';

@JsonSerializable()
class ChatMessageModel {
  String? text;
  DateTime timestamp;
  Status? status;
  String? sender;
  List<String>? imageUrls;
  List<String>? videoUrls;

  ChatMessageModel(
    this.text,
    this.timestamp,
    this.sender, {
    this.imageUrls,
    this.videoUrls,
    this.status,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}

enum Status { Sent, Received, Read }

enum Sender { Tenant, Owner }
