import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:rento/constants/app_constants.dart';
import 'package:rento/controllers/login_controller.dart';
import 'package:rento/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class ChatController extends GetxController implements GetxService {
  late IO.Socket socket;
  LoginServices loginServices = LoginServices();

  RxList messages = [].obs;
  RxMap chatsList = {
    '': {
      'name': 'Shivraj',
      'id': '6KmuvphQjVU0P8Q94rHc',
      'profilePicture':
          'https://upload.wikimedia.org/wikipedia/en/3/3f/NobitaNobi.png',
    }
  }.obs;
  RxBool _isTyping = false.obs;

  var isConnected = false.obs;
  RxString? _senderId = ''.obs;
  RxString? _receiverId = ''.obs;
  TextEditingController _controller = TextEditingController();
  RxString _currentChatRoomId = "".obs;
  String? senderChatId = "";
  String? receiverChatId = "";
  bool? firstTimeChat = true;

  String? senderImage;
  String? senderName;

  String get senderID => _senderId!.value;

  String get receiverID => _receiverId!.value;

  TextEditingController get controller => _controller;

  String get currentChatRoomID => _currentChatRoomId.value;
  bool get isTyping => _isTyping.value;
  bool get isChattingFirstTime => firstTimeChat!;

  set senderID(String newValue) => _senderId!.value = newValue;

  set receiverID(String newValue) => _receiverId!.value = newValue;

  set currentChatRoomID(String newValue) => _currentChatRoomId.value = newValue;
  set isTyping(value) => _isTyping.value = value;
  set isChattingFirstTime(value) => firstTimeChat = value;

  void setReceiverChatId(String id) {
    receiverChatId = id;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    senderChatId = prefs.getString(SharedPrefKeys.senderChatId);
    senderImage = prefs.getString(SharedPrefKeys.userImage) ?? "";
    senderName = prefs.getString(SharedPrefKeys.userName) ?? "";
    createChatRoomId(senderChatId!, receiverChatId!);
    connectToServer();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    senderID = _prefs.getString(SharedPrefKeys.uidID) ?? '';
  }

  void connectToServer() {
    socket = IO.io(
        'http://localhost:3000/chat-aGhpamtsbW5vcHFyc3R1dnd4eXphYmNk',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
          'auth': {'userId': senderChatId}
        });

    socket.connect();

    socket.on('connect', (_) {
      socket.emit('register', {
        'userChatId': senderChatId,
        'name': senderName,
        'photoURL': senderImage,
      }); // Replace with actual user ID
    });

    socket.on('register_success', (_) {
      print("successfully conencted with server");
    });

    socket.on('error', (error) {
      print("got error $error while connecting to socket");
    });
  }

  void sendMessage(String message) {
    
    socket.emit('sendMessage', {
      'senderChatId': senderChatId,
      'receiverChatId': receiverChatId,
      'chatRoomId': currentChatRoomID,
      'messageText': message,
    });
     _controller.clear();
    update();
  }

  Future<void> sendFile(String senderID, String receiverID) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      try {
        Uint8List? bytesData = result.files.first.bytes;
        socket.emit('private message', {
          'senderId': senderID,
          'receiverId': receiverID,
          'message': 'Hello!',
          'file': bytesData
        });
      } catch (error) {
        print("Error: $error");
      }
    }
  }

  fetchUserChats(String? chatId) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    String? uid = _prefs.getString("uid");
    String? token = _prefs.getString(SharedPrefKeys.accessToken);
    print('${AppEnvironment.apiEnv}${APIStore.getUserChats}$chatId');
    // Uri.parse("${AppEnvironment.apiEnv}${APIStore.getUserChats}${chatId}")

    var response = await http.get(
      Uri.parse("${AppEnvironment.apiEnv}${APIStore.getUserChats}$chatId"),
      headers: {
        "Content-Type": "application/json",
        'authorization': 'Bearer $token',
        'uid': uid!
      },
    );
    if (response.statusCode == 201) {
      print(response);
    } else if (response.statusCode == 403) {}
  }

  @override
  void onClose() {
    socket.disconnect();
    super.onClose();
  }

  Future<List<String>> getChatsList() async {
    return [];
  }

  void createChatRoomId(String user1, String user2) {
    // Sort the IDs alphabetically
    List<String> ids = [user1, user2];
    ids.sort(); // This ensures that the order is consistent

    // Combine the sorted IDs into a single string
    String combinedId = ids[0] + '_' + ids[1];

    // Optionally, generate a hash for a shorter ID
    // You can use hashCode or other hash libraries (like md5, sha1, etc.)
    currentChatRoomID = combinedId.hashCode.toString();
  }
}
