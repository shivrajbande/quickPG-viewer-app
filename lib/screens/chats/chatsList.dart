import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rento/constants/app_localization_util.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/constants/space_constants.dart';
import 'package:rento/controllers/chat_controller.dart';
import 'package:rento/helpers/routes.dart';
import 'package:rento/models/chat_message_model.dart';
import 'package:rento/models/chat_person_model.dart';
import 'package:rento/screens/chats/chat.dart';
import 'package:rento/widgets/custom_bottom_navbar.dart';
import 'package:rento/widgets/custom_image.dart';

class ChatsList extends StatelessWidget {
  ChatsList({super.key});

  //fetch this sender chats from firebase and display here in format

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     backgroundColor: ColorCodes.white,
    //     appBar: AppBar(
    //       title: Text('Messages'),
    //     ),
    //     body: Column(
    //       children: Get.find<ChatController>().chatsList.entries.map((entry) {
    //         var key = entry.key;
    //         var chatProfileData = entry.value;
    //         return ListTile(
    //           leading: CircleAvatar(
    //               backgroundImage:
    //                   NetworkImage(chatProfileData['profilePicture'])),
    //           title: Text(chatProfileData['name']),
    //           // subtitle: Text(chat.lastMessage),
    //           // trailing: Text(chat.lastMessageTime)
    //           onTap: () {
    //             //load selected chat all message
    //
    //             // Get.find<ChatController>().fetchUserChats("987654");
    //
    //             Map<String, String> data = {
    //               "senderID": "987654",
    //               "reciverID": chatProfileData['id'],
    //             };
    //             Get.toNamed(RouteManagement.chat, parameters: data);
    //           },
    //         );
    //       }).toList(),
    //     ));
    return Scaffold(
      backgroundColor: ColorCodes.white,
      body: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimensions.sizedLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  AppLocalizationUtil.getTranslatedString("chats"),
                  style: FontManager().getTextStyle(context,
                      fontSize: 32,
                      color: ColorCodes.black,
                      lWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: Dimensions.sizedLarge,
                ),
                const Divider(
                  color: ColorCodes.greyBr,
                ),
                const SizedBox(
                  height: Dimensions.sizedLarge,
                ),
                Expanded(
                  child: FutureBuilder<List<String>>(
                    future: Get.find<ChatController>().getChatsList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final chatRoomIds = snapshot.data!;
                        return ListView.builder(
                          itemCount: chatRoomIds.length,
                          itemBuilder: (context, index) {
                            return StreamBuilder<ChatPersonModel>(
                              stream: getChatPersonStream(chatRoomIds[index]),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final item = snapshot.data!;
                                  return buildChatItem(context, item);
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                return const Center(child:CircularProgressIndicator());
                              },
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                const Visibility(
                    maintainSize: true,
                    maintainState: true,
                    visible: false,
                    maintainAnimation: true,
                    child: CustomBottomNavbar()),
              ],
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomBottomNavbar(),
            ],
          )
        ],
      ),
    );
  }
}

Stream<ChatPersonModel> getChatPersonStream(String chatRoomId) {
  return FirebaseDatabase.instance
      .ref('chatRooms/$chatRoomId')
      .onValue
      .map((event) {
    final chatRoomData =
        convertToMap(event.snapshot.value as Map<Object?, Object?>);
    final user = chatRoomData['users'];
    final messages = chatRoomData['messages'];

    return createChatPersonModel(user, messages);
  });
}

