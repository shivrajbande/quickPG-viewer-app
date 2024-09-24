import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:rento/constants/color_codes.dart';
import 'package:rento/constants/font_manager.dart';
import 'package:rento/constants/space_constants.dart';
import 'package:rento/controllers/chat_controller.dart';
import 'package:rento/models/chat_message_model.dart';
import 'package:rento/models/chat_person_model.dart';
import 'package:rento/widgets/custom_bottom_navbar.dart';
import 'package:rento/widgets/custom_image.dart';
import 'package:rento/widgets/custom_textfield.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
  });

  String? ownerName = Get.parameters["ownerName"];
  String? ownerId = Get.parameters["ownerId"];
  String? phoneNumber = Get.parameters["phoneNumber"];
  String? photo = Get.parameters["photo"];
   String? ownerChatId = Get.parameters["chatId"];

  final ChatController chatController = Get.put(ChatController());
  

  ChatPersonModel? chatPerson =
      ChatPersonModel(name: Get.parameters["ownerName"],personId:Get.parameters["ownerId"],profileUrl: 'https://upload.wikimedia.org/wikipedia/en/3/3f/NobitaNobi.png',messages: [],status: StatusP.Online);

  // @override
  // Widget build(BuildContext context) {
  //   return PopScope(
  //     onPopInvoked: (didPop) {
  //       Navigator.pop(context);
  //     },
  //     child: Scaffold(
  //       appBar: AppBar(
  //         title: Text('Chat App viewer'),
  //       ),
  //       body: Column(
  //         children: [
  //           Obx(
  //             () => Expanded(
  //                 child: Get.find<ChatController>().messages.isNotEmpty
  //                     ? ListView.builder(
  //                         itemCount: Get.find<ChatController>().messages.length,
  //                         itemBuilder: (context, index) {
  //                           var messageData =
  //                               Get.find<ChatController>().messages[index];
  //                           var chatSenderID = messageData["senderId"];

  //                           return chatSenderID !=
  //                                   senderID //messages from receiver
  //                               ? Container(
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(8.0),
  //                                     color: Color.fromARGB(255, 211, 255, 213),
  //                                   ),
  //                                   margin: EdgeInsets.only(
  //                                       left:
  //                                           MediaQuery.of(context).size.width /
  //                                               2,
  //                                       bottom: 3.0),
  //                                   child: ListTile(
  //                                     title: Text(
  //                                       messageData["message"],
  //                                       style: TextStyle(color: Colors.black),
  //                                     ),
  //                                   ),
  //                                 )
  //                               : Container(
  //                                   margin: EdgeInsets.only(
  //                                       right:
  //                                           MediaQuery.of(context).size.width /
  //                                               2,
  //                                       bottom: 3.0),
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(8.0),
  //                                     color: Color.fromARGB(255, 255, 225, 179),
  //                                   ),
  //                                   child: ListTile(
  //                                     //messages from sender self
  //                                     title: Text(
  //                                       messageData["message"],
  //                                       style: TextStyle(color: Colors.black),
  //                                     ),
  //                                   ),
  //                                 );
  //                           // return Container();
  //                         },
  //                       )
  //                     : Container()),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: TextField(
  //                     controller: Get.find<ChatController>().controller,
  //                     decoration: InputDecoration(
  //                       hintText: 'Enter message',
  //                     ),
  //                   ),
  //                 ),
  //                 IconButton(
  //                   icon: Icon(Icons.send),
  //                   onPressed: () {
  //                     // Map<dynamic, dynamic> temp = {};
  //                     // temp['message'] =
  //                     //     Get.find<ChatController>().controller.text;
  //                     // Get.find<ChatController>().messages.add(temp);
  //                     Get.find<ChatController>().sendMessage(
  //                         senderID!,
  //                         Get.find<ChatController>().currentChatRoomID,
  //                         Get.find<ChatController>().controller.text);
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
     if (ownerChatId != null) {
      chatController.setReceiverChatId(ownerChatId!);
    }
    return Scaffold(
      backgroundColor: ColorCodes.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Dimensions.initialHeight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () => Get.back(),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                )),
                            const SizedBox(
                              width: Dimensions.sizedDefault,
                            ),
                            Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: ColorCodes.greyBg,
                                  radius: Dimensions.radiusExtraLarger,
                                  child: Text(
                                      chatPerson?.name!.characters.first ?? ''),
                                ),
                                Transform.translate(
                                  offset: const Offset(42, 40),
                                  child: CircleAvatar(
                                    backgroundColor: ColorCodes.white,
                                    radius: Dimensions.radiusSmall,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          chatPerson?.status == StatusP.Online
                                              ? Colors.green.shade500
                                              : Colors.grey.shade300,
                                      radius: Dimensions.radiusExtraSmall,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: Dimensions.sizedSmall,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chatPerson?.name ?? '',
                                  style: FontManager().getTextStyle(context,
                                      fontSize: 18,
                                      color: ColorCodes.black,
                                      lWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: Dimensions.sizedExtraSmall,
                                ),
                                Text(
                                  'last seen 5h ago',
                                  overflow: TextOverflow.ellipsis,
                                  style: FontManager().getTextStyle(context,
                                      fontSize: 18,
                                      color: Colors.grey.shade600,
                                      lWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Icon(Icons.call_sharp),
                            ),
                            const SizedBox(
                              width: Dimensions.sizedSmall,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(Icons.more_vert),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.sizedExtraSmall,
                    ),
                    const Divider(
                      color: ColorCodes.greyBr,
                    ),
                    const SizedBox(
                      height: Dimensions.sizedLarge,
                    ),
                    chatPerson != null
                        ? Expanded(
                            child: SingleChildScrollView(
                                child: StreamBuilder(
                                    stream: FirebaseDatabase.instance
                                        .ref()
                                        .child(
                                            'chatRooms/${Get.find<ChatController>().currentChatRoomID}/messages')
                                        .onValue,
                                    builder: (context,
                                        AsyncSnapshot<DatabaseEvent> snapshot) {
                                      if (snapshot.hasError) {
                                        return const Center(
                                            child:
                                                Text('Something went wrong'));
                                      } else if (!snapshot.hasData ||
                                          !snapshot.data!.snapshot.exists) {
                                        return const Center(
                                            child: Text('No messages'));
                                      }

                                      // Convert the data into a list of messages
                                      final messages =
                                          Map<String, dynamic>.from(snapshot
                                              .data!.snapshot.value as Map);
                                      List<ChatMessageModel> tempMessages = [];

                                      messages.entries.map((entry) {
                                        final message =
                                            Map<String, dynamic>.from(
                                                entry.value);

                                        tempMessages.add(ChatMessageModel(
                                            message['text'],
                                            DateTime.fromMillisecondsSinceEpoch(
                                                message['timestamp'] * 1000),
                                            message['senderId']));
                                      });
                                      chatPerson?.messages = tempMessages;
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: chatPerson?.messages!.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          DateTime date = chatPerson
                                                  ?.messages![index]
                                                  .timestamp ??
                                              DateTime(2024);
                                          return chatPerson?.messages![index]
                                                      .sender !=
                                                  Sender.Tenant.name
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          bottom: Dimensions
                                                              .paddingDefault),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            width: chatPerson!
                                                                            .messages![
                                                                                index]
                                                                            .text!
                                                                            .length >
                                                                        40 ||
                                                                    chatPerson
                                                                            ?.messages?[
                                                                                index]
                                                                            .imageUrls !=
                                                                        null
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.75
                                                                : null,
                                                            decoration: const BoxDecoration(
                                                                color: ColorCodes
                                                                    .blueColor,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius.circular(
                                                                        Dimensions
                                                                            .radiusSmall),
                                                                    topRight: Radius.circular(
                                                                        Dimensions
                                                                            .radiusSmall),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            Dimensions.radiusSmall))),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    Dimensions
                                                                        .paddingDefault),
                                                            margin: const EdgeInsets
                                                                .only(
                                                                bottom: Dimensions
                                                                        .paddingExtraSmall /
                                                                    2),
                                                            child: Text(
                                                              chatPerson
                                                                      ?.messages?[
                                                                          index]
                                                                      .text ??
                                                                  '',
                                                              style: FontManager().getTextStyle(
                                                                  context,
                                                                  color:
                                                                      ColorCodes
                                                                          .white,
                                                                  fontSize: 18,
                                                                  lWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                          Text(
                                                              "${date.hour > 12 ? "${date.hour - 12}" : "${date.hour}"}:${date.minute} ${date.hour > 12 ? "PM" : "AM"}",
                                                              style: FontManager().getTextStyle(
                                                                  context,
                                                                  color: ColorCodes
                                                                      .greyTextColor,
                                                                  fontSize: 12,
                                                                  lWeight:
                                                                      FontWeight
                                                                          .w400))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          ColorCodes.greyBg,
                                                      radius: Dimensions
                                                          .radiusSmall,
                                                      child: Text(
                                                        chatPerson
                                                                ?.name
                                                                ?.characters
                                                                .first ??
                                                            '',
                                                        style: FontManager()
                                                            .getTextStyle(
                                                                context,
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: Dimensions
                                                          .sizedExtraSmall,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          top: Dimensions
                                                              .paddingSmall,
                                                          bottom: Dimensions
                                                              .paddingDefault),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: chatPerson!
                                                                            .messages![
                                                                                index]
                                                                            .text!
                                                                            .length >
                                                                        40 ||
                                                                    chatPerson
                                                                            ?.messages![
                                                                                index]
                                                                            .imageUrls !=
                                                                        null
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.75
                                                                : null,
                                                            decoration: const BoxDecoration(
                                                                color:
                                                                    ColorCodes
                                                                        .greyBg,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            Dimensions
                                                                                .radiusSmall),
                                                                    topRight: Radius.circular(
                                                                        Dimensions
                                                                            .radiusSmall),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            Dimensions.radiusSmall))),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    Dimensions
                                                                        .paddingDefault),
                                                            margin: const EdgeInsets
                                                                .only(
                                                                bottom: Dimensions
                                                                        .paddingExtraSmall /
                                                                    2),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                chatPerson?.messages![index]
                                                                            .imageUrls !=
                                                                        null
                                                                    ? Wrap(
                                                                        spacing:
                                                                            10,
                                                                        runSpacing:
                                                                            10,
                                                                        children: chatPerson!
                                                                            .messages![index]
                                                                            .imageUrls!
                                                                            .map(
                                                                              (e) => CustomImageView(
                                                                                imgUrl: e,
                                                                                imgHeight: 150,
                                                                              ),
                                                                            )
                                                                            .toList(),
                                                                      )
                                                                    : Container(),
                                                                const SizedBox(
                                                                  height: Dimensions
                                                                      .sizedExtraSmall,
                                                                ),
                                                                Text(
                                                                  chatPerson
                                                                          ?.messages![
                                                                              index]
                                                                          .text ??
                                                                      '',
                                                                  style: FontManager().getTextStyle(
                                                                      context,
                                                                      color: ColorCodes
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      lWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                              "${date.hour > 12 ? "${date.hour - 12}" : "${date.hour}"}:${date.minute} ${date.hour > 12 ? "PM" : "AM"}",
                                                              style: FontManager().getTextStyle(
                                                                  context,
                                                                  color: ColorCodes
                                                                      .greyTextColor,
                                                                  fontSize: 12,
                                                                  lWeight:
                                                                      FontWeight
                                                                          .w400))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                        },
                                      );
                                    })),
                          )
                        : Container(),
                    const Visibility(
                        maintainSize: true,
                        maintainState: true,
                        visible: false,
                        maintainAnimation: true,
                        child: CustomBottomNavbar()),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: Obx(
            //     () => StreamBuilder(
            //       stream: FirebaseDatabase.instance
            //           .ref()
            //           .child(
            //               'chatRooms/${Get.find<ChatController>().currentChatRoomID}/messages')
            //           .onValue,
            //       builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            //         if (snapshot.hasError) {
            //           return Center(child: Text('Something went wrong'));
            //         } else if (!snapshot.hasData ||
            //             !snapshot.data!.snapshot.exists) {
            //           return Center(child: Text('No messages'));
            //         }
            //
            //         // Convert the data into a list of messages
            //         final messages = Map<String, dynamic>.from(
            //             snapshot.data!.snapshot.value as Map);
            //
            //         return ListView(
            //           children: messages.entries.map((entry) {
            //             final message = Map<String, dynamic>.from(entry.value);
            //             return Container(
            //               margin: EdgeInsets.only(
            //                   left: message['senderId'] ==
            //                           Get.find<ChatController>().senderChatID
            //                       ? 100
            //                       : 0),
            //               child: ListTile(
            //                 title: Text(message['text']),
            //                 subtitle: Text(message['senderId']),
            //                 trailing: Text(
            //                   DateTime.fromMillisecondsSinceEpoch(
            //                           message['timestamp'] * 1000)
            //                       .toLocal()
            //                       .toString(),
            //                 ),
            //               ),
            //             );
            //           }).toList(),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            _buildMessageInput(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         child: TextField(
    //           controller: Get.find<ChatController>().controller,
    //           decoration: const InputDecoration(
    //             hintText: 'Enter your message...',
    //           ),
    //         ),
    //       ),
    //       IconButton(
    //         icon: const Icon(Icons.send),
    //         onPressed: () async {
    //           if (Get.find<ChatController>().controller.text.isNotEmpty) {
    //             // await FirebaseFirestore.instance
    //             //     .collection('chats')
    //             //     .doc(chatId)
    //             //     .collection('messages')
    //             //     .add({
    //             //   'senderId': 'yourSenderId', // Replace with actual sender ID
    //             //   'message': _controller.text,
    //             //   'timestamp': FieldValue.serverTimestamp(),
    //
    //             Get.find<ChatController>().sendMessage(
    //                 reciverID!, Get.find<ChatController>().controller.text);
    //             // });
    //
    //             Get.find<ChatController>().controller.clear();
    //           }
    //         },
    //       ),
    //     ],
    //   ),
    // );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingExtraLarge,
              vertical: Dimensions.paddingExtraLarge),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  focusNode: FocusNode(),
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      Get.find<ChatController>().isTyping = true;
                    } else {
                      Get.find<ChatController>().isTyping = false;
                    }
                  },
                  controller: Get.find<ChatController>().controller,
                  fillColor: ColorCodes.white,
                  enabled: true,
                  hintText: "Enter your message",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusExtraLarge),
                    borderSide: const BorderSide(color: ColorCodes.greyBr),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusExtraLarge),
                    borderSide: const BorderSide(color: ColorCodes.greyBr),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusExtraLarge),
                    borderSide: const BorderSide(color: ColorCodes.greyBr),
                  ),
                  suffix: const Icon(
                    Icons.add,
                    color: ColorCodes.blueColor,
                  ),
                ),
              ),
              const SizedBox(
                width: Dimensions.sizedSmall,
              ),
              Obx(
                () => GestureDetector(
                  onTap: Get.find<ChatController>().isTyping ? () {

                    Get.find<ChatController>().sendMessage(
                   Get.find<ChatController>().controller.text);
             

                  } : null,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorCodes.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: ColorCodes.greyBr)),
                    padding: const EdgeInsets.all(Dimensions.paddingSmall),
                    child: Icon(Get.find<ChatController>().isTyping
                        ? Icons.send
                        : Icons.mic),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
