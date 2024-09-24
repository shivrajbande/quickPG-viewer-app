import 'package:json_annotation/json_annotation.dart';
import 'package:rento/models/chat_message_model.dart';
part 'chat_person_model.g.dart';

@JsonSerializable()
class ChatPersonModel {
  String ?personId;
  String ?name;
  List<ChatMessageModel> ?messages;
  StatusP ?status;
  String? profileUrl;
  int? noUnreadMsgs;
  ChatPersonModel({this.name, this.messages,  this.personId, this.status,this.profileUrl,this.noUnreadMsgs});
   factory ChatPersonModel.empty() {
    return ChatPersonModel(
      name: '',
      profileUrl: '',
      status: StatusP.Online,
      personId: '',
      messages: [],
    );
  }
  factory ChatPersonModel.fromJson(Map<String,dynamic>json) => _$ChatPersonModelFromJson(json);
  Map<String,dynamic>toJson() => _$ChatPersonModelToJson(this);
}

enum StatusP { Online, Offline }