ChatPersonModel createChatPersonModel(
    Map<String, dynamic> users, Map<String, dynamic> messages) {
  ChatPersonModel? result;
  List<ChatMessageModel> chatMessageModelList = [];
  List<Map<String, dynamic>> chatTempList = [];

  try {
    // Process messages
    if (messages != null) {
      messages.forEach((key, value) {
        chatTempList.add(value);
      });
    }

    // Process users
    if (users != null) {
      for (var entry in users.entries) {
        var personModel = {
          'name': entry.value['name'],
          'profileUrl': entry.value['imageURL'],
          'status': entry.value['status'] == 'online'
              ? StatusP.Online
              : StatusP.Offline,
          'personChatID': entry.key,
          'messages': chatTempList
        };
        ChatPersonModel chatPersonModel = ChatPersonModel.fromJson(personModel);
        // chatPersonModel.messages = chatMessageModelList;
        return chatPersonModel;
        // if (entry.key == chatID) {

        //   // result = chatPersonModel;
        // }
      }
    }
  } catch (error) {
    print("Error in createUsersModel: $error");
  }

  // Return a default value if no user found or an error occurred
  return result ?? ChatPersonModel.empty();
}

Widget buildChatItem(BuildContext context, ChatPersonModel item) {
  //  var item = Get.find<ChatController>()
  //                                         .persons[index];
  DateTime today = DateTime(2024, 7, 7);
  int diff = today.difference(item.messages!.last.timestamp).inDays;
  int day = item.messages!.last.timestamp.weekday;
  DateTime date = item.messages!.last.timestamp;
  String time = diff == 0
      ? "${date.hour > 12 ? "${date.hour - 12}" : "${date.hour}"}:${date.minute} ${date.hour > 12 ? "PM" : "AM"}"
      : diff == 1
          ? "Yesterday"
          : day == 1
              ? "Monday"
              : day == 2
                  ? "Tuesday"
                  : day == 3
                      ? "Wednesday"
                      : day == 4
                          ? "Thursday"
                          : day == 5
                              ? "Friday"
                              : day == 6
                                  ? "Saturday"
                                  : "Sunday";
  return InkWell(
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    onTap: () =>
        Get.toNamed(RouteManagement.chat, arguments: {"chatPerson": item}),
    child: Container(
      margin: const EdgeInsets.only(bottom: Dimensions.paddingDefault),
      decoration: BoxDecoration(
          color: ColorCodes.white,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          boxShadow: const [
            BoxShadow(color: ColorCodes.greyBg, offset: Offset(0, 2))
          ]),
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSmall),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: ColorCodes.greyBg,
                radius: Dimensions.radiusExtraLarger,
                child: Text(item.name!.characters.first),
              ),
              Transform.translate(
                offset: const Offset(42, 40),
                child: CircleAvatar(
                  backgroundColor: ColorCodes.white,
                  radius: Dimensions.radiusSmall,
                  child: CircleAvatar(
                    backgroundColor: item.status == StatusP.Online
                        ? Colors.green.shade500
                        : Colors.grey.shade300,
                    radius: Dimensions.radiusExtraSmall,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            width: Dimensions.sizedDefault,
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name!,
                  style: FontManager().getTextStyle(context,
                      fontSize: 18,
                      color: ColorCodes.black,
                      lWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: Dimensions.sizedExtraSmall,
                ),
                Row(
                  children: [
                    CustomImageView(
                      imgUrl: "assets/images/chat/read.svg",
                      svgColor: item.messages!.last.status == Status.Read
                          ? ColorCodes.msgBlue
                          : null,
                    ),
                    const SizedBox(
                      width: Dimensions.sizedSmall,
                    ),
                    Expanded(
                      child: Text(
                        item.messages!.last.text ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: FontManager().getTextStyle(context,
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            lWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: FontManager().getTextStyle(context,
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      lWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: Dimensions.sizedSmall,
                ),
                item.noUnreadMsgs != null
                    ? CircleAvatar(
                        radius: Dimensions.radiusSmall,
                        backgroundColor: Colors.orange.shade400,
                        child: Text(
                          item.noUnreadMsgs!.toString(),
                          style: FontManager().getTextStyle(context,
                              fontSize: 14,
                              color: ColorCodes.white,
                              lWeight: FontWeight.w500),
                        ),
                      )
                    : Container()
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Map<String, dynamic> convertToMap(Map<Object?, Object?> input) {
  return input.map((key, value) {
    if (value is Map<Object?, Object?>) {
      return MapEntry(key as String, convertToMap(value));
    } else {
      return MapEntry(key as String, value);
    }
  });
}
