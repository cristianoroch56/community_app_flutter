import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:community_app/constants/functions.dart';
import 'package:community_app/data/repositories/message_repository.dart';
import 'package:community_app/pages/chat_page/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/io.dart';

import '../../constants/responsive.dart';
import '../auth/authentication_manager.dart';
import '../message_page/model/message_model.dart';

class ChatPageController extends GetxController {
  MessageRepository? messageRepository;
  ChatPageController({this.messageRepository});
  RxList<MessageData> messages = <MessageData>[].obs;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  RxBool isEmpty = true.obs;
  RxBool isLoading = false.obs;

  IOWebSocketChannel? channel;
  RxInt count = 10.obs;
  int currPage = 1;
  RxBool nextPage = false.obs;
  RxBool isRead = false.obs;
  File? imagepicker;
  String? base64Image;
  String? imageurl;
  ThreadData? thread;

  @override
  void onInit() {
    thread = Get.arguments;
    log("${thread?.id}");
    messages.clear();
    getMessagesFunction();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (nextPage.value != false) {
          getMessagesFunction();
        }
      }
    });
    channel = IOWebSocketChannel.connect(
        Uri.parse('ws://projects.wappnet.us:8003/ws/chat/${thread?.id}/'),
        headers: {
          'authorization': "token ${AuthenticationManager().getToken()}"
        });
    super.onInit();
    channel!.stream.listen((message) {
      Map<String, dynamic> messageMap = json.decode(message);
      if (messageMap['message'] != null) {
        String messageText = messageMap['message'] ?? "";
        String image = messageMap['image'] ?? "";
        String sender = messageMap['sender']['username'] ?? "";
        final newMessage = MessageData(
          message: messageText,
          image: image,
          createdAt: DateTime.now().toUtc().toString(),
        );
        print("message1234::::::::$message");
        print("image1234::::::::$image");
        if (sender !=
            (AuthenticationManager().getUserId() == thread?.user1.toString()
                ? thread?.user1Data!.username
                : thread?.user2Data!.username)) {
          messages.add(newMessage);
          getMessagesFunction();
          update();
        }
      }
    });
  }

  @override
  void dispose() {
    channel?.sink.close();

    super.dispose();
  }

  void setMessageStatus(bool value) {
    isEmpty.value = value;
    update();
  }

  void sendMessage(String msg) async {
    final message = {
      'message': messageController.text,
    };
    channel?.sink.add(jsonEncode(message));
    messageController.clear();
    final newMessage = MessageData(
      message: msg,
      isRead: false,
      image: null,
      createdAt: DateTime.now().toUtc().toString(),
    );
    update();
    messages.add(newMessage);
    getMessagesFunction();
    update();
  }

  void sendImage(String? img) async {
    if (base64Image != null && base64Image!.isNotEmpty) {
      final image = {
        'image': "data:image/jpeg;base64,$base64Image",
      };
      channel?.sink.add(jsonEncode(image));
    }
    update();
    final newMessage = MessageData(
      image: img,
      message: null,
      isRead: false,
      createdAt: DateTime.now().toUtc().toString(),
    );
    messages.add(newMessage);
    getMessagesFunction();
    update();
  }

  MessageModel? messageModel;
  List<MessageData> messageData = [];
  getMessagesFunction() {
    if (messages == []) isLoading.value = true;
    update();
    messageRepository?.getMessages(
      param: {"thread_id": thread?.id, "page": 1},
    ).then((response) {
      if (response != null) {
        isLoading.value = false;
        update();
        if (response.statusCode == 200) {
          messages.clear();
          messageModel = MessageModel.fromJson(response.data);
          messageData = messageModel?.results?.data ?? [];
          log("calling::::::${response.data}");
          for (var msg in messageData) {
            if (messages.contains(msg)) {
              messages.removeWhere(
                (element) => element.id == msg.id,
              );
              update();
            } else {
              messages.insert(0, msg);
              update();
            }
          }
          count.value = messageModel?.count ?? 0;
          if (messageModel?.next != null) {
            currPage++;
            nextPage.value = true;
            update();
          }
          update();
        } else {
          log("Error: ${response.data}");
        }
      } else {
        isLoading.value = false;
        update();
      }
    });
  }

  // get more messages

  getMoreMessagesFunction() {
    isLoading.value = true;
    update();
    messageRepository?.getMessages(
      param: {"thread_id": thread?.id, "page": currPage},
    ).then((response) {
      if (response != null) {
        isLoading.value = false;
        update();
        if (response.statusCode == 200) {
          messageModel = MessageModel.fromJson(response.data);
          messageData = messageModel?.results?.data ?? [];
          messages.insertAll(0, messageData.reversed.toList());
          count.value = messageModel?.count ?? 0;
          if (messageModel?.next != null) {
            currPage++;
            nextPage.value = true;
            update();
          }
          update();
        } else {
          getSnackBar("", SNACK.FAILURE);
        }
      } else {
        isLoading.value = false;
        update();
      }
    });

    return true;
  }

  // update image
  Future pickImage(ImageSource imageType, BuildContext context) async {
    try {
      final pick = await ImagePicker().pickImage(source: imageType);
      if (pick != null) {
        File file = File(pick.path);
        imagepicker = file;
        imageurl = imagepicker?.path;
        final bytes = File(imagepicker!.path).readAsBytesSync();
        base64Image = base64Encode(bytes);
        showdialog(context);
        update();
      }
    } catch (e) {
      Error;
    }
  }

  /////////////////IMAGE DIALOG///////////////////////
  showdialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(dp(context, 20)),
              child: Image.file(
                imagepicker!,
                height: hp(50),
                width: wp(100),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: hp(3),
              right: wp(7),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    // ChatPageController controller =
                    //     Get.find<ChatPageController>();
                    // controller.getMessagesFunction();
                    sendImage(imagepicker!.path);
                    Get.back();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
